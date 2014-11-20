%% Script para separar Tiffs 16 bits procesados en imágenes separadas


close all;
clearvars;

pathIm=('TTC5196ConIndices.tif');
[path,nombreIm,~]=fileparts(pathIm);
im=imread(pathIm);
bands=size(im); bands=bands(3);



for i=1:bands
band=double(im(:,:,i));
band=band/max(max(band));
band=uint16(band*2^16);
imwrite(band,[nombreIm,'_banda_',num2str(i),'.tif']);
end
