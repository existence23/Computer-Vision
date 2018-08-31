function [u,v] = LucasKanade(It, It1, rect)
% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.

It = im2double(It);
It1 = im2double(It1);

threshold = 0.1;
p = [0; 0];

T = It(rect(2) : rect(4), rect(1) : rect(3));
[dT_dx, dT_dy] = gradient(T);
n = numel(T);
dT_dx = reshape(dT_dx, n, 1);
dT_dy = reshape(dT_dy, n, 1);
SD = [dT_dx dT_dy] * eye(2);
H = SD' * SD;

while(true)
    WarpedImg = warpImg(It1, p, rect);
    error = T - WarpedImg;
    error = reshape(error, n, 1);
    d_p = H \ (SD' * error);
    p = p + d_p;
    if norm(d_p) < threshold
        break;
    end
end
u = p(1);
v = p(2);
end



function WarpedImg = warpImg(It, p, rect)
    x = (rect(1) + p(1)) : (rect(3) + p(1));
    y = (rect(2) + p(2)) : (rect(4) + p(2));
    [X, Y] = meshgrid(x, y);
    WarpedImg = interp2(It, X, Y);
end