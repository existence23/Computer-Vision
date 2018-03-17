function [points] = getRandomPoints(I, alpha)
% Generates random points in the image
% Input:
%   I:                      grayscale image
%   alpha:                  random points
% Output:
%   points:                    point locations
%
	% -----fill in your implementation here --------
    points = zeros(alpha, 2);
    [m, n] = size(I(:,:,1));
    pos = randperm(m*n, alpha);
    for i = 1:alpha
        points(i, 1) = fix((pos(i)-1)/n) + 1;
        points(i, 2) = mod(pos(i)-1,n) + 1; 
    end
    % ------------------------------------------
end

