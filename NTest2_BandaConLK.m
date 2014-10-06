function [varargout]= NTest2_BandaConLK (R670,R950,iteracion,chkImagenes,chkProceso)

%---------------------------------------------------------------%
%    SW de Obtencion de MCARI a partir de irradiancia (Lk)
%---------------------------------------------------------------%
%   
%   LK:   Nivel de radiancia
%   NDVI: Indice de vigor de planta
%---------------------------------------------------------------%




%% Calcular valores NDVI
A=R670.LK;
B=R950.LK;


 ima=     (A+B) ./ (B-A)   ;



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
    
    path=char(R780.path(iteracion));
[~, name_im, ~] = fileparts(path);

 NDRVI_im_save(name_im,'PRI',chkProceso,ima,cmap); 

   
end
else
    path=char(R670.path(iteracion));
[~, name_im, ~] = fileparts(path);


    varargout{1}= ima;


end
