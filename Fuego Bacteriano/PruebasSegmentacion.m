





B=imread('TTC4939.tif','Index',2);
G=imread('TTC4939.tif','Index',3);
R=imread('TTC4939.tif','Index',4);
imshow([R,G,B]);


RGB(:,:,1)=R(:,:,1);
RGB(:,:,2)=G(:,:,1);
RGB(:,:,3)=B(:,:,1);
figure();
imshow(RGB);

HSV=rgb2hsv(RGB);

figure();
imshow([HSV(:,:,1),HSV(:,:,2),HSV(:,:,3)]);