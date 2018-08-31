function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

load('../data/some_corresp.mat');
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
M = max(size(I1, 1), size(I1, 2));

pts1 = pts1 ./ M;
pts2 = pts2 ./ M;
x1 = pts1(:, 1);
y1 = pts1(:, 2);
x2 = pts2(:, 1);
y2 = pts2(:, 2);
N = size(pts1, 1);

A = [x1 .* x2, x1 .* y2, x1, y1 .* x2, y1 .* y2, y1, x2, y2, ones(N, 1)];
[~, ~, V] = svd(A);
F = V(:, end);
F = reshape(F, 3, 3);

[u, s, v] = svd(F);
s(3, 3) = 0;
F = u * s * v';

T = eye(3) ./ M;
T(3, 3) = 1;
F = T' * F * T
save('../results/q2_1.mat', 'F', 'M', 'pts1', 'pts2');
% displayEpipolarF(I1, I2, F);


end

