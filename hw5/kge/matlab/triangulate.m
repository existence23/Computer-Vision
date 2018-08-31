function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q4.2:
%       Implement a triangulation algorithm to compute the 3d locations
%
N = size(p1, 1);
P = zeros(N, 3);

for i = 1 : N
    p1x = p1(i, 1); p1y = p1(i, 2);
    p2x = p2(i, 1); p2y = p2(i, 2);
    c11 = C1(1,:); c12 = C1(2,:); c13 = C1(3,:);
    c21 = C2(1,:); c22 = C2(2,:); c23 = C2(3,:);
    
    A = [p1x * c13 - c11;
         p1y * c13 - c12;
         p2x * c23 - c21;
         p2y * c23 - c22];
    
    [~, ~, V] = svd(A);
    tmp = V(:, end)';
    tmp = tmp ./ tmp(4);
    P(i, :) = tmp(1, 1 : 3);
end

P_proj = [P'; ones(1, N)];
P_proj_1 = C1 * P_proj;
P_proj_2 = C2 * P_proj;

p_proj_1 = zeros(N, 2);
p_proj_2 = zeros(N, 2);

p_proj_1(:, 1) = (P_proj_1(1, :) ./ P_proj_1(3, :))';
p_proj_1(:, 2) = (P_proj_1(2, :) ./ P_proj_1(3, :))';
p_proj_2(:, 1) = (P_proj_2(1, :) ./ P_proj_2(3, :))';
p_proj_2(:, 2) = (P_proj_2(2, :) ./ P_proj_2(3, :))';


err = sum(sum((p1 - p_proj_1) .^ 2 + (p2 - p_proj_2) .^ 2));

end
