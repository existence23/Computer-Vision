function [points] = getHarrisPoints(I, alpha, k)
% Finds the corner points in an image using the Harris Corner detection algorithm
% Input:
%   I:                      grayscale image
%   alpha:                  number of points
%   k:                      Harris parameter
% Output:
%   points:                    point locations
%
    % -----fill in your implementation here --------
    I = I(:,:,1);
    
    gaussianFilter=fspecial('gaussian',[3,3],1);
    
    [Ix, Iy] = gradient(double(I));
    
    Ixx = conv2(double(Ix.^2), gaussianFilter, 'same');
    Iyy = conv2(double(Iy.^2), gaussianFilter, 'same');
    Ixy = conv2(double(Ix.*Iy), gaussianFilter, 'same');
    
    [m, n] = size(I);
    R = zeros(m, n);
    for i = 1:(m*n)
        x = fix((i-1)/n) + 1;
        y = mod(i-1, n) + 1;
        H = [Ixx(x,y), Ixy(x,y); Ixy(x,y), Iyy(x,y)];
        R(x, y) = det(H) - k*(trace(H))^2;
    end
    
    [B, Index] = sort(R(:), 'descend');
    Rx = zeros(alpha, 1);
    Ry = zeros(alpha, 1);
    for i = 1:alpha
        index = Index(i);
        Rx(i) = mod(index-1, m) + 1;
        Ry(i) = fix((index-1)/m) + 1;
    end
    
    points = zeros(alpha, 2);
    points(:, 1) = Rx(:);
    points(:, 2) = Ry(:); 
    
    imshow(I);
    hold on
    plot(Ry, Rx,'ys');
    
    % ------------------------------------------

end
