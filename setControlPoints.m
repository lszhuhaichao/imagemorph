clear;
close all;

I1 = imread('brad.png');
I2 = imread('bryan.png');
global cp1;
global cp2;

global handles;

cp1 = [];
cp2 = [];

handles = [];

h = figure(1);
subplot(1,2,1);
hold on;
imshow(I1);
subplot(1,2,2);
hold on;
imshow(I2);
set(h,'windowbuttondownfcn',{@getpoint});