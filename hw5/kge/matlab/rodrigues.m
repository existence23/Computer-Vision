function R = rodrigues(r)
% rodrigues:

% Input:
%   r - 3x1 vector
% Output:
%   R - 3x3 rotation matrix

theta = norm(r);
r = r / theta;

I = eye(3);

r_mat = [0, -r(3), r(2); r(3), 0, -r(1); -r(2), r(1), 0];
R = cos(theta) * I + (1 - cos(theta)) * r * r' + sin(theta) * r_mat; 


end
