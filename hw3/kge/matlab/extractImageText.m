function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.

im = imread(fname);
[lines, bw] = findLetters(im);
load('nist36_model.mat');
characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

text = [];
for i = 1 : length(lines)
    for j = 1 : size(lines{i}, 1)
        pos = lines{i}(j, :);
        img = bw(round(pos(2)) : round(pos(4)), round(pos(1)) : round(pos(3)));
        img = imresize(img, [32, 32]);
        img = reshape(img, 1, 1024);
        outputs = Classify(W, b, img);
        [~, predict_label] = max(outputs, [], 2);
        text = [text, characters(predict_label)];
    end
    text = [text, '\n'];
end
fprintf(text);
end


