
    
    %load image paths
    load('../data/traintest.mat');
    imgPaths = train_imagenames;
    
    [filterBank, randomDictionary] = getDictionary(imgPaths, 50, 100, 'random');
    save('dictionaryRandom.mat','filterBank','randomDictionary');
    [filterBank, harrisDictionary] = getDictionary(imgPaths, 50, 100, 'harris');
    save('dictionaryHarris.mat','filterBank','harrisDictionary');

