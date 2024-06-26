import React, { useState, useRef, useEffect } from 'react';

const VideoPlayer = ({ segments, videoSrc }) => {

  const [currentSegment, setCurrentSegment] = useState(0);
  const videoRef = useRef(null);

  useEffect(() => {
    setCurrentSegment(0);
  }, [segments]);

  useEffect(() => {
    if (currentSegment < segments.length) {
        const video = videoRef.current;

        const handleTimeUpdate = () => {
        const { start, end } = segments[currentSegment];
        if (video.currentTime >= end) {
            video.pause();
            video.currentTime = start;
        }
        };

        video.addEventListener('timeupdate', handleTimeUpdate);
        return () => {
        video.removeEventListener('timeupdate', handleTimeUpdate);
        };
    }
  }, [currentSegment, segments]);

  useEffect(() => {
    if (currentSegment < segments.length){
        const video = videoRef.current;
        const start = segments[currentSegment][0];
        video.currentTime = start;
        video.play();
    }
  }, [currentSegment, segments]);

  const handlePrev = () => {
    setCurrentSegment((prev) => Math.max(prev - 1, 0));
  };

  const handleNext = () => {
    setCurrentSegment((prev) => Math.min(prev + 1, segments.length - 1));
  };

  return (
    <div>
      <video width="640" height="360" controls autoPlay ref={videoRef} src={videoSrc.url} />
      <div>
        <button onClick={handlePrev} disabled={currentSegment === 0}>
          Prev
        </button>
        <button onClick={handleNext} disabled={currentSegment === segments.length - 1}>
          Next
        </button>
      </div>
    </div>
  );
};

export default VideoPlayer;