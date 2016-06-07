clear;
close all;

I1 = imread('brad.png');     %% read the first image
I2 = imread('bryan.png');     %% read the second image
output_name = 'bradbryan';
load('bradbryan.mat');             %% Point Correspondence 
figure(1);
subplot(1,2,1);
hold on;
imshow(I1);
subplot(1,2,1);
plot(cp1(:,1),cp1(:,2),'go');
subplot(1,2,2);
imshow(I2);
hold on;
plot(cp2(:,1),cp2(:,2),'*');

n_step = 50;

kernel = @thin_plate_spline;

morphImage(I1,I2, cp1,cp2, n_step, output_name,kernel);