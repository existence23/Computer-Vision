function [locs, desc] = computeBrief(im, locs, compareX, compareY)
% Compute the BRIEF descriptor for detected keypoints.
% im is 1 channel image, 
% locs are locations
% compareX and compareY are idx in patchWidth^2
% Return:
% locs: m x 2 vector which contains the coordinates of the keypoints
% desc: m x nbits vector which contains the BRIEF descriptor for each
%   keypoint.

% im = rgb2gray(im);
% im = im2double(im);

nbits = size(compareX, 1);
patchWidth = 9;
halfPatch = floor(patchWidth ./ 2);
%remove the points at the edge of the image to guarantee the full patch of
%width
locs = locs(locs(:, 1) > halfPatch, :);
locs = locs(locs(:, 1) <= (size(im, 2) - halfPatch), :);
locs = locs(locs(:, 2) > halfPatch, :);
locs = locs(locs(:, 2) <= (size(im, 1) - halfPatch), :);

desc = zeros(size(locs, 1), nbits);
for i = 1 : size(locs, 1)
    col = locs(i, 1);
    row = locs(i, 2);
    col = floor(col);
    if col == 4
        col = col + 1;
    end
    row = floor(row);
    if row == 4
        row = row + 1;
    end
    patch = im(row - halfPatch : row + halfPatch, col - halfPatch : col + halfPatch);
    for j = 1 : nbits
        if(patch(compareX(j)) < patch(compareY(j)))
            desc(i, j) = 1;
        else
            desc(i, j) = 0;
        end
    end
end

%%%
end