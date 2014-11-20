

clear all;
clc
%% Leemos la imagen
e = imread('F:\z Marc\TETRACAM\selected_forPS_bybands\selected\9bandes\TTC2625v2geootb.tif');
%% Pasamos de 9 bandas a 6 

for i=1:3
    
    Imatge6bandes(:,:,i)=e(:,:,i); %Matriz que contiene las seis bandas   
    
end


t = Tiff('3bandas.tif','w');
tagstruct.ImageLength = size(Imatge6bandes,1);
tagstruct.ImageWidth = size(Imatge6bandes,2);
tagstruct.Photometric = Tiff.Photometric.Separated;
tagstruct.BitsPerSample = 16;
tagstruct.SamplesPerPixel = 3;
%tagstruct.RowsPerStrip = 16;
%tagstruct.ExtraSamples =[1 1 1];
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
tagstruct.Software = 'MATLAB';
t.setTag(tagstruct);
t.write(Imatge6bandes); 
t.close;