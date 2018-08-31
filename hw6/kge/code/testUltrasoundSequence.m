% your code here

load('../data/usseq.mat');
rect_initial = [255, 105, 310, 170]';

rects = zeros(size(frames, 3), 4);
rects(1, :) = rect_initial';

for i = 1 : (size(frames, 3) - 1)
    It = frames(:, :, i);
    It1 = frames(:, :, i + 1);
    rect = rects(i, :)';
    rect = round(rect);
    [u, v] = LucasKanadeInverseCompositional(It, It1, rect);
    rects(i + 1, :) = [rect(1) + u, rect(2) + v, rect(3) + u, rect(4) + v];
    if (i == 5) || (i == 25) || (i == 50) || (i == 75) || (i == 100)
        figure
        imshow(frames(:, :, i));
        hold on;
        x1 = rect(1); y1 = rect(2); x2 = rect(3); y2 = rect(4);
        w = x2 - x1; h = y2 - y1;
        rectangle('position', [x1, y1, w, h], 'EdgeColor', 'y', 'LineWidth', 1.5);
        set(gca,'position',[0 0 1 1]);
    end
end

if size(frames, 3) == 100
    figure;
    imshow(frames(:, :, 100));
    hold on;
    x1 = rect(1); y1 = rect(2); x2 = rect(3); y2 = rect(4);
    w = x2 - x1; h = y2 - y1;
    rectangle('position', [x1, y1, w, h], 'EdgeColor', 'y', 'LineWidth', 1.5);
    set(gca,'position',[0 0 1 1]);
end

save('usseqrects.mat','rects');
