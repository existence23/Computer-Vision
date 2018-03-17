clear;

datadir     = '../data/test';    %the directory containing the images
resultsdir  = '../result'; %the directory for dumping results

    
a=imread('../data/test/desert.jpg');

[filterResponses] = extractFilterResponses(a, createFilterBank());

h = size(filterResponses,1);
w = size(filterResponses,2);

a=zeros(h,w,3);
a(:,:,1)=filterResponses(:,:,58);
a(:,:,2)=filterResponses(:,:,59);
a(:,:,3)=filterResponses(:,:,60);

