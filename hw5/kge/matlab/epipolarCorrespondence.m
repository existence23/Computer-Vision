function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

p1 = [x1; y1; 1];
line = F * p1;
line = line / norm(line);

im1 = double(im1);
im2 = double(im2);

step = 10; sigma = 3; min_Err = inf;

filt = fspecial('gaussian', [2 * step + 1, 2 * step + 1], sigma);

x1 = ceil(x1);
y1 = ceil(y1);
patch1 = im1((y1 - step) : (y1 + step), (x1 - step) : (x1 + step));

for i = (y1 - sigma * step) : (y1 + sigma * step)
    x2_curr = (-line(2) * i - line(3)) ./ line(1);
    x2_curr = ceil(x2_curr);
    
    if x2_curr - step > 0 && x2_curr + step < size(im2, 2) && i - step > 0 && i + step <= size(im2, 2)
        
        patch2 = im2(i - step : i + step, x2_curr - step : x2_curr + step);
        
        distance = double(patch1) - double(patch2);
        weight = filt .* distance;
        err = sqrt(sum(weight(:) .^ 2));
        
        if err < min_Err
            min_Err = err;
            x2 = x2_curr;
            y2 = i;
        end
    end
end
       


end

