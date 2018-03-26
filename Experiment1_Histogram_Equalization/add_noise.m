function result = add_noise(pic, option)
result = pic;
if strcmp(option, 'salt & pepper')
    result = imnoise(pic, 'salt & pepper');
elseif strcmp(option, 'impulse')
    for i = 1 : size(pic, 1)
        for j = 1 : size(pic, 2)
            if rand() < 0.02 
                result(i, j) = 255;
            end
        end
    end
elseif strcmp(option, 'gaussian')
    result = imnoise(pic, 'gaussian');
end
end