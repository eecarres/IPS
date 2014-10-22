





B=imread('D:\Proyectos\2014_09_27 Foc Bacteria alcarras\Tiffs MultiPage\TTC4859.tif','Index',2);
G=imread('D:\Proyectos\2014_09_27 Foc Bacteria alcarras\Tiffs MultiPage\TTC4859.tif','Index',3);
R=imread('D:\Proyectos\2014_09_27 Foc Bacteria alcarras\Tiffs MultiPage\TTC4859.tif','Index',4);
imshow([R,G,B]);


RGB(:,:,1)=R(:,:,1);
RGB(:,:,2)=G(:,:,1);
RGB(:,:,3)=B(:,:,1);
figure();
imshow(RGB);

HSV=rgb2hsv(RGB);

figure();
imshow([HSV(:,:,1),HSV(:,:,2),HSV(:,:,3)]);