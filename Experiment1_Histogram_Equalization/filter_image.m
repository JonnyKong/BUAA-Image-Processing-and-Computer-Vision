function result = filter_image(img, option)
result = img;
if strcmp(option, 'average')
    result = uint8(filter2(fspecial('average'), img));
elseif strcmp(option, 'median')
    result = medfilt2(img);
end
end