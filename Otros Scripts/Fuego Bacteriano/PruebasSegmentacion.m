

function [ ] = PruebasSegmentacion()

close all;
clearvars;

pathIm=('Alineada.tif');
[path,nombreIm,~]=fileparts(pathIm);
im=imread(pathIm);

%% Cargamos las bandas espectrales
R450=double(im(:,:,1))./2^16;
R550=double(im(:,:,2))./2^16;
R670=double(im(:,:,3))./2^16;
R710=double(im(:,:,4))./2^16;
R730=double(im(:,:,5))./2^16;
R780=double(im(:,:,6))./2^16;

FB1=double(im(:,:,8))./2^16;
%% 
RGB(:,:,1)=R670;
RGB(:,:,2)=R550;
RGB(:,:,3)=R450;

% subplot(1,3,1);
% imshow(RGB);
% imshow(RGB);
HSV=rgb2hsv(RGB);


% figure();
max(max(HSV))
max(max(RGB))
min(min(HSV))
min(min(RGB))
% imshow(HSV(:,:,1));
% figure();
% imshow(RGB);
% imshow([HSV(:,:,1),HSV(:,:,2),HSV(:,:,3);RGB(:,:,1),RGB(:,:,2),RGB(:,:,3)]);

CIR(:,:,1)=R780;
CIR(:,:,2)=R670;
CIR(:,:,3)=R550;

indice2=(R780+3*R710-4*R450); %)./(R780+R710);

subplot(1,2,1);imshow(CIR,[]);

subplot(1,2,2);imshow(indice2);



%% Prueba NDVI 730 780

indice1=(R780-R730) ./ (R780+R730);

indice2=(R780-R730) ;

subplot(1,2,1);imshow(indice1);

subplot(1,2,2);imshow(indice2);

maskFBhsv=ones(size(RGB(:,:,1)));
maskFBhsv2=ones(size(RGB(:,:,1)));


%Eliminamos valores de Indice 780+730-2*450
indice=R780+R730- 2.*R450;

% figure();imshow(RGB, []);
% figure();imshow(indice, []);

temp=(FB1>0.05);
maskFBhsv(temp)=0; %% Eliminamos todos los valores mayores que 0.1, que corresponden a vegetacion sana

 subplot(1,3,2);
 imshow(maskFBhsv);
 
temp=(indice<0.35);
maskFBhsv(temp)=0; %% Eliminamos suelo y vegetacion NO VERDE que no es FB

subplot(1,3,3);
imshow(maskFBhsv);
% 
% temp=(indice>0.50);
% maskFBhsv(temp)=0;


% %% Indice con pesos
indice=3.*R780+R730- 4.*R450;
% figure();imshow(RGB, []);
% figure();imshow(indice, []);
temp=(indice<0.3);
maskFBhsv2(temp)=0; %% Mostramos lo que no es suelo

temp=(indice>0.60);
maskFBhsv2(temp)=0;










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
SaveBandAsTiff2(nombreIm,maskFBhsv2);
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

function[] = SaveBandAsTiff2(nombreIm,band)

imwrite(band,[nombreIm,'_BandaFB2.tif']);


end

function [BW,maskedRGBImage] = segmentacionCIR(CIR)


% Convert RGB image to chosen color space
I = RGB;

% Define thresholds for channel 1 based on histogram settings
channel1Min = 142.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 90.000;
channel2Max = 255.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 138.000;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
end