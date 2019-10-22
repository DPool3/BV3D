clc
clear
close all hidden

webcamlist;

cam = webcam('Lenovo EasyCamera');

% Aufgabe 1
path = "D:/Program Files/MATLAB/R2019b/toolbox/vision/visiondata/TestImages/";

%cam.Focus = 20;

for i=1:1:10
    
    img = snapshot(cam);
    imshow(img);
    filename = path + "image" + i + ".png";
    imwrite(img,filename);
    pause;
    
end

close all;

 imgfolder = fullfile(toolboxdir('vision'),'visiondata', 'TestImages');
 imgSet = imageSet(imgfolder);
% 
% imshow(read(imgSet,1));
% title('ImageSet Test image1');
% pause;

close all;

[imagePoints,boardSize] = detectCheckerboardPoints(imgSet.Files); %was ist imageFiles
squareSizeInMM = 25.4; % Size of checkerboard squares
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);
I = readimage(imgSet,1);
imageSize = [size(I, 1),size(I, 2)];
params = estimateCameraParameters(imagePoints,worldPoints,'EstimateSkew', true);
figure;
showReprojectionErrors(params);
figure;
showExtrinsics(params);


