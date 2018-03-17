function [filterResponses] = extractFilterResponses(I, filterBank)

    %Convert input Image to Lab
    doubleI = double(I);
    if length(size(doubleI)) == 2
        tmp = doubleI;
        doubleI(:,:,1) = tmp;
        doubleI(:,:,2) = tmp;
        doubleI(:,:,3) = tmp;
    end
    [L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
    h = size(I,1);
    w = size(I,2);
   
% -----fill in your implementation here --------
n = length(filterBank);
filterResponses = zeros(h, w, 3*n);
for i = 1 : n
    L_filt = imfilter(L, filterBank{i}, 'same');
    filterResponses(:,:,i*3-2) = L_filt;
    
    a_filt = imfilter(a, filterBank{i}, 'same');
    filterResponses(:,:,i*3-1) = a_filt;
    
    b_filt = imfilter(b, filterBank{i}, 'same');
    filterResponses(:,:,i*3) = b_filt;
    
% ------------------------------------------
end
