function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.

outputs = Classify(W, b, data);
[~, fx] = max(outputs, [], 2);
[~, label] = max(labels, [], 2);
accuracy = sum(fx == label) / length(label);

outputs(outputs == 0) = 1e-12;

loss = -sum(sum(labels.*log(outputs), 2)) / size(data, 1);

end
