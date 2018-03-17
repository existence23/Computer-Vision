
im = imread('../data/test/campus3.jpg');

points = getHarrisPoints(im, 500, 0.05);
% points = getRandomPoints(im, 500);