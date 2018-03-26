function result = histogram_equalization(img)
result = img;
for k = 1 : size(img, 3)
    num = zeros(1, 256);
    total_pixels = size(img, 1) * size(img, 2);
    % Calculate accumulated greyscale
    for i = 1 : size(img, 1)
        for j = 1 : size(img, 2)
            num(img(i, j, k) + 1) = num(img(i, j, k) + 1) + 1;
        end
    end
    for i = 2 : 256
        num(i) = num(i - 1) + num(i);
    end
    for i = 1 : size(img, 1)
        for j = 1 : size(img, 2)
            result(i, j, k) = round(255 * num(img(i, j, k) + 1) / total_pixels);
        end
    end
end
end