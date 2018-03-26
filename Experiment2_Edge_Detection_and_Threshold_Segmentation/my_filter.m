function result = my_filter(image, filter)
if(strcmp(filter,'laplace'))
    filter = [0 1 0; 1 -4 1; 0 1 0];
elseif(strcmp(filter, 'sobel'))
    filter = [1 2 1; 0 0 0; -1 -2 -1];
elseif(strcmp(filter, 'kirch'))
    filter = [3 3 3; 3 0 3; -5 -5 -5];
end
image = im2double(imread(image));
filter_size = size(filter, 1);
result = zeros(size(image, 1) - (filter_size - 1), size(image, 2) - (filter_size - 1));

for i = 1 : size(result, 1)
    for j = 1 : size(result, 2)
        tmp = 0;
        for m = 1 : filter_size
            for n = 1 : filter_size
                tmp = tmp + filter(m, n) * image(i + m - 1, j + n - 1);
            end
        end
        result(i, j) = tmp;
    end
end
end