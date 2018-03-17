function [rhos, thetas] = myHoughLines(H, nLines)

[h1,h2]=size(H);
rhos=zeros(nLines,1);
thetas=zeros(nLines,1);

%non-maximum suppression
di = [-1,0,1];
dj = [-1,0,1];
HCopy = H;
for i = 1:h1
    for j = 1:h2
        for a = i+di
            for b = j+dj
                if (a~=i || b~=j) && a>0 && a<=h1 && b>0 && b<=h2 && HCopy(a,b)>HCopy(i,j)
                    H(i,j) = 0;
                end
            end
        end
    end
end

%I is the sorted index of one row format of H
[B,I]=sort(H(:),'descend');
for i =1:nLines
    index = I(i);
    x=mod((index-1),h1)+1;
    y=fix((index-1)/h1)+1;
    rhos(i)=x;
    thetas(i)=y;
end
end

   