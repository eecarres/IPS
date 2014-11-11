

function [ ] = PruebasSegmentacion()

close all;
clearvars;

pathIm=('TTC4977ConIndices.tif');
[path,nombreIm,~]=fileparts(pathIm);
im=imread(pathIm);


RGB(:,:,1)=im(:,:,3);
RGB(:,:,2)=im(:,:,2);
RGB(:,:,3)=im(:,:,1);

% imshow(RGB);
HSV=rgb2hsv(RGB);
RGB=double(RGB);
RGB=RGB/2^16;
figure();
max(max(HSV))
max(max(RGB))
min(min(HSV))
min(min(RGB))
imshow(HSV(:,:,1));
figure();
imshow(RGB);
% imshow([HSV(:,:,1),HSV(:,:,2),HSV(:,:,3);RGB(:,:,1),RGB(:,:,2),RGB(:,:,3)]);

maskFBhsv=zeros(size(RGB(:,:,1)));


%Segmentamos por color
temp=find(HSV(:,:,1)<0.08);
maskFBhsv(temp)=1;

NIR=double(im(:,:,6));
NIR=NIR/2^16;
figure();
imshow(NIR);

%Eliminamos todos los elementos que reflejan NIR
temp=find(NIR(:,:)>0.3);
maskFBhsv(temp)=0;

FB1=double(im(:,:,8));
FB1=FB1/max(max(FB1));
figure();
imshow(FB1);

%Eliminamos todos los valores que no son marcados como FB por FB1
temp=find(FB1(:,:)>0.05);
maskFBhsv(temp)=0;

% Eliminamos valores de luminancia mayores de 0.08
temp=find(HSV(:,:,3)>0.08);
maskFBhsv(temp)=0;

%Eliminamos valores de Azul que no son 0
% temp=find(RGB(:,:,3)>0);
% maskFBhsv(temp)=0;

%% Muestra de la imagen RGB Segmentada vs la imagen RGB original

% RGBSeg=RGB;
% RGBSeg(:,:,1)=RGBSeg(:,:,1).*maskFBhsv;
% RGBSeg(find(maskFBhsv==1))=+0.4;
% RGBSeg(:,:,2)=RGBSeg(:,:,2).*maskFBhsv;
% RGBSeg(:,:,3)=RGBSeg(:,:,3).*maskFBhsv;

% figure(); % Muestra la imagen RGB frente a la segmentación realizada
% imshow([RGB,RGBSeg]);

%% Guarda los resultados como un fichero independiente o dentro del mismo Tiff

maskFBhsv=uint16(maskFBhsv.*2^16);
SaveBandAsTiff(nombreIm,maskFBhsv);
% SaveTiffplusBand(im,nombreIm,maskFBhsv);
% close all;
end





function[] = SaveTiffplusBand(originalTiff,nombreIm,band)

numBandas=size(originalTiff);
numBandas=numBandas(3)+1;
dataImProcesada(:,:,numBandas)= band;

TiffGuardar = Tiff([nombreIm,'_FB_segmentado.tif'],'w'); % Se carga todos los datos que no son la banda 10 ??¿¿??
tagstruct.ImageLength = size(originalTiff,1);
tagstruct.ImageWidth = size(originalTiff,2);
tagstruct.Photometric = Tiff.Photometric.Separated;
tagstruct.BitsPerSample = 16;
tagstruct.SamplesPerPixel =numBandas;
tagstruct.RowsPerStrip = 16;
tagstruct.ExtraSamples =zeros(1,numBandas);
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
tagstruct.Software = 'MATLAB';
TiffGuardar.setTag(tagstruct);
TiffGuardar.write(dataImProcesada);
TiffGuardar.close;

end

function[] = SaveBandAsTiff(nombreIm,band)

imwrite(band,[nombreIm,'_BandaFB.tif']);


end


