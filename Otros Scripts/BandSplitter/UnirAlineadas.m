%% Une las imágenes una vez alineadas

clearvars;
close all;

pathIm=('TTC4974ConIndices.tif');
[path,nombreIm,~]=fileparts(pathIm);
im=imread(pathIm);
bands=6;

for i=1:bands
dataIm(:,:,i)=imread(['Validacion FB Alineada (La Redonda 2)\TTC4974ConIndices_banda_',num2str(i),'_Alineada.tif']);
end

%% Sacamos las reflectancias
R450=double(dataIm(:,:,1))./2^16;
R550=double(dataIm(:,:,2))./2^16;
R670=double(dataIm(:,:,3))./2^16;
R710=double(dataIm(:,:,4))./2^16;
R730=double(dataIm(:,:,5))./2^16;
R780=double(dataIm(:,:,6))./2^16;

%% Cálculo del NDVI

bands=bands+1;
dataIm(:,:,bands)=uint16 (2^16*  ( (R780-R670) ./ (R780+R670) )) ;


%% Cálculo de FB1

bands=bands+1;
dataIm(:,:,bands)=uint16 (2^16*  ( (R730-R670) ./ (R730+R670) .* (R550-R450) ./ (R550+R450) )) ;



%% Cálculo de FB2

bands=bands+1;
dataIm(:,:,bands)=uint16 (2^16*  ( (R780-R670) ./ (R780+R670) .* (R550-R450) ./ (R550+R450) )) ;

%% Cálculo de FB3

bands=bands+1;
dataIm(:,:,bands)=uint16 (1000*  ( (R780-R450) ./ (R780+R450) )) ;

%% Cálculo de FB4 = Diferencia entre 730 y 450 *

bands=bands+1;
dataIm(:,:,bands)=uint16 (1000*  ( (R780-R450)  .* (R550-R450))) ;


TiffGuardar = Tiff(['Alineada','.tif'],'w');
            tagstruct.ImageLength = size(dataIm,1);
            tagstruct.ImageWidth = size(dataIm,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =bands;
            tagstruct.RowsPerStrip = 16;
            tagstruct.ExtraSamples =zeros(1,6);
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
            tagstruct.Software = 'MATLAB';
            TiffGuardar.setTag(tagstruct);
            TiffGuardar.write(dataIm); 
            TiffGuardar.close;




