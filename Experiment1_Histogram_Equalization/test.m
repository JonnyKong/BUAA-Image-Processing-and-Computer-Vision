clear;
img = imread('G:\Desktop\สตั้าป\dog.bmp');
figure;
imshow(img);
img0 = rgb2gray(img);
figure;
imshow(img0);
img1 = im2double(img0);