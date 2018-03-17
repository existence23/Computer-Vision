function [Im,Io,Ix,Iy] = myEdgeFilter(img, sigma)
%Your implemention
hsize=2*ceil(3*sigma)+1;
K=fspecial('gaussian',hsize,sigma);
imageSmooth=myImageFilter(img,K);
%sobel filter
Sx=zeros(3,3);
Sx(1,1)=1;
Sx(1,3)=-1;
Sx(2,1)=2;
Sx(2,3)=-2;
Sx(3,1)=1;
Sx(3,3)=-1;
Sy=zeros(3,3);
Sy(1,1)=-1;
Sy(1,2)=-2;
Sy(1,3)=-1;
Sy(3,1)=1;
Sy(3,2)=2;
Sy(3,3)=1;

Ix=myImageFilter(imageSmooth,Sx);
Iy=myImageFilter(imageSmooth,Sy);

Im=sqrt(Ix.^2+Iy.^2);
Io=atan2(Iy,Ix);
Itemp = Io;
Io=Io*180/pi;

%Map the gradient angle to the closest of 4 cases
Io=mod((round(Io/45))*45,180);
%Io=Io*pi/180;


[m,n]=size(Im);
% Imtemp=Im;
% Im=zeros(m-2,n-2);
% for i=1:m-2
%     for j=1:n-2
%         Im(i,j)=Imtemp(i+1,j+1);
%     end
% end


ImCopy = Im;
[m,n]=size(Im);

for i = 1:m
    for j = 1:n
        if Io(i,j)==0
            if((j>1 && ImCopy(i,j)<ImCopy(i,j-1)) || (j<n && ImCopy(i,j)<ImCopy(i,j+1)))
                Im(i,j)=0;
            end
            
        elseif Io(i,j)==45
            if((i<m && j>1 && ImCopy(i,j)<ImCopy(i+1,j-1)) || (i>1 && j<n && ImCopy(i,j)<ImCopy(i-1,j+1)))
                Im(i,j)=0;
            end
        elseif Io(i,j)==90
            if((i>1 && ImCopy(i,j)<ImCopy(i-1,j)) || (i<m && ImCopy(i,j)<ImCopy(i+1,j)))
                Im(i,j) = 0;
            end
        else 
            if((i<m && j<n && ImCopy(i,j)<ImCopy(i+1,j+1)) || (i>1 && j>1 && ImCopy(i,j)<ImCopy(i-1,j-1)))
                Im(i,j)=0;
            end
        end
    end
end
Io = Itemp;
end
    
                
        
        
