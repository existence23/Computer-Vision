function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
M = max(size(I1, 1), size(I1, 2));
load('../data/seven_corresp.mat');

pts1 = pts1 ./ M;
pts2 = pts2 ./ M;
N = size(pts1, 1);

x1 = pts1(:, 1);
y1 = pts1(:, 2);
x2 = pts2(:, 1);
y2 = pts2(:, 2);

A = [x1 .* x2, x1 .* y2, x1, y1 .* x2, y1 .* y2, y1, x2, y2, ones(N, 1)];
[~, ~, V] = svd(A);
F1 = V(:, end);
F2 = V(:, end - 1);
F1 = reshape(F1, 3, 3);
F2 = reshape(F2, 3, 3);
F1 = F1';
F2 = F2';

syms lambda;
eqn = det(lambda * F1 + (1 - lambda) * F2);
eqn = sym2poly(eqn);
lambda = roots(eqn);
lambda = real(eqn);

size_lambda = size(lambda, 1);
F = cell(size_lambda, 1);

T = eye(3) ./ M;
T(3, 3) = 1;
for i = 1 : size_lambda
    F{i} = lambda(i) * F1 + (1 - lambda(i)) * F2;
end
for i = 1 : size_lambda
    F{i} = T' * F{i} * T;
end
pts1 = pts1 * M;
pts2 = pts2 * M;

save('../results/q2_2.mat', 'F', 'M', 'pts1', 'pts2');
% displayEpipolarF(I1, I2, F{1});

end

