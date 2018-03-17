function [img1] = myImageFilterX(img0,h)
% get array sizes
[mimg0,nimg0]=size(img0);
[mh,nh]=size(h);
    
% do full convolution
img1=zeros(mimg0+mh-1,nimg0+nh-1);
for i=1:(mh*nh)
    x=fix((i-1)/mh)+1;
    y=mod(i-1,mh)+1;
    r1=x;
    r2=r1+mimg0-1;
    g1=y;
    g2=g1+nimg0-1;
    img1(r1:r2,g1:g2)=img1(r1:r2,g1:g2)+h(x,y)*img0;
end

% extract the original size of img0
r1=floor(mh/2)+1;
r2=r1+mimg0-1;
g1=floor(nh/2)+1;
g2=g1+nimg0-1;
img1=img1(r1:r2, g1:g2);
end

