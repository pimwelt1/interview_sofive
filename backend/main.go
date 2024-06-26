package main

import (
	"context"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"unicode"

	aai "github.com/AssemblyAI/assemblyai-go-sdk"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"

	"database/sql"

	"github.com/lib/pq"
)

// cleanString removes all punctuation from the input string and converts it to lowercase.
func cleanString(s string) string {
	var sb strings.Builder
	// Iterate over each rune in the string.
	for _, r := range s {
		// If the rune is not a punctuation character, append it to the string builder.
		if !unicode.IsPunct(r) {
			sb.WriteRune(r)
		}
	}
	// Convert the result to lowercase and return it.
	return strings.ToLower(sb.String())
}

// video_to_audio uses ffmpeg to extract the audio from a video file.
func video_to_audio(inputVideoPath, outputAudioPath string) error {
	// Create a command to run ffmpeg with the specified input and output paths.
	cmd := exec.Command("ffmpeg", "-i", inputVideoPath, "-vn", outputAudioPath)

	// Run the command and check for errors.
	if err := cmd.Run(); err != nil {
		log.Fatalf("Failed to read video file in video_to_audio: %v", err)
		return err
	}
	return nil
}

// insertMetadata inserts metadata (title and duration) into the table metadata of the postgresql database.
func insertMetadata(db *sql.DB, title string, duration float64) error {
	// SQL query to insert the metadata.
	query := `INSERT INTO metadata (title, duration) VALUES ($1, $2)`

	// Execute the query with the provided title and duration.
	_, err := db.Exec(query, title, duration)
	if err != nil {
		return fmt.Errorf("insertMetadata: %v", err)
	}
	return nil
}

// insertWord inserts a word, the associated title and start time/end_time of the word in milliseconds into the table words of the postgresql database.
func insertWord(db *sql.DB, title string, word_id int, word string, start_time int64, end_time int64) error {
	// SQL query to insert the word data.
	query := `INSERT INTO words (title, word_id, word, start_time, end_time) VALUES ($1, $2, $3, $4, $5)`

	// Execute the query with the provided word data.
	_, err := db.Exec(query, title, word_id, word, start_time, end_time)
	if err != nil {
		return fmt.Errorf("insert word: %v", err)
	}

	return nil
}

// audio_to_text call insertMetadata and uses Assembly AI API to transcript the audio, then add each word in the database using insertWord
func audio_to_text(db *sql.DB, inputAudioFilePath, title string) error {

	// API key for Assembly AI.
	const YOUR_API_KEY = "0c7a16b85c454ebdab376dd04e07b1e5"
	client := aai.NewClient(YOUR_API_KEY)

	// Optional parameters for the transcription.
	params := &aai.TranscriptOptionalParams{
		SpeakerLabels: aai.Bool(true),
	}

	// Open the input audio file.
	f, err := os.Open(inputAudioFilePath)
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	// Transcribe the audio file.
	transcript, err := client.Transcripts.TranscribeFromReader(context.TODO(), f, params)
	if err != nil {
		log.Fatal(err)
	}

	// Get the duration of the audio.
	duration := *transcript.AudioDuration

	// Insert the metadata into the database.
	err = insertMetadata(db, title, duration)
	if err != nil {
		log.Fatalf("Failed to insert metadata: %v", err)
	}

	// Insert each word from the transcript into the database.
	for i, word := range transcript.Words {
		text := *word.Text
		cleantext := cleanString(text)
		start := *word.Start
		end := *word.End
		err = insertWord(db, title, i, cleantext, start, end)
		if err != nil {
			log.Fatalf("Failed to insert word: %v", err)
		}
	}
	return nil
}

// title_check checks if a given title already exists in the metadata table. The title is the primary key of the metadata table.
func title_check(db *sql.DB, title string) (int, error) {
	// SQL query to count the occurrences of the title.
	query := `SELECT count(*) FROM metadata WHERE title = $1`
	var count int
	// Execute the query and scan the result into count.
	err := db.QueryRow(query, title).Scan(&count)
	if err != nil {
		return -1, fmt.Errorf("query failed: %v", err)
	}
	return count, nil
}

// search_for_sentences searches if a sentence or keyword is in the table words for a given title.
func search_for_sentences(db *sql.DB, inputWords []string, inputTitle string) ([][2]int, error) {
	// SQL query to get word_id, start_time, and end_time for words matching the title and any of the input words.
	query := `SELECT word, word_id, start_time, end_time FROM words WHERE title = $1 AND word = ANY($2::text[])`

	log.Printf("Executing query: %s", query)
	log.Printf("With parameters: title=%s, words=%v", inputTitle, inputWords)

	// Execute the query with the input title and words.
	rows, err := db.Query(query, inputTitle, pq.Array(inputWords))
	if err != nil {
		return nil, fmt.Errorf("query failed: %v", err)
	}
	defer rows.Close()

	n := len(inputWords)
	if n <= 0 {
		return nil, nil
	}
	var results [][2]int
	var currentSeries [2]int
	var previousWordID int
	var count int

	// Iterate over the query results. WordID represent the position of the word in the audio (for a given title), so a sentence should have n consecutive words id
	for rows.Next() {
		var word string
		var wordID, startTime, endTime int
		if err := rows.Scan(&word, &wordID, &startTime, &endTime); err != nil {
			log.Fatalf("Scan error: %v", err)
		}

		if count == 0 && word == inputWords[count] {
			currentSeries = [2]int{startTime, endTime}
			count = 1
		} else {
			if wordID == previousWordID+1 && word == inputWords[count] {
				// Extend the current series if the word ID is consecutive.
				currentSeries[1] = endTime
				count++
			} else {
				// If the series length meets or exceeds the input words length, add it to the results. (results will contain the start time and end time of the sentence)
				if count >= n {
					results = append(results, [2]int{currentSeries[0], currentSeries[1]})
				}
				// Start a new series.
				currentSeries = [2]int{startTime, endTime}
				count = 1
			}
		}
		previousWordID = wordID
	}

	// Add the final series if it meets the required length.
	if count >= n {
		results = append(results, [2]int{currentSeries[0], currentSeries[1]})
	}

	return results, nil
}

// TitleCheck handles the HTTP request to check if a title exists in the database using the function title_check.
func TitleCheck(c *gin.Context, db *sql.DB) {

	//get the title from the http request
	title := c.Query("title")

	//to avoid any problem of path
	title = strings.ReplaceAll(title, "/", "")
	title = strings.ReplaceAll(title, "\\", "")
	if title == "" {
		c.JSON(http.StatusBadRequest, gin.H{"valid": false, "error": "Title is required"})
		return
	}
	count, err := title_check(db, title)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"valid": false, "error": "Database query error"})
		return
	}
	if count > 0 {
		c.JSON(http.StatusOK, gin.H{"valid": false, "error": "Title already exists"})
	} else {
		c.JSON(http.StatusOK, gin.H{"valid": true})
	}
}

// MP4Handler handles the HTTP request to upload an MP4 file, convert it to audio, and store the metadata and transcription.
func MP4Handler(c *gin.Context, db *sql.DB) {
	if err := c.Request.ParseMultipartForm(10 << 20); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Error parsing form"})
		return
	}

	//get the title from the http request
	title := c.Request.FormValue("title")

	//to avoid any problem of path
	title = strings.ReplaceAll(title, "/", "")
	title = strings.ReplaceAll(title, "\\", "")

	VideoPath := filepath.Join("./react-app/public/videos", title+".mp4")
	AudioPath := filepath.Join("./react-app/public/audios", title+".mp3")

	if title == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Title is required"})
		return
	}

	//get the file from the http request
	file, _, err := c.Request.FormFile("file")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Error getting file from form"})
		return
	}
	defer file.Close()

	//Create the file to store the Video
	out, err := os.Create(VideoPath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to create the file"})
		return
	}
	defer out.Close()

	//Copy the video
	_, err = io.Copy(out, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to save the file"})
		return
	}

	//Convert the video to audio using video_to_audio.
	if err := video_to_audio(VideoPath, AudioPath); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error converting video to audio"})
		return
	}

	//Transcript the audio and store the data using audio_to_text.
	if err := audio_to_text(db, AudioPath, title); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error converting audio to text and storing in database"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "MP4 file processed successfully",
	})
}

// searchHandler handles the HTTP request to search for a specifique sentence or keyword for a given title.
func searchHandler(c *gin.Context, db *sql.DB) {

	//get the title
	title := c.Query("title")

	//get the sentence or keyword
	sentence := c.Query("sentence")

	if title == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Title is required"})
		return
	}

	if sentence == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Keywords are required"})
		return
	}

	//convert the string sentence into an array of words
	words := strings.Fields(sentence)

	//get the start time and end time of each time the sentence or keyword was found.
	results, err := search_for_sentences(db, words, title)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to perform search operation"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"results": results,
	})
}

func main() {

	//connect to the database
	connStr := "user=plm2136 dbname=sofive_interview sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	r := gin.Default()

	r.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:3000"},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
	}))

	//route to check if the title is already on the database
	r.GET("check-title", func(c *gin.Context) {
		TitleCheck(c, db)
	})

	//route to process the mp4 file
	r.POST("/process-mp4", func(c *gin.Context) {
		MP4Handler(c, db)
	})

	//route to get the list of evey videos uploaded with path.
	r.GET("/get-videos", func(c *gin.Context) {
		videoDir := "./react-app/public/videos"
		dirEntries, err := os.ReadDir(videoDir)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to read directory"})
			return
		}

		var videos []gin.H

		for _, entry := range dirEntries {
			if !entry.IsDir() && filepath.Ext(entry.Name()) == ".mp4" {
				videos = append(videos, gin.H{
					"name": strings.TrimSuffix(entry.Name(), filepath.Ext(entry.Name())),
					"url":  "/videos/" + entry.Name(),
				})
			}
		}

		c.JSON(http.StatusOK, videos)
	})

	//route for sentence or keyword search
	r.GET("/search-sentences", func(c *gin.Context) {
		searchHandler(c, db)
	})

	if err := r.Run(":8000"); err != nil {
		log.Fatal(err)
	}
}
