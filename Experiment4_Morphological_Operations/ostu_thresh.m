function thresh_level = ostu_thresh(a)
% a = rgb2gray(a);
[m, n] = size(a);
resolution = m * n;
greylevel_list = zeros(1, 256);

% Count greylevel occurences
for i = 1 : m
    for j = 1 : n
        greylevel_list(a(i, j)) = greylevel_list(a(i, j)) + 1;
    end
end
% Calculate total average
mean_total = 0;
for i = 1 : 256
    mean_total = mean_total + i * greylevel_list(i);
end
mean_total = mean_total / resolution;

stddev_max = 0;
thresh_level = 0;
w0 = 0;
w1 = 1;
mean_0_unregularized = 0;
mean_1_unregularized = mean_total;
for thresh = 1 : 255
    w0 = w0 + greylevel_list(thresh) / resolution;
    w1 = w1 - greylevel_list(thresh) / resolution;
    mean_0_unregularized = mean_0_unregularized + thresh * greylevel_list(thresh) / resolution;
    mean_1_unregularized = mean_1_unregularized - thresh * greylevel_list(thresh) / resolution;
    if(w0 ~= 0)
        mean_0 = mean_0_unregularized / w0;
    else
        mean_0 = 0;
    end
    if(w1 ~= 0)
        mean_1 = mean_1_unregularized / w1;
    else
        mean_1 = 0;
    end
    stddev = w0 * w1 * (mean_0 - mean_1) ^ 2;
    if(stddev > stddev_max)
        stddev_max = stddev;
        thresh_level = thresh;
    end
end
thresh_level = thresh_level / 256;
end