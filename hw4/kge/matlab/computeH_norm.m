function [H2to1] = computeH_norm(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

N = size(p1, 2);
x1_mean = mean(p1(1, :));
y1_mean = mean(p1(2, :));
x2_mean = mean(p2(1, :));
y2_mean = mean(p2(2, :));

distance1 = 0;
distance2 = 0;

% for i = 1 : N
%     distance1 = distance1 + sqrt((p1(1, i) - x1_mean).^2 + (p1(2, i) - y1_mean).^2);
%     distance2 = distance2 + sqrt((p2(1, i) - x2_mean).^2 + (p2(2, i) - y2_mean).^2);
% end

for i = 1 : N
    distance1 = distance1 + sqrt((p1(1, i) - x1_mean)^2 + (p1(2, i) - y1_mean)^2);
    distance2 = distance2 + sqrt((p2(1, i) - x2_mean)^2 + (p2(2, i) - y2_mean)^2);
end

distance1 = (sqrt(2)) * N /distance1;
distance2 = (sqrt(2)) * N /distance2;

T1 = zeros(3, 3);
T1(1, 1) = 1; T1(1, 2) = 0; T1(1, 3) = -x1_mean;
T1(2, 1) = 0; T1(2, 2) = 1; T1(2, 3) = -y1_mean;
T1(3, 1) = 0; T1(3, 2) = 0; T1(3, 3) = 1/distance1;
T1 = distance1 * T1;

T2 = zeros(3, 3);
T2(1, 1) = 1; T2(1, 2) = 0; T2(1, 3) = -x2_mean;
T2(2, 1) = 0; T2(2, 2) = 1; T2(2, 3) = -y2_mean;
T2(3, 1) = 0; T2(3, 2) = 0; T2(3, 3) = 1/distance2;
T2 = distance2 * T2;

p1 = [p1; ones(1, N)];
p2 = [p2; ones(1, N)];

p1_norm = T1 * p1;
p2_norm = T2 * p2;

p1_norm(3, :) = [];
p2_norm(3, :) = [];

H2to1 = computeH(p1_norm, p2_norm);
H2to1 = inv(T1) * H2to1 * T2;

scale = 1 ./ H2to1(3, 3);
H2to1 = scale .* H2to1;

%%%

end