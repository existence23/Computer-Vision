function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.

%convert the im to gray and binary

im = rgb2gray(im);
im = ~imbinarize(im); % 0 for background and 1 for the black area
bw = double(~im);
im = double(im);

im = imgaussfilt(im, 2);
im = bwareaopen(im, 400); %filter some interference in the img

result = bwconncomp(im);

charPos = result.PixelIdxList;
charNum = result.NumObjects;

%locate each character
char = zeros(charNum, 4);
[m, n] = size(im);
for i = 1 : charNum
    [x1, y1, x2, y2] = deal(n, m, 1, 1);
    for j = 1 : length(charPos{i})
        [x, y] = ind2sub([m, n], charPos{i}(j));
        x1 = min(x1, y);
        y1 = min(y1, x);
        x2 = max(x2, y);
        y2 = max(y2, x);
    end
    
    [x1, y1, x2, y2] = deal(max(1, x1 - 2), max(1, y1 - 2), min(n, x2 + 2), min(m, y2 + 2));
    char(i, :) = [x1, y1, x2, y2];
end

lines = cell(charNum, 1);
i = 0;
while 1
    i = i + 1;
    [y1_min, xPos] = min(char(:, 2));
    y2_min = char(xPos, 4);
    sameLine = (char(:, 2) >= y1_min & char(:, 2) <= y2_min);
    if length(sameLine) == 0
        break
    end
    
    row = sortrows(char(sameLine, :));
    lines{i} = row;
    
    char(sameLine, :) = [];
end

lines = lines(1 : i - 1);


end
