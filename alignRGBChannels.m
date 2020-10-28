%Read the image
img = imread('course1image.jpg');
B=img(1:341,1:400);
G=img(342:682,1:400);
R=img(683:1023,1:400);

[rg,cg]=size(G);
rowCenter = ceil(rg/2);
columnCenter = ceil(cg/2);
ref_G=G(rowCenter-25:rowCenter+25, columnCenter-25:columnCenter+25);


regionB = double(B(rowCenter-25:rowCenter+25, columnCenter-25:columnCenter+25));
ref_img_region = double(G(rowCenter-25:rowCenter+25, columnCenter-25:columnCenter+25));
regionR = double(R(rowCenter-25:rowCenter+25, columnCenter-25:columnCenter+25));

 values = [];
 for i=-10:10;
     for j=-10:10;
        shiftr=circshift(regionR,[i,j]);
        ssd = sum(sum((ref_img_region-shiftr).^2));
        values = [values; [i j ssd]];
     end
 end
 values = sortrows(values, 3, 'ascend');
 v = values(1,1:2);
 y = v(1); x = v(2);
 shiftr = uint8(circshift(R,[y,x]));
 
 values = [];
 for i=-5:5;
     for j=-5:5
        shiftb=circshift(regionB,[i,j]);
        ssd = sum(sum((ref_img_region-shiftb).^2));
        values = [values; [i j ssd]];
     end
 end
 values = sortrows(values, 3, 'ascend');
 v = values(1,1:2);
 y = v(1); x = v(2);
 shiftb = uint8(circshift(B,[y,x]));

 ColorImg_aligned=cat(3,shiftr,G,shiftb);
 imshow(ColorImg_aligned)

