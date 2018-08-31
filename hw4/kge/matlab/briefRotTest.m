im1 = imread('../data/model_chickenbroth.jpg');
im1 = rgb2gray(im1);
im1 = im2double(im1);
[locs1, desc1] = briefLite(im1);
num_match = zeros(1, 37);

for i = 0 : 36
    theta = i * 10;
    im2 = imrotate(im1, theta);
    
    [locs2, desc2] = briefLite(im2);
    [matches] = briefMatch(desc1, desc2, 0.8);
    
    num_match(i + 1, 1) = size(matches, 1);
end

bar(0 : 10 : 360, num_match, 30);
xlabel('Degree of Rotation');
ylabel('Number of correct matches');