% your code here
load('usseqrects.mat');
load('../data/usseq.mat');

for i = 2 : size(frames, 3)
    image1 = im2double(frames(:, :, i - 1));
    image2 = im2double(frames(:, :, i));
    mask1 = SubtractDominantMotion(image1, image2);
    
    x1 = rects(i, 1); y1 = rects(i, 2); x2 = rects(i, 3); y2 = rects(i, 4);
    mask2 = zeros(size(image1));
    mask2(round(y1 : y2), round(x1 : x2)) = 1;
    mask = mask1 & mask2;
    im_fuse = imfuse(image1, mask);
    if i == 5 || i == 25 || i == 50 || i == 75 || i == 100
        figure;
        imshow(im_fuse);
        set(gca,'position',[0 0 1 1]);
        saveas(gcf, ['usseq_' num2str(i) '.jpg'], 'jpg');
    end
end

