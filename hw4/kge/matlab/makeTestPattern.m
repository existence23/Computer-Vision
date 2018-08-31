function [compareX, compareY] = makeTestPattern(patchWidth, nbits)  
% input
% patchWidth - the width of the image patch (usually 9)
% nbits - the number of tests n in the BRIEF descriptor
% output
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors. 
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and save the results in testPattern.mat.

%%%

%This implementation took the fourth method in the paper, in which
%(x_i, y_i) are randomly sampled

patchWidth = 9;
nbits = 256;

compareX = randi(patchWidth .* patchWidth, nbits, 1);
compareY = randi(patchWidth .* patchWidth, nbits, 1);

save('../results/testPattern.mat', 'compareX', 'compareY');

end