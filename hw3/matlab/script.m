% classes = 36;
% layers = [32*32, 800, classes];
% [W, b] = InitializeNetwork(layers);
% w=W{1};
% I=zeros(32,32,1,800);
% for i = 1:800
%     im = w(i, :);
%     im = reshape(im,32,32);
%     im=mat2gray(im);
%     I(:,:,1,i)=im;
% end
% montage(I)

load('nist36_model.mat');
load('../data/nist36_test.mat', 'test_data', 'test_labels');
output = Classify(W,b,test_data);


[~,pos1] = max(output, [], 2);
% for i = 1:size(output, 1)
%     for j = 1 : size(output, 2)
%         if j == pos(i)
%             output(i,j)=1;
%         else
%             output(i,j)=0;
%         end
%     end
% end
[~,pos2] = max(test_labels, [], 2);

matrix = zeros(36,36);

for i = 1 : size(output, 1)
    matrix(pos1(i), pos2(i)) = matrix(pos1(i), pos2(i)) + 1;
end

newMatrix = zeros(360, 360);

for i = 1 : 360
    x = fix((i - 1) / 10) + 1;
    for j = 1 : 360
        y = fix((j - 1) / 10) + 1;
        newMatrix(i, j) = matrix(x, y);
    end
end

    
a=max(max(newMatrix));
newMatrix = newMatrix./a;
newMatrix = newMatrix.*256;
% imshow(newMatrix/256);

b = matrix;
for i = 1 : 36
    b(i,i)=0;
end

max(max(b));
[m,n]=find(b==21);
b(m,n)=0;
max(max(b))
[m,n]=find(b==13)

