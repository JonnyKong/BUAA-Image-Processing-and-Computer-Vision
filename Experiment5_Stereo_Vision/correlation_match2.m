%% Load images
run('~/Documents/Matlab/vlfeat-0.9.20/toolbox/vl_setup')
I_left = single(rgb2gray(imread('shrimp_left.jpg')));
I_right = single(rgb2gray(imread('shrimp_right.jpg')));

%% SIFT match
[f_left, d_left] = vl_sift(I_left);
[f_right, d_right] = vl_sift(I_right);
[matches, scores] = vl_ubcmatch(d_left, d_right);

%% Draw sift match
I = [imread('shrimp_left.jpg'), imread('shrimp_right.jpg')];
% I = imread('shrimp_left.jpg');
imshow(I)
% perm = randperm(size(f_left, 2));
% sel = perm(1 : 500);
% h1 = vl_plotframe(f_left(:, sel));
% h2 = vl_plotframe(f_left(:, sel));
% h1 = vl_plotframe(f_left);
% h2 = vl_plotframe(f_left);
% set(h1,'color','k','linewidth',3);
% set(h2,'color','y','linewidth',2);

offset = [size(I_left, 2), 0, 0, 0]';
for i = 1 : size(matches, 2)
    h1 = vl_plotframe(f_left(:, matches(1, i)));
    h2 = vl_plotframe(f_left(:, matches(1, i)));
    set(h1,'color','k','linewidth',3);
    set(h2,'color','y','linewidth',2);
    h3 = vl_plotframe(f_right(:, matches(2, i)) + offset);
    h4 = vl_plotframe(f_right(:, matches(2, i)) + offset);
    set(h3,'color','k','linewidth',3);
    set(h4,'color','y','linewidth',2);
    if(abs(f_left(2, matches(1, i)) - f_left(2, matches(2, i))) < 200)
        line([f_left(1, matches(1, i)), f_right(1, matches(2, i)) + size(I_left, 2)], [f_left(2, matches(1, i)), f_left(2, matches(2, i))], 'linewidth', 1)
    end
end

%% Correlation-match on the left image
% Create the disparity vector 
figure(2)
pos_x = [];
pos_y = [];
disparity = [];
cnt = 0;
for i = 1 : size(matches, 2)
    dis = abs(f_left(1, matches(1, i)) - f_right(1, matches(2, i)));
    if(dis < 50)
        cnt = cnt + 1;
        try
            pos_x = [pos_x, f_left(1, matches(1, i))];
        catch ME
            pos_x = f_left(1, matches(1, i));
        end
        try
            pos_y = [pos_y, f_left(2, matches(1, i))];
        catch ME
            pos_y = f_left(2, matches(1, i));
        end
        try
            disparity = [disparity, dis];
        catch ME
            disparity = dis;
        end
    end
end

% Meshgrid interpolation
[xq, yq] = meshgrid(1 : size(I_left, 2), 1 : size(I_left, 1));
disparity_interpolated = griddata(pos_x, pos_y, disparity, xq, yq);
imshow(disparity_interpolated, [])