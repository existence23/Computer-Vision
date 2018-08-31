function residuals = rodriguesResidual(K1, M1, p1, K2, p2, x)
% rodriguesResidual:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   x - (3N + 6)x1 flattened concatenation of P, r_2 and t_2

% Output:
%   residuals - 4Nx1 vector

N = size(p1, 1);
P = x(1 : (3 * N));
P = reshape(P, N, 3);
r_2 = x((3 * N + 1) : (3 * N + 3))';
t_2 = x((3 * N + 4) : (3 * N + 6))';
R = rodrigues(r_2);
M2 = [R, t_2'];

C1 = K1 * M1;
C2 = K2 * M2;
P = [P'; ones(1, N)];

p1_hat = C1 * P;
p2_hat = C2 * P;

p1_hat = p1_hat(1 : 2, :)' ./ p1_hat(3, :)';
p2_hat = p2_hat(1 : 2, :)' ./ p2_hat(3, :)';

residuals_1 = p1 - p1_hat;
residuals_1 = reshape(residuals_1, 2 * N, 1);
residuals_2 = (p2 - p2_hat)';
residuals_2 = reshape(residuals_2, 2 * N, 1);

residuals = [residuals_1; residuals_2];

end
