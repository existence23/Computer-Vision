function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.

It = im2double(It);
It1 = im2double(It1);

x1 = rect(1); y1 = rect(2); x2 = rect(3); y2 = rect(4);

threshold = 0.1;
p = [0; 0];

[xq, yq] = meshgrid([x1 : x2], [y1 : y2]);
T = interp2(It, xq, yq);
n = numel(T);
[dT_dx, dT_dy] = gradient(T);
dT_dx = reshape(dT_dx, n, 1);
dT_dy = reshape(dT_dy, n, 1);

H = [dT_dx, dT_dy]' * [dT_dx, dT_dy];

x1_init = x1; x2_init = x2; y1_init = y1; y2_init = y2;

x1 = x1 + p(1); x2 = x2 + p(1); y1 = y1 + p(2); y2 = y2 + p(2);
    
while(true)
    [xq, yq] = meshgrid([x1 : x2], [y1 : y2]);
    I = interp2(It1, xq, yq);
    I = reshape(I, n, 1);
    d_p = inv(H) * ([dT_dx, dT_dy]' * (I - reshape(T, n, 1)));
    d_p(isnan(d_p)) = 0;
    if norm(d_p) < threshold
        break;
    end
    p = p - d_p;
    x1 = x1_init + p(1);
    x2 = x2_init + p(1);
    y1 = y1_init + p(2);
    y2 = y2_init + p(2);
end

u = p(1);
v = p(2);

end










