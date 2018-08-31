% your code here

load('../data/carseq.mat');
rect_initial = [60,117, 146, 152]';

rects = zeros(size(frames, 3), 4);
rects(1, :) = rect_initial';

for i = 1 : (size(frames, 3) - 1)
    It = frames(:, :, i);
    It1 = frames(:, :, i + 1);
    rect = rects(i, :)';
    rect = round(rect);
    [u, v] = LucasKanadeInverseCompositional(It, It1, rect);
    rects(i + 1, :) = [rect(1) + u, rect(2) + v, rect(3) + u, rect(4) + v];
    if (i == 1) || (i == 100) || (i == 200) || (i == 300) || (i == 400)
        figure
        imshow(frames(:, :, i));
        hold on;
        x1 = rect(1); y1 = rect(2); x2 = rect(3); y2 = rect(4);
        w = x2 - x1; h = y2 - y1;
        rectangle('position', [x1, y1, w, h], 'EdgeColor', 'y', 'LineWidth', 1.5);
        set(gca,'position',[0 0 1 1]);
    end
end

save('carseqrects.mat', 'rects');


