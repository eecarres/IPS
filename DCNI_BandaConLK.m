function [varargout] = DCNI_Multibanda (R720,R700,R670,iteracion,chkImagenes,chkProceso)
%---------------------------------------------------------------%
%    SW de Obtencion de NDVI a partir de irradiancia (Lk)
%---------------------------------------------------------------%
%   Master= NIR
%   B1= Red
%
%   LK:   Nivel de radiancia
%   NDVI: Indice de vigor de planta
%---------------------------------------------------------------%



%% Obtener valores de irradiancia de cada banda



%% Calcular valores NDVI
A=R720.LK;
B=R700.LK;
C=R670.LK;

 ima= (((A-B)./(B-C))./(A-C+0.003));



%Eliminación NAN=-1
s_ima=size(ima);
for i=1:s_ima(1)
    for j=1:s_ima(2)
        if isnan(ima(i,j))==1
            ima(i,j)=-1;
        end
    end
end

minimo = min(min(ima));
maximo = max(max(ima));

if chkProceso==1
ima2=figure;
imshow(ima);
title('Índices de Vegetación');
colorbar;
end

%% Se muestra si es necesario

if chkProceso==1
max_min=msgbox(strcat('Máximo: ',num2str(maximo),' Mínimo: ',num2str(minimo)),'Valor Máximo y Mínimo');
waitfor(max_min);



choice=questdlg('Recalibrar índices?','Recalibración Índices de Vegetación','Sí','No','Sí');
if strcmp(choice,'Sí')==1
    NDRVI_Recalibration_IV(0,ima,cmap,maximo,minimo,status_cuad,cuad_div); 
end
choice=questdlg('Guardar imagen?','Guardar imagen','Sí','No','Sí');
if strcmp(choice,'Sí')==1
    % Guardar imagen procesada con colormap
    
    path=char(R730.path(iteracion));
[~, name_im, ~] = fileparts(path);

 NDRVI_im_save(name_im,'DCNI',chkProceso,ima,cmap); 

   
end
else
    path=char(R720.path(iteracion));
[~, name_im, ~] = fileparts(path);

 

    varargout{1}= ima;
 

end