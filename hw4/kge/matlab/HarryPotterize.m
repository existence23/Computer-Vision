im_cover = imread('../data/cv_cover.jpg');
im_desk = imread('../data/cv_desk.png');
im_hp = imread('../data/hp_cover.jpg');

if size(im_cover, 3) > 1
    im_cover = rgb2gray(im_cover);
end
if size(im_desk, 3) > 1
    im_desk = rgb2gray(im_desk);
end
if size(im_hp, 3) > 1
    im_hp = rgb2gray(im_hp);
end

im_cover = im2double(im_cover);
im_desk = im2double(im_desk);
im_hp = im2double(im_hp);

[locs1, desc1] = briefLite(im_cover);
[locs2, desc2] = briefLite(im_desk);

matches = briefMatch(desc1, desc2, 0.8);

locs1 = locs1(matches(:, 1), :);
locs2 = locs2(matches(:, 2), :);

[H, ~] = computeH_ransac(locs2, locs1);

im_cover = imread('../data/cv_cover.jpg');
im_desk = imread('../data/cv_desk.png');
im_hp = imread('../data/hp_cover.jpg');

im_hp_1 = im_hp(:, :, 1);
im_hp_2 = im_hp(:, :, 2);
im_hp_3 = im_hp(:, :, 3);
im_hp_1 = imresize(im_hp_1, [440, 350]);
im_hp_2 = imresize(im_hp_2, [440, 350]);
im_hp_3 = imresize(im_hp_3, [440, 350]);

im_new(:, :, 1) = im_hp_1;
im_new(:, :, 2) = im_hp_2;
im_new(:, :, 3) = im_hp_3;

im_hp = im_new;
composite = compositeH(H, im_desk, im_hp);
imshow(composite);


