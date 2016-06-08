clear;
close all;

I1 = imread('bryan.jpg');     %% read the first image
I2 = imread('jim2.jpg');     %% read the second image
output_name = 'brycarrey';
load('brycarrey.mat');             %% Point Correspondence 
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

n_step = 3;

kernel = @thin_plate_spline;

morphImage(I1,I2, cp1,cp2, n_step, output_name,kernel);