clc
clear
close all hidden

webcamlist;

cam = webcam('Lenovo EasyCamera');

% Aufgabe 2

orig = snapshot(cam);

gray = rgb2gray(orig);
f2 = figure;
imshowpair(orig,gray,'montage');
title('Grau');
pause;
close(f2);

gaus = imgaussfilt(orig, 5);
f3 = figure;
imshowpair(orig,gaus,'montage');
title('Gauss');
pause;
close(f3);

sigma = 0.4;
alpha = 0.5;
laplace = locallapfilt(orig,sigma,alpha);
f4 = figure;
imshowpair(orig,laplace,'montage');
title('laplace');
pause;
close(f4);

h = fspecial('sobel');
v = h';
vh = h*v;
sobel = imfilter(orig,vh);
f5 = figure;
imshowpair(orig,sobel,'montage');
title('Sobel');
pause;
close(f5);

canny = edge(gray,'canny');
f6 = figure;
imshowpair(orig,canny,'montage');
title('Canny Edge');
pause;
close(f6);

boardImage = checkerboard;
corners = detectHarrisFeatures(boardImage);
f7 = figure;
imshow(boardImage); 
hold on;
plot(corners.selectStrongest(50));
pause;
close all;
