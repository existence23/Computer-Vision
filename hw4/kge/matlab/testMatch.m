im2 = imread('../data/model_chickenbroth.jpg');
im1 = imread('../data/chickenbroth_01.jpg');

im1 = im2double(im1);
im2 = im2double(im2);

im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

matches = briefMatch(desc1, desc2, 0.8);
plotMatches(im1, im2, matches, locs1, locs2);