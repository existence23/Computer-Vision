% Your code here.
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;
epsilon = 1e-4;
num_epochs = 10;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

randIndex = randperm(size(train_data, 1), 1);

X = train_data(randIndex, :);
Y = train_labels(randIndex, :);
% [out, act_h, act_a] = Forward(W, b, X);
% [grad_W, grad_b] = Backward(W, b, X', Y');
% 
% [W, b] = InitializeNetwork(layers);
error_W = 0;
error_b = 0;

for i = 1 : length(W)
    for j = 1 : num_epochs
        error = 0;
        randInd = randperm(size(W{i}, 1) * size(W{i}, 2), 1);
        W_plus = W;
        W_plus{i}(randInd) = W_plus{i}(randInd) + epsilon;
        W_sub = W;
        W_sub{i}(randInd) = W_sub{i}(randInd) - epsilon;
        [acc_plus, loss_plus] = ComputeAccuracyAndLoss(W_plus, b, X, Y);
        [acc_sub, loss_sub] = ComputeAccuracyAndLoss(W_sub, b, X, Y);
        calculatedLoss = (loss_plus - loss_sub) / (2 * epsilon);
        [acc, act_h, act_a] = Forward(W, b, X);
        [grad_W, grad_b] = Backward(W, b, X', Y', act_h, act_a);
        Loss = grad_W{i}(randInd);
        error = error + calculatedLoss - Loss;
    end
    error_W = error_W + error;
    
    for k = 1 : num_epochs
        error = 0;
        randInd = randperm(size(b{i}, 1) * size(b{i}, 2), 1);
        b_plus = b;
        b_plus{i}(randInd) = b_plus{i}(randInd) + epsilon;
        b_sub = b;
        b_sub{i}(randInd) = b_sub{i}(randInd) + epsilon;
        [acc_plus, loss_plus] = ComputeAccuracyAndLoss(W, b_plus, X, Y);
        [acc_sub, loss_sub] = ComputeAccuracyAndLoss(W, b_plus, X, Y);
        calculatedLoss = (loss_plus - loss_sub) / (2 * epsilon);
        [acc, act_h, act_a] = Forward(W, b, X);
        [grad_W, grad_b] = Backward(W, b, X', Y', act_h, act_a);
        Loss = grad_W{i}(randInd);
        error = error + calculatedLoss - Loss;
    end
    error_b = error_b + error;
end
    

fprintf('W error is %.5f', error_W);
fprintf('b error is %f', error_b);







