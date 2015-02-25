function [  ] = SaveTiff( path, data,tiffType)
%% Script para guardar Tiffs

% See
% http://es.mathworks.com/help/matlab/import_export/exporting-to-images.html#br_c_iz-8 ) 
% to change parameters
%
%% Input parameters:
%
%
%   path = path del archivo que se quiere crear, incluyendo el nombre y .tif
%
%   data = datos de la imagen
%
%   tiffType = '8bits','16bits','index'

%% Retrieve data information
length=size(data,1);
width=size(data,2);
bandNumber=size(data,3);

%% Open the tiff file
TiffGuardar = Tiff([path],'w');

%% Changes configuration depending on input

if bandNumber>1
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
else
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
end


switch tiffType
    
    case '8bits'
            tagstruct.BitsPerSample = 8; % Bit depth (32 to be IEEEP)
            tagstruct.SampleFormat = 1; % Decides between uint (1), int (2) or IEEEFP (3)
            
    case '16bits'
            tagstruct.BitsPerSample = 16; % Bit depth (32 to be IEEEP)
            tagstruct.SampleFormat = 1; % Decides between uint (1), int (2) or IEEEFP (3)
            
    case 'index'
            tagstruct.BitsPerSample = 32; % Bit depth (32 to be IEEEP)
            tagstruct.SampleFormat = 3; % Decides between uint (1), int (2) or IEEEFP (3)
end



%% Set the tags of the tiff
            tagstruct.ImageLength = length;
            tagstruct.ImageWidth = width;
            tagstruct.Photometric = Tiff.Photometric.Separated;
            
            tagstruct.SamplesPerPixel =bandNumber;
            tagstruct.RowsPerStrip = 16;
            tagstruct.ExtraSamples =zeros(1,bandNumber);
            
            tagstruct.Software = 'MATLAB';
            TiffGuardar.setTag(tagstruct);

 %% Save the file
   
TiffGuardar.write(data); 
TiffGuardar.close
         






end

