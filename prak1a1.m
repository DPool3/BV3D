clc
clear
close all hidden

% webcamlist;
% 
% cam = webcam('Lenovo EasyCamera');
% 
% % Aufgabe 1
% path = "D:/Program Files/MATLAB/R2019b/toolbox/vision/visiondata/TestImages/";
% 
% %cam.Focus = 20;
% 
% for i=1:1:10
%     
%     img = snapshot(cam);
%     imshow(img);
%     filename = path + "image" + i + ".png";
%     imwrite(img,filename);
%     pause;
%     
% end
% 
% close all;
% 
%  imgfolder = fullfile(toolboxdir('vision'),'visiondata', 'TestImages');
%  imgSet = imageSet(imgfolder);
% % 
% % imshow(read(imgSet,1));
% % title('ImageSet Test image1');
% % pause;
% 
% close all;
% 
% [imagePoints,boardSize] = detectCheckerboardPoints(imgSet.Files); %was ist imageFiles
% squareSizeInMM = 25.4; % Size of checkerboard squares
% worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);
% I = readimage(imgSet,1);
% imageSize = [size(I, 1),size(I, 2)];
% params = estimateCameraParameters(imagePoints,worldPoints,'EstimateSkew', true);
% figure;
% showReprojectionErrors(params);
% figure;
% showExtrinsics(params);
% 
% pause;
% close all;

%Stereo Kalibrierung

clear;
% camLeft = webcam(1);
% camRight = webcam(3);
% 
% camLeft.Focus = 20;
% camRight.Focus = 20;

pathLeft = "D:/Program Files/MATLAB/R2019b/toolbox/vision/visiondata/StereoLeft/";
pathRight = "D:/Program Files/MATLAB/R2019b/toolbox/vision/visiondata/StereoRight/";

% for i=1:1:10
%     
%     pause;
%     
%     imgLeft = snapshot(camLeft);
%     imgRight = snapshot(camRight);
%     
%     imshowpair(imgLeft,imgRight,'montage');
%     
%     filenameLeft = pathLeft + "image" + i + ".png";
%     filenameRight = pathRight + "image" + i + ".png";
%     
%     imwrite(imgLeft,filenameLeft);
%     imwrite(imgRight,filenameRight);
%     
% end

close all;

imgfolderLeft = fullfile(toolboxdir('vision'),'visiondata', 'StereoLeft');
imgSetLeft = imageSet(imgfolderLeft);

imgfolderRight = fullfile(toolboxdir('vision'),'visiondata', 'StereoRight');
imgSetRight = imageSet(imgfolderRight);


[imagePoints,boardSize] = detectCheckerboardPoints(imgSetLeft.Files, imgSetRight.Files); %was ist imageFiles
squareSizeInMM = 25.4; % Size of checkerboard squares
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);

I1 = readimage(imgSetLeft,1);
I2 = readimage(imgSetRight,1);
imageSize = [size(I1, 1),size(I2, 2)];

params = estimateCameraParameters(imagePoints,worldPoints,'EstimateSkew', true);

figure;
showReprojectionErrors(params);

figure;
showExtrinsics(params);

stereoParams = estimateCameraParameters(imagePoints,worldPoints,'ImageSize',imageSize);
    
[J1_full,J2_full] = rectifyStereoImages(I1,I2,stereoParams,'OutputView','full');

figure; 
imshow(stereoAnaglyph(J1_full,J2_full));





