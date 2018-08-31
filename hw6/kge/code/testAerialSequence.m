% your code here
load('../data/aerialseq.mat');

for i = 1 : (size(frames, 3) - 1)
    image1 = frames(:, :, i);
    image2 = frames(:, :, i + 1);
    mask = SubtractDominantMotion(image1, image2);
    im_fuse = imfuse(image1, mask);
    if i == 30 || i == 60 || i == 90 || i == 120
        figure;
        imshow(im_fuse);
        set(gca,'position',[0 0 1 1]);
    end
end