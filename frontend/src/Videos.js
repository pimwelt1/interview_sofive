import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './Video.css';
import VideoSegments from './VideoSegments'

const VideoList = () => {
  // State variables
  const [videoFiles, setVideoFiles] = useState([]); // To store the list of video files
  const [selectedVideo, setSelectedVideo] = useState(null); // To store the currently selected video
  const [searchKeywords, setSearchKeywords] = useState(''); // To store the search keywords entered by the user
  const [searchTimes, setSearchTimes] = useState([]); // To store the search results (times) for keywords

  // Fetch video files when the component mounts
  useEffect(() => {
    fetchVideoFiles();
  }, []);

  // Function to fetch video files from the server
  const fetchVideoFiles = async () => {
    try {
      const response = await axios.get('http://localhost:8000/get-videos');
      setVideoFiles(response.data);
      console.log('fetchVideo Response', response.data);
    } catch (error) {
      console.error('Error fetching video files:', error);
    }
  };

  // Function to fetch the start and end times of segments containing the keywords
  const fetchKeywordsTimes = async (sentence) => {
    try {
      const response = await axios.get(`http://localhost:8000/search-sentences?title=${selectedVideo.name}&sentence=${sentence}`);
      console.log('FetchKeywords Response', response.data.results);
      if (response.data.results) {
        const segments = response.data.results.map(innerArray =>
          innerArray.map(number => number / 1000) // Convert milliseconds to seconds
        );
        setSearchTimes(segments); // Update state with the search results
      } else {
        alert("Didn't find any part with the given keyword(s)");
      }
    } catch (error) {
      console.error('Error fetching keywords:', error);
    }
  };

  // Function to set the selected video
  const playVideo = (video) => {
    setSelectedVideo(video);
  };

  // Function to handle the search form submission
  const handleSubmitSearchKeywords = (event) => {
    event.preventDefault();
    let sentence = searchKeywords;
    sentence = sentence.replace(/[^\w\s]/g, '').toLowerCase(); // Clean the sentence
    fetchKeywordsTimes(sentence); // Fetch times for the cleaned sentence
    console.log('Submitted text:', sentence);
  };

  // Function to handle changes in the search input field
  const handleChangeSearchKeywords = (event) => {
    setSearchKeywords(event.target.value);
  };

  return (
    <div className='container'>
      {videoFiles && (
        <div className='list-videos'>
          <h2>Video List</h2>
          <ul>
            {videoFiles.map((video, index) => (
              <li key={index} onClick={() => playVideo(video)} className='video-list-item'>
                {video.name}
              </li>
            ))}
          </ul>
        </div>
      )}
      <div className='current-video'>
        {selectedVideo && (
          <div>
            <h3>Selected Video</h3>

            {searchTimes.length > 0 ? (
              <VideoSegments segments={searchTimes} videoSrc={selectedVideo} />
            ) : (
              <video width="640" height="360" controls autoPlay>
                <source src={process.env.PUBLIC_URL + selectedVideo.url} type="video/mp4" />
                Your browser does not support the video tag.
              </video>
            )}

            <form onSubmit={handleSubmitSearchKeywords}>
              <input
                type="text"
                value={searchKeywords}
                onChange={handleChangeSearchKeywords}
                placeholder="Search Keyword/Sentence..."
              />
              <button type="submit">Submit</button>
            </form>
          </div>
        )}
      </div>
    </div>
  );
};

export default VideoList;

