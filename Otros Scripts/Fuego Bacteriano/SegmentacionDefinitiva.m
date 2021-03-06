

function [ ] = SegmentacionDefinitiva()
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


CIR(:,:,1)=R780;
CIR(:,:,2)=R670;
CIR(:,:,3)=R550;

CIR_u8=uint8(CIR.*255);

%% Realizamos la primera segmentacion en CIR

 [CIRMask,CIRSegment] = segmentacionCIR(CIR_u8);
 mascara=double(CIRMask);
 mascara=uint8(mascara.*255);
 %% Realizamos la segunda segmentaci�n con la primera m�scara y las bandas 710 y 730
 
 
 
 Im(:,:,1)=mascara;
 Im(:,:,2)=uint8(R710.*255);
 Im(:,:,3)=uint8(R730.*255);
 
  [DefMask,DefSegment] =SegmentacionDef(Im);
 
 
 se=strel('diamond',2);
%  ErodedSegment=imerode(DefSegment,se); %Erosion
 ErodedSegment=imopen(DefSegment,se); % Opening

subplot(2,2,1);imshow(CIR_u8); imwrite(CIR_u8,'CIR_10metros.jpg');

subplot(2,2,2);imshow(CIRSegment,[]);imwrite(CIRSegment,'CIR_Seg_10metros.jpg');

subplot(2,2,3);imshow(DefSegment,[]);imwrite(DefSegment,'CIR_Seg2_10metros.jpg');

subplot(2,2,4);imshow(ErodedSegment,[]);imwrite(ErodedSegment,'CIR_opening_10metros.jpg');











%% Guarda los resultados como un fichero independiente o dentro del mismo Tiff

% maskFBhsv=uint16(maskFBhsv.*2^16);
% SaveBandAsTiff(nombreIm,maskFBhsv);
end



function [BW,maskedRGBImage] = segmentacionCIR(CIR)


% Convert RGB image to chosen color space
I = CIR;

% Define thresholds for channel 1 based on histogram settings
channel1Min = 142.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 90.000;%90
channel2Max = 255.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 138.000;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

% Initialize output masked image based on input image.
maskedRGBImage = CIR;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
end


% Auto-generated by colorThresholder app on 13-Nov-2014
%-------------------------------------------------------

function [BW,maskedRGBImage] = SegmentacionDef(RGB)

% Convert RGB image to chosen color space
I = RGB;

% Define thresholds for channel 1 based on histogram settings
channel1Min = 125.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 130.000;
channel2Max = 181.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 45.000;
channel3Max = 204.000;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end


function[] = SaveBandAsTiff(nombreIm,band)

imwrite(band,[nombreIm,'_BandaFB.tif']);


end