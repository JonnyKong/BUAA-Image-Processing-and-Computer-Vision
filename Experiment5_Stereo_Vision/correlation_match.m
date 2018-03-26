function disparity = correlation_match(I1, I2, window_width, window_height, delta)
assert(size(I1, 1) == size(I2, 1) && size(I1, 2) == size(I2, 2), 'Image size not match')
[height, width, ~] = size(I1);

% Initialize the disparity matrix
disparity = zeros(height - window_height, width - window_width);

% Scan every row
for k = 1 : height - window_height + 1
    % Scan each column
    for j = delta + 1 : width - window_width
        % Check each possible disparity
        dbest = delta;
        window1 = I1(k : k + window_height - 1, j : (j + window_width) - 1, :);
        for d = 0 : delta
            % Sample the windows
            window2 = I2(k : k + window_height - 1, (j - d) : (j - d + window_width) - 1, :);
            % Calculate disparity for each case
            window = abs(window1 - window2);
            c = sum(window(:));
            if(c < 1)
%             if(c < 0.5)
                dbest = d;
                break
            end
            dbest = 0;
        end
        disparity(k, j) = dbest;
    end
    fprintf('Scanning the %d th row\n', k)
end
end