% evaluateRecognitionSystem.m
% This script evaluates nearest neighbour recognition system on test images
% load traintest.mat and classify each of the test_imagenames files.
% Report both accuracy and confusion matrix

load('../data/traintest.mat');

%Initialize the confusion matrix
C = zeros(length(mapping));

%get the number of test images
n_Img = length(test_imagenames);

total = n_Img;
correct = 0;

%calculate the test image features
for i = 1:n_Img
    fileName = ['../data/Random/', test_imagenames{i}];
    %fileName = ['../data/Harris/', test_imagenames{i}];
    guessPos = find(strcmp(guessImage(fileName), mapping));
    C(test_labels(i), guessPos) = C(test_labels(i), guessPos) + 1;
    
    %justify the guess is right or not
    if test_labels(i) == guessPos
        correct = correct + 1;
    end
end

accuracy = correct / total;
fprintf('accuracy = %f\n', accuracy);
fprintf('Confusion matrix: \n');
disp(C);
    