function [img1] = myImageFilter(img0, h)
% get array sizes
[mimg0,nimg0]=size(img0);
[mh,nh]=size(h);
    
% do full convolution
img1=zeros(mimg0+mh-1,nimg0+nh-1);
for i=1:mh
    for j=1:nh
        r1=i;
        r2=r1+mimg0-1;
        g1=j;
        g2=g1+nimg0-1;
        img1(r1:r2,g1:g2)=img1(r1:r2,g1:g2)+h(i,j)*img0;
    end
end

% extract the original size of img0
r1=floor(mh/2)+1;
r2=r1+mimg0-1;
g1=floor(nh/2)+1;
g2=g1+nimg0-1;
img1=img1(r1:r2, g1:g2);

end
