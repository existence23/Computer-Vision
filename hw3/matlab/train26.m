num_epoch = 30;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

acc_train = zeros(num_epoch, 1);
acc_valid = zeros(num_epoch, 1);
loss_train = zeros(num_epoch, 1);
loss_valid = zeros(num_epoch, 1);

[W, b] = InitializeNetwork(layers);

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

save('nist26_model.mat', 'W', 'b')
