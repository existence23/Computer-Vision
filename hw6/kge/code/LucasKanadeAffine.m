function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix
It = im2double(It);
It1 = im2double(It1);

threshold = 0.001;
p = zeros(6, 1);

T = It;
n = numel(T);
[X, Y] = meshgrid(1 : size(It, 2), 1 : size(It, 1));
X_vector = reshape(X, n, 1);
Y_vector = reshape(Y, n, 1);

while(true)
    M = [1 + p(1), p(2), p(3); p(4), 1 + p(5), p(6); 0, 0, 1];
    X_warp = M(1, 1) * X + M(1, 2) * Y + M(1, 3);
    Y_warp = M(2, 1) * X + M(2, 2) * Y + M(2, 3);
    I = interp2(X, Y, It1, X_warp, Y_warp);
    I(isnan(I)) = 0;
    
    index_1 = X_warp >= 1 & X_warp <= size(It, 2);
    index_2 = Y_warp >= 1 & Y_warp <= size(It, 1);
    index = index_1 & index_2;
    
    dif = I - T;
    dif = dif .* index;
    dif = reshape(dif, n, 1);
    
    [dI_dx, dI_dy] = gradient(I);
    dI_dx = dI_dx .* index;
    dI_dy = dI_dy .* index;
    dI_dx = reshape(dI_dx, n, 1);
    dI_dy = reshape(dI_dy, n, 1);
    SD = [dI_dx .* X_vector, dI_dx .* Y_vector, dI_dx, dI_dy .* X_vector, dI_dy .* Y_vector, dI_dy];
    H = SD' * SD;
    d_p = H \ (SD' * dif);
    if norm(d_p) < threshold
        break;
    end
    p = p - d_p;
end

M = [1 + p(1), p(2), p(3); p(4), 1 + p(5), p(6); 0, 0, 1];

end
    

    
    
    