function r = invRodrigues(R)
% invRodrigues
% Input:
%   R: 3x3 rotation matrix
% Output:
%   r: 3x1 vector


r_mat = (R - R') / 2;

r = [r_mat(3, 2); r_mat(1, 3); r_mat(2, 1)];

end
