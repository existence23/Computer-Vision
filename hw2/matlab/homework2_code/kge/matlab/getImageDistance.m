function [dist] = getImageDistance(hist1, histSet, method)
% Computes the distance from the feature vector (returned by getImageFeatures
% or getImageFeaturesSPM) histogram to all of the feature vectors for the
% training images.
% Inputs:
%   hist1:           image1 histogram
%   hist2:           image2 histogram
%   method:          string 'euclidean' or 'chi2'

% Outputs:
%   dist:          distance between two histograms

% Note: Please update the function if you decide to implement the set version 
% getImageDistance(hist1, histSet, method)

	% -----fill in your implementation here --------
    n_Set = size(histSet, 1);
    dist = zeros(1, n_Set);
    for i = 1:n_Set
        if strcmpi(method, 'euclidean') == 1
            dist(1, i) = pdist2(hist1, histSet(i,:), 'euclidean');
        elseif strcmpi(method, 'chi2') == 1
            dist(1, i) = pdist2(hist1, histSet(i,:), 'chisq');
        end
    end
    % ------------------------------------------

end
