% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
load('../data/templeCoords.mat');

N = size(x1, 1);

M = max(size(I1, 1), size(I1, 2));
F = eightpoint(pts1, pts2, M);
E = essentialMatrix(F, K1, K2);
P =zeros(size(pts1, 1), 3);

x2 = zeros(size(x1));
y2 = zeros(size(y1));
for i = 1 : N
    [x2(i), y2(i)] = epipolarCorrespondence(I1, I2, F, x1(i), y1(i));
end

M2s = camera2(E);
M2 = zeros(size(M2s(:, :, 1), 1), size(M2s(:, :, 1), 2));
M1 = [eye(3), zeros(3, 1)];
C1 = K1 * M1;

for i = 1 : size(M2s, 3)
    C2 = K2 * M2s(:, :, i);
    pts1 = [x1, y1];
    pts2 = [x2, y2];
    [p, ~] = triangulate(C1, pts1, C2, pts2);
    
    if all(p(:, 3) > 0)
        M2 = M2s(:, :, i);
        P = p;
        break;
    end
end



scatter3(P(:, 1), P(:, 2), P(:, 3));

save('q4_2.mat', 'M1', 'M2', 'C1', 'C2');






