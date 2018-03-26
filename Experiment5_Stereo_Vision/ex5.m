%% Read image and preprocess
% I1 = im2double(imread('shrimp_left.jpg'));
% I2 = im2double(imread('shrimp_right.jpg'));
I1 = im2double(imread('left382.jpg'));
I2 = im2double(imread('right382.jpg'));

%% Calculate disparity
delta = 250;
window_width = 2;
window_height = 3;
disparity = correlation_match(I1, I2, window_width, window_height, delta);
imshow(disparity, [])   