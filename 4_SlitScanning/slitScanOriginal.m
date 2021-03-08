function videoOut   = slitScanOriginal()
% function videoOut   = slitscan(varargin)
% Process video simulating a slit-scan camera.
% SYNTAX
% videoOut          = slitscan(videoIn, nLinesPerScan, direction, nLoops,...
%                               displayVideo, saveVideo)
% INPUTS
% fileName          File name of the video to modify 
% nLinesPerScan     Number of lines per scan. The less lines the smoother video
%                   is. Default is 5.
% direction         Is the direction the delay increases in. 
%                   'BottomToTop' means that the bottom line is behind the top
%                   by a number of frames equal to the height of the clip.
%                   'TopToBottom' means that the top line is behind the bottom
%                   by a number of frames equal to the height of the clip.
%                   Default is 'TopToBottom'.
% nLoops            Number of times to repeat original video. Default is 1.
% displayVideo      Open a figure where the slit-scan video is played. Default
%                   true.
% saveVideo         Save the modified video as a new file '_slitscan' is added 
%                   to the file name. Default false.
% OUTPUT 
% videoOut          Video structure
%_______________________________________________________________________________
% Copyright (C) 2013 Edgar Guevara Codina
%_______________________________________________________________________________

fileName = 'C:\Users\lopez\Desktop\Vision\Videos\prueba3.mp4';
nLinesPerScan = 5;
direction = 'TopToBottom';
nLoops = 1;               
displayVideo = false;
saveVideo = false;
     

%% Read video file
videoObj            = VideoReader(fileName);
nFrames             = videoObj.NumberOfFrames;
vidHeight           = videoObj.Height;
vidWidth            = videoObj.Width;

% Preallocate structure movIn
movIn(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
% Read one frame at a time.
for iFrames         = 1:nFrames
    movIn(iFrames)...
        .cdata      = readFrame(videoObj);
    movIn(iFrames)...
        .colormap   = [];
end

%% Slit-scan processing
videoIn             = repmat(movIn,[1 nLoops]);
nFrames             = numel(videoIn);
% cleanup
clear movIn
% circular buffer (FIFO). Size of buffer depends on images resolutions and lines
% per scan
bufferSize          = round(vidHeight/nLinesPerScan);
% Calculate vertical position
topIdx              = 1:nLinesPerScan:vidHeight-nLinesPerScan;
bottomIdx           = topIdx + nLinesPerScan;
switch direction
    case 'TopToBottom'
        % Do nothing
    case 'BottomToTop'
        topIdx      = fliplr(topIdx);
        bottomIdx   = fliplr(bottomIdx);
    otherwise
        % Do nothing
end
% Initialize buffer
if bufferSize       > nFrames
    bufferSize      = nFrames;
end
circBuff            = videoIn(1:bufferSize);
% Initialize output
videoOut            = videoIn;



fprintf('Slit-scanning processing...\n');
for lastFrame       = 1:nFrames;
    thisBuffer      = rem(lastFrame, bufferSize);
    % Extract n number of lines from previous images. Use extracted lines to
    % construct the slit scan image, by placing them in the relevent vertical
    % location
    for iBuffer     = 1:thisBuffer,
        videoOut(lastFrame).cdata(topIdx(iBuffer):bottomIdx(iBuffer),:,:)...
                    = circBuff(iBuffer).cdata(topIdx(iBuffer):bottomIdx(iBuffer),:,:);
    end
    % Update circular buffer (FIFO)
    circBuff        = [circBuff(2:end) videoOut(lastFrame)];
end
fprintf('Slit-scanning done!\n');
