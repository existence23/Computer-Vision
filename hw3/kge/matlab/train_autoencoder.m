% TODO: load training dataset
load('../data/nist26_train.mat', 'train_data', 'train_labels');

% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]
sizeData = size(train_data, 2);
numData = size(train_data, 1);

newTrainData = zeros(32, 32, 1, numData);
for i = 1 : numData
    newTrainData(:, :, 1, i) = reshape(train_data(i, :), 32, 32);
end


layers = define_autoencoder();

options = trainingOptions('sgdm',...
                          'InitialLearnRate',1e-3,...
                          'MaxEpochs',3,...
                          'MiniBatchSize', 20,...
                          'Shuffle','every-epoch',...
                          'Plot','training-progress',...
                          'VerboseFrequency',20);

% TODO: run trainNetwork()
net = trainNetwork(newTrainData, newTrainData, layers, options);

                      