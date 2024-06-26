import React, { useCallback, useState } from 'react';
import './App.css';
import axios from 'axios';
import { useDropzone } from 'react-dropzone';
import VideoList from './Videos.js';

function App() {
  const [title, setTitle] = useState('');
  const [titleValid, setTitleValid] = useState(false);

  // Handle the submission of the title to check its validity
  const handleSubmit = async () => {
    try {
      // Send a GET request to check if the title is valid
      const response = await axios.get(`http://localhost:8000/check-title?title=${title}`);
      if (response.data.valid) {
        alert(`Title ${title} is valid`);
        setTitleValid(true); // Set title validity to true if the title is valid
      } else {
        alert('Title is already used');
        setTitleValid(false); // Set title validity to false if the title is already used
      }
    } catch (error) {
      alert('A problem happened');
      console.error('Error checking title: ', error);
      setTitleValid(false); // Set title validity to false if there is an error
    }
  };

  // Handle the file drop event
  const onDrop = useCallback(async (acceptedFiles) => {
    const file = acceptedFiles[0];
    const formData = new FormData();
    formData.append('file', file);
    formData.append('title', title);

    try {
      console.log('Title', formData.get('title'));
      // Send a POST request to upload the file and process the MP4
      const response = await axios.post('http://localhost:8000/process-mp4', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
      if (response.data.message == 'MP4 file processed successfully'){
        alert('File uploaded successfully');
      }
    } catch (error) {
      alert('A problem happened, Please try again later');
      console.error('Error uploading file: ', error);
    }
  }, [title]);

  // Get props from useDropzone to handle drag-and-drop functionality
  const { getRootProps, getInputProps } = useDropzone({ onDrop, accept: 'video/mp4' });

  return (
    <div className="App">
      <div className='drop-container'>
        <input
          type="text"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Enter title to drop file"
        />
        <button onClick={handleSubmit}>Set Title</button>
      </div>
      
      {titleValid && (
      <div {...getRootProps({ className: 'dropzone' })}>
        <input {...getInputProps()} />
        <p>Drop your MP4 files here</p>
      </div>
      )}
      <VideoList />
    </div>
  );
}

export default App;

