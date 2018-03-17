function guessResult = guessImage(fileName)
%This is a help function in evaluateRecognitionSystem.m

load('../data/traintest.mat');
load('dictionaryRandom.mat');
filterBank = filterBank;
dictionary = randomDictionary;

mapName = strrep(fileName,'.jpg','.mat');
load(mapName);
hist1 = getImageFeatures(wordMap, size(dictionary, 2));

histSet = [];
n_Img = length(test_imagenames);
histSet = cell(length(mapping), 1);

for i = 1:n_Img
    imgName = ['../data/Random/', test_imagenames{i}];
    mapname = strrep(imgName, '.jpg', '.mat');
    map = cell2mat(struct2cell(load(mapname)));
    mappingPos = test_labels(i);
    histSet{mappingPos} = [histSet{mappingPos}; getImageFeatures(map, size(dictionary, 2))];
end

dist = zeros(1, length(mapping));
for i = 1: length(mapping)
    dist(1, i) = mean(getImageDistance(hist1, histSet{i}, 'euclidean'));
end

[~, pos] = min(dist);
guessResult = mapping{pos};
end

