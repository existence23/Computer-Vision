function [composite_img] = compositeH(H2to1, template, img)

warp_cover = warpH(img, H2to1, size(template), 0);

index = find(warp_cover == 0);
warp_cover(index) = template(index);
composite_img = warp_cover;

end

