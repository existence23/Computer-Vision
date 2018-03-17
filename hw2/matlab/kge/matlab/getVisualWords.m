function [wordMap] = getVisualWords(I, dictionary, filterBank)
% Convert an RGB or grayscale image to a visual words representation, with each
% pixel converted to a single integer label.   
% Inputs:
%   I:              RGB or grayscale image of size H * W * C
%   filterBank:     cell array of matrix filters used to make the visual words.
%                   generated from getFilterBankAndDictionary.m
%   dictionary:     matrix of size 3*length(filterBank) * K representing the
%                   visual words computed by getFilterBankAndDictionary.m
% Outputs:
%   wordMap:        a matrix of size H * W with integer entries between
%                   1 and K

    % -----fill in your implementation here --------
    
    %repeat the image in all three layers if its is grayscale
    if size(I, 3) == 1
        I = repmat(I, 1, 1, 3);
    end
    
    %calculate the filter responses for the input image
    response = extractFilterResponses(I, filterBank);
    [H, W, Z] = size(response);
    response = reshape(response, [H*W, Z]);
    distances = pdist2(response, dictionary', 'euclidean');
    [~, wordMap] = min(distances, [], 2);
    wordMap = reshape(wordMap, H, W);
    % ------------------------------------------
end
