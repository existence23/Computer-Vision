function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

if length(layers) < 3
    error('At least three layers')
end

W = cell(1, length(layers)-1);
b = cell(1, length(layers)-1);

for i = 1 : length(W)
    w = zeros(layers(i+1), layers(i));
    min = -sqrt(6 / (layers(i) + layers(i + 1)));
    max = sqrt(6 / (layers(i) + layers(i + 1)));
    W{i} = unifrnd(min, max, layers(i+1), layers(i));
    b{i} = zeros(layers(i+1), 1);
end


end
