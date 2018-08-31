function [ bestH2to1, inliers] = computeH_ransac(locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

nIter = 1000;
tolerance = 15;
N = size(locs1, 1);

p1_3 = [locs1(:, 1)'; locs1(:, 2)'; ones(1, N)];
p2_3 = [locs2(:, 1)'; locs2(:, 2)'; ones(1, N)];
inlier = zeros(nIter, N);
NumOfInlier = zeros(nIter, 1);
index = zeros(nIter, 4);

for i = 1 : nIter
    index(i, :) = randperm(size(locs1, 1), 4);
    p1_rand = locs1(index(i, :), :);
    p2_rand = locs2(index(i, :), :);
    
%     H_original = computeH_norm(p1_rand', p2_rand');
    H_original = computeH_norm(p1_rand', p2_rand');
    tmp = H_original * p2_3;
    tmp(1, :) = tmp(1, :) ./ tmp(3, :);
    tmp(2, :) = tmp(2, :) ./ tmp(3, :);
    tmp = tmp(1 : 2, :);
    dist = sum((tmp - locs1') .^ 2);
    NumOfInlier(i) = sum(dist < tolerance);
    inlier(i, :) = dist < tolerance;
    
end
% inlier

[~, index_best] = max(NumOfInlier);
inliers = inlier(index_best, :);
ind = find(inliers ~= 0);

locs1 = locs1(ind, :);
locs2 = locs2(ind, :);
bestH2to1 = computeH(locs1', locs2');

%%%

end

