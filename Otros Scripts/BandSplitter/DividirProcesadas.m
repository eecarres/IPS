%% Script para separar Tiffs 16 bits procesados en imágenes separadas


close all;
clearvars;

pathIm=('TTC4974ConIndices.tif');
[path,nombreIm,~]=fileparts(pathIm);
im=imread(pathIm);
bands=size(im); bands=bands(3);



for i=1:bands
band=im(:,:,i);
imwrite(band,[nombreIm,'_banda_',num2str(i),'.tif']);
end
