function [bin, rectangles] = preprocessing(I)
rectangles = zeros(1000,4);

threshold = 64300;
threshold2 = 64450;
threshold3 = 65500;
area = 400;
n = 1;

bin = I>threshold;
bin = bwmorph(bin,'hbreak');
bin = bwmorph(bin,'spur');
bin = bwmorph(bin,'clean');
s = regionprops(bin, I, 'Area', 'BoundingBox','PixelValues');
bin = bwmorph(bin, 'remove');

for h = 1:size(s)
    if(s(h).Area>area && max(s(h).PixelValues)>threshold2 || max(s(h).PixelValues)>threshold3)
        rectangles(n,:) = s(h).BoundingBox;
        n = n + 1;
    end
end

rectangles(all(~rectangles,2),:) = [];
end