% buildRecognitionSystem.m
% This script loads the visual word dictionary (in dictionaryRandom.mat or dictionaryHarris.mat) and processes
% the training images so as to build the recognition system. The result is
% stored in visionRandom.mat and visionHarris.mat.

load('dictionaryHarris.mat');  %load harris or random dictionary
%load('dictionaryRandom.mat');
load('../data/traintest.mat');

dictionary = harrisDictionary;
%dictionary = randomDictionary;
filterBank = filterBank;
T = length(train_imagenames);
K = size(dictionary, 2);

trainFeatures = zeros(T, K);

for i = 1:T
%     wordmapfile = strrep(['../data/Random/', train_imagenames{1, i}], '.jpg', '.mat');
    wordmapfile = strrep(['../data/Harris/', train_imagenames{1, i}], '.jpg', '.mat');
    load(wordmapfile);
    
    %calculate the histogram
    trainFeatures(i, :) = getImageFeatures(wordMap, K);
end

trainLabels = train_labels';

%save('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');
save('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');

