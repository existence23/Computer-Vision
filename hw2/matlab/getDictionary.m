function [filterBank, dictionary] = getDictionary(imgPaths, alpha, K, method)
% Generate the filter bank and the dictionary of visual words
% Inputs:
%   imgPaths:        array of strings that repesent paths to the images
%   alpha:          num of points
%   K:              K means parameters
%   method:         string 'random' or 'harris'
% Outputs:
%   dictionary:         a length(imgPaths) * K matrix where each column
%                       represents a single visual word
    % -----fill in your implementation here --------

    %Initialize filter bank
    filterBank = createFilterBank();
    
    nBank = length(filterBank);
    T = length(imgPaths);
    
    %Initialize pixel responses
    pixelResponses = [];
    
    for i = 1:T
        
        name = strcat('../data/', imgPaths{i});
        I = imread(name);
        
        if size(I,3) == 1
            I = repmat(I, [1 1 3]);
        end
        
        currentResponse = extractFilterResponses(I, filterBank);
        %size of current response is H*W*(3nBank);
        
        %index of chosen pixels
        if strcmp(method, 'random') == 1
            indices = getRandomPoints(I, alpha);
        elseif strcmp(method, 'harris') == 1
            indices = getHarrisPoints(I, alpha, 0.05);
        end
        
        %calculate single response
        singleResponse = zeros(alpha, 3*nBank);
        for j = 1:alpha
            singleResponse(j,:) = currentResponse(indices(j,1),indices(j,2),:);
        end
        
        pixelResponses = [pixelResponses; singleResponse];
    end
    
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
    %change dictionary from row-wise to column-wise
    dictionary = dictionary';

    % ------------------------------------------
    
end
