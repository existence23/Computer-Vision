function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image

panoImg = warpH(img2, H2to1, [size(img2, 1), size(img2, 2) + size(img1, 2)]);
if length(size(img1)) == 2
    panoImg(1 : size(img1, 1), 1 : size(img1, 2)) = img1;
elseif length(size(img1)) == 3
    panoImg(1 : size(img1, 1), 1 : size(img1, 2), :) = img1;
end

%%%

end