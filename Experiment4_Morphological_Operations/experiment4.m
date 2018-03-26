%% Filter Image
img = imread('cell2.bmp');
img = rgb2gray(img);
img = filter_image(img, 'openclose');
figure(1)
imshow(img)
title('Open-close Filtered Image')

%% Threshold Segmentation
threshold = graythresh(img) - 5 / 256;
mask = (im2bw(img, threshold) == 0);
se = strel('disk', 8);
% Eliminate noises
mask = imopen(mask, se);
figure(2)
imshow(mask == 0)

%% Tag the cells
cc = bwconncomp(mask);
L = bwlabel(mask);

%% Threshold Segmentation of the cells
core = zeros(size(L));
for i = 1 : cc.NumObjects
    threshold = graythresh(img(L == i)) - 15 / 256;
    core = core + (im2bw(img, threshold) == 0) .* (L == i);
end
% threshold = graythresh(img(mask));
% core = im2bw(img, threshold) == 0;
% core = core .* mask;
figure(3)
imshow(core == 0)
% Show cell and core together
result = 1 - mask + core * 0.5;
figure(4)
imshow(result)

%% Label the cells
s = regionprops(L,'centroid');
centroids = cat(1, s.Centroid);
figure(5)
imshow(result)
hold on
for i = 1 : size(centroids, 1)
%     str = ['\leftarrow ', num2str(i)];
    str = num2str(i);
    text(centroids(i, 1), centroids(i, 2), str, 'Color', 'Yellow', 'Fontsize', 13, 'HorizontalAlignment', 'center')
end


%% Calculate the proportion of cells, write to excel
value = [];
s = regionprops(L,'centroid');
centroids = cat(1, s.Centroid);
for i = 1 : cc.NumObjects
    cell_cnt = sum(mask(L == i));
    core_cnt = sum(core(L == i));
    ratio = core_cnt / cell_cnt;
    value = [value; i, cell_cnt core_cnt, ratio, centroids(i, 1), centroids(i, 2)];
end
xlswrite('result.xlsx', value);