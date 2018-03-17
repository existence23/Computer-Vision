function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

n = length(W);

grad_W = cell(1, n);
grad_b = cell(1, n);

for i = n : -1 : 1
    if i == n
        h_this = act_h{i};
        dL_da_this = h_this - Y;
        da_dw = act_h{i-1};
        grad_W{i} = dL_da_this * da_dw';
        grad_b{i} = dL_da_this;
    else
        dL_da_next = dL_da_this;
        tmp = dL_da_next' * W{i+1};
        tmp = tmp';
        a_this = act_a{i};
        if i == 1
            h_prev = X;
        else
            h_prev = act_h{i-1};
        end
        dL_da_this = tmp.*(sigmf(a_this, [1 0]).*(1-sigmf(a_this, [1 0])));
        grad_W{i} = dL_da_this * h_prev';
        grad_b{i} = dL_da_this;
    end
end
end


