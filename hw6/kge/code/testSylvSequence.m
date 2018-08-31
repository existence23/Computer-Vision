% your code here

load('../data/sylvseq.mat');
load('../data/sylvbases.mat');
rect_initial = [102, 62, 156, 108]';

rects = zeros(size(frames, 3), 4);
rects(1, :) = rect_initial';
rects_compo = zeros(size(frames, 3), 4);
rects_compo(1, :) = rect_initial';

for i = 1 : (size(frames, 3) - 1)
    It = frames(:, :, i);
    It1 = frames(:, :, i + 1);
    rect = rects(i, :)';
    rect = round(rect);
    [u, v] = LucasKanadeBasis(It, It1, rect, bases);
    rects(i + 1, :) = [rect(1) + u, rect(2) + v, rect(3) + u, rect(4) + v];
    
    rect_compo = rects_compo(i, :)';
    rect_compo = round(rect_compo);
    [u_compo, v_compo] = LucasKanadeInverseCompositional(It, It1, rect_compo);
    rects_compo(i + 1, :) = [rect_compo(1) + u_compo, rect_compo(2) + v_compo, rect_compo(3) + u_compo, rect_compo(4) + v_compo];
    if (i == 1) || (i == 200) || (i == 300) || (i == 350) || (i == 400)
        figure
        imshow(frames(:, :, i));
        hold on;
        x1 = rect(1); y1 = rect(2); x2 = rect(3); y2 = rect(4);
        w = x2 - x1; h = y2 - y1;
        rectangle('position', [x1, y1, w, h], 'EdgeColor', 'g', 'LineWidth', 1.5);
        
        hold on;
        x1_compo = rect_compo(1); y1_compo = rect_compo(2); x2_compo = rect_compo(3); y2_compo = rect_compo(4);
        w_compo = x2_compo - x1_compo; h_compo = y2_compo - y1_compo;
        rectangle('position', [x1_compo, y1_compo, w_compo, h_compo], 'EdgeColor', 'y', 'LineWidth', 1.5);
        set(gca,'position',[0 0 1 1]);
    end
end

save('sylvseqrects.mat','rects');