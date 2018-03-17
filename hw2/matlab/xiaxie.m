fileName='../data/Harris/football_stadium/sun_aahvylyxdakauexd.jpg';
load('../data/traintest.mat');
result = guessImage(fileName);
find(strcmp(result, mapping));

