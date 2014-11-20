

clear all;
clc
%% Leemos la imagen
e = imread('F:\z Marc\TETRACAM\selected_forPS_bybands\selected\9bandes\TTC2625v2geootb.tif');
%% Pasamos de 9 bandas a 6 
banda=0;
for i=4:9
    banda=banda+1;
Imatge6bandes(:,:,banda)=e(:,:,i); %Matriz que contiene las seis bandas   
    
end


t = Tiff('6bandasSeparate.tif','w');
tagstruct.ImageLength = size(Imatge6bandes,1);
tagstruct.ImageWidth = size(Imatge6bandes,2);
tagstruct.Photometric = Tiff.Photometric.Separated;
tagstruct.BitsPerSample = 16;
tagstruct.SamplesPerPixel = 6;
tagstruct.RowsPerStrip = 16;
tagstruct.ExtraSamples =[0 0 0];
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
tagstruct.Software = 'MATLAB';
t.setTag(tagstruct);
t.write(Imatge6bandes); 
t.close;