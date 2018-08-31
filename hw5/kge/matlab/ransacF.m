function [ F, inliers ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q5.1:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made

N = size(pts1, 1);
iter = 500;
tolerance = 0.05;
% inlier = zeros(1, N);
deter = zeros(1, N);
stop = false;

for i = 1 : iter
    rand_index = randperm(N, 7);
    pts1_rand = pts1(rand_index, :);
    pts2_rand = pts2(rand_index, :);
    
    F_7 = sevenpoint(pts1_rand, pts2_rand, M);
    
    for j = 1 : length(F_7)
        for num = 1 : N
            line = F_7{j} * [pts1(num, 1); pts1(num, 2); 1];
            line = line / norm(line(1 : 2, :));
            deter(num) = line(1) * pts2(num, 1) + line(2) * pts2(num, 2) + line(3);
        end
        
        index = abs(deter) < tolerance;
        if length(index) / N > 0.75
            inliers = index;
            stop = true;
            F = F_7{j};
            break;
        end
        
        if stop
            break;
        end
    end
    
    if stop
            break;
    end
end

end

