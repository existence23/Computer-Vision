function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
%Im - grayscale image - 
%threshold - prevents low gradient magnitude points from being included
%rhoRes - resolution of rhos - scalar
%thetaRes - resolution of theta - scalar
[m,n] = size(Im);
rhoScale = -norm(size(Im)):rhoRes:norm(size(Im));
thetaScale = -pi/2:thetaRes:pi/2;
%Initialize H
H = zeros(length(rhoScale),length(thetaScale));


for i = 1:m
    for j = i:n
        if Im(i,j)<threshold
            continue;
        else
            for m = 1:length(thetaScale)
                rho = j*cos(thetaScale(m)) + i*sin(thetaScale(m));
                thetaPos = m;
                
                %nearestRhoScaleValue is my help function to find the
                %nearest rho index
                rhoPos = nearestRhoScaleValue(rho, rhoRes, -norm(size(Im)), norm(size(Im)));
                H(rhoPos, thetaPos) = H(rhoPos, thetaPos)+1;
            end
        end
    end
end


end
        
        
