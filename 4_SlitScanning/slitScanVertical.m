function slitScanVertical()
  fileName = 'C:\Users\lopez\Desktop\Vision\Videos\prueba5.mp4';
  nLinesPerScan = 5;
  
  %% Read video file
  videoObj            = VideoReader(fileName);
  nFrames             = videoObj.NumberOfFrames;
  vidHeight           = videoObj.Height;
  vidWidth            = videoObj.Width;

  % Preallocate structure movIn
  videoIn(1:nFrames) = struct('frame', zeros(vidHeight, vidWidth, 3, 'uint8'));
  
  % Read one frame at a time.
  for iFrames = 1:nFrames
    videoIn(iFrames).frame = readFrame(videoObj);
  end
  
  % circular buffer (FIFO). Size of buffer depends on images resolutions ...
  % and lines per scan
  bufferSize          = round(vidHeight/nLinesPerScan);
  circBuff            = videoIn(1:bufferSize);
  
  % Calculate vertical position
  topIdx              = 1:nLinesPerScan:vidHeight-nLinesPerScan;
  bottomIdx           = topIdx + nLinesPerScan;
  
  % Initialize output
  videoOut            = videoIn;
  
  fprintf('Slit-scanning processing...\n');
  for lastFrame       = bufferSize:nFrames;
    thisBuffer      = rem(lastFrame, bufferSize);
    % Extract n number of lines from previous images. Use extracted lines to
    % construct the slit scan image, by placing them in the relevent vertical
    % location
    for iBuffer     = 1:thisBuffer,
      videoOut(lastFrame).frame(topIdx(iBuffer):bottomIdx(iBuffer),:,:)...
          = circBuff(iBuffer).frame(topIdx(iBuffer):bottomIdx(iBuffer),:,:);
    end
    % Update circular buffer (FIFO)
    circBuff        = [circBuff(2:end) videoOut(lastFrame)];
  end
  
  
  % Print the video as an animation
  fprintf('Ready. Now Playing video...\n');
  tmp = [];
  for i=1:nFrames
    frame = videoOut(i).frame;
     if (isempty (tmp))
       tmp = image (frame);
     else
       set (tmp, "cdata", frame);
     endif
     pause(0.03);
     drawnow
  endfor
  
  fprintf('Slit-scanning done!\n');
endfunction
