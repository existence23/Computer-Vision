num_epoch = 5;
classes = 36;
layers = [32*32, 800, classes];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

acc_train = zeros(num_epoch, 1);
acc_valid = zeros(num_epoch, 1);
loss_train = zeros(num_epoch, 1);
loss_valid = zeros(num_epoch, 1);

[W_initial, b_initial] = InitializeNetwork(layers);

load('../data/nist26_model_60iters.mat');
W_tmp = W;
b_tmp = b;

W_initial{1} = W_tmp{1};
b_initial{1} = b_tmp{1};

W = W_initial;
b = b_initial;

for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);

    acc_train(j) = train_acc;
    acc_valid(j) = valid_acc;
    loss_train(j) = train_loss;
    loss_valid(j) = valid_loss;

    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
end

figure;
plot(1:num_epoch, acc_train, 'LineWidth', 2, 'Color', 'r');
hold on;
plot(1:num_epoch, acc_valid, 'LineWidth', 2, 'Color', 'b');

figure;
plot(1:num_epoch, loss_train, 'LineWidth', 2, 'Color', 'r');
hold on;
plot(1:num_epoch, loss_valid, 'LineWidth', 2, 'Color', 'b');

save('nist36_model.mat', 'W', 'b')