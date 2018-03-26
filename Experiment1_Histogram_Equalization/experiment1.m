clear all;
clc;

disp('...Adding Noise to Image')
figure(1)
img = imread('data/lena.bmp');
imshow(img);
title('Original Image');
pause();

figure(2)
set(gcf,'position',[10,10,555,445]);
img_noise = add_noise(img, 'salt & pepper');
imshow(img_noise);
title('Salt & Pepper');
pause()

figure(2)
img_noise = add_noise(img, 'impulse');
imshow(img_noise);
title('Impulse');
pause()

figure(2)
img_noise = add_noise(img, 'gaussian');
imshow(img_noise);
title('Gaussian');
pause()

close all;
disp('...Filtering image with salt & pepper noise')
figure(1)
image_to_filter = add_noise(img, 'salt & pepper');
imshow(image_to_filter);
title('Original Image')

figure(2)
set(gcf,'position',[10,10,555,445]);
filtered_image = filter_image(image_to_filter, 'average');
imshow(filtered_image);
title('Average Filtering')
pause()

figure(2)
filtered_image = filter_image(image_to_filter, 'median');
imshow(filtered_image);
title('Median Filtering')
pause()

clear all;
disp('...Histogram Equalizing')
figure(1)
original_image = imread('data/landscape.jpg');
imshow(original_image);
title('Original Image');

set(gcf,'position',[10,10,555,445]);
equalized_image = histogram_equalization(original_image);
figure(2)
imshow(equalized_image);
title('Histogram Equalized Image via RGB');
figure(3)
subplot(3, 1, 1)
imhist(equalized_image(:,:,1));
title('Histogram Equalized Image via RGB(R)')
subplot(3, 1, 2)
imhist(equalized_image(:,:,2));
title('Histogram Equalized Image via RGB(G)')
subplot(3, 1, 3)
imhist(equalized_image(:,:,3));
title('Histogram Equalized Image via RGB(B)');
pause()

close all;
equalized_image = rgb2ycbcr(original_image);
equalized_image(:, :, 1) = histogram_equalization(equalized_image(:, :, 1));
equalized_image = ycbcr2rgb(equalized_image);
figure(2)
imshow(equalized_image);
title('Histogram Equalized Image via YCbCr(Y)');
figure(3)
imhist(equalized_image(:, :, 1));
title('Histogram Equalized Image via YCbCr');