function [rhoPos] = nearestRhoScaleValue(rho, rhoRes, minRho, maxRho)
%help function to find the nearest rho index, use binary search here
RHO=minRho:rhoRes:maxRho;
if rho<=minRho
    rhoPos=1;
    return;
elseif rho>=maxRho
    rhoPos=maxRho;
    return;
else
    left=1;
    right=length(RHO);
    while(left<=right)
        mid=left+fix((right-left)/2);
        if RHO(mid)==rho
            rhoPos=mid;
            return;
        elseif mid-1>0 && RHO(mid-1)==rho
            rhoPos=mid-1;
            return;
        elseif mid+1<=length(RHO) && RHO(mid+1)==rho
            rhoPos=mid+1;
            return;
        elseif mid-1>0 && RHO(mid-1)<rho && rho<RHO(mid)
            pos=mid-1;
            break;
        elseif mid+1<length(RHO) && RHO(mid)<rho && rho<RHO(mid+1)
            pos=mid;
            break;
        elseif  RHO(mid)<rho
            left=mid+1;
        else
            right=mid-1;
        end
    end
    
left=abs(RHO(pos)-rho);
right=abs(RHO(pos+1)-rho);
if left<=right
    rhoPos=pos;
else
    rhoPos=pos+1;
end



end

