function [varargout] =NDVI_Multibanda(R670,R780,iteracion,chkImagenes,chkProceso) % Primero NIR luego RED
%---------------------------------------------------------------%
%    SW de Obtencion de NDVI a partir de irradiancia (Lk)
%---------------------------------------------------------------%
%   Se debe pasar como parámetro el valor digital de el infrarojo y del
%   rojo, en ese orden.
%
%   LK:   Nivel de radiancia
%   NDVI: Indice de vigor de planta
%---------------------------------------------------------------%

%% Obtener valores de irradiancia de cada banda


ND_IR= R780.LK;  
ND_RED= R670.LK;   
     



 %% Calcular valores NDVI

 ima=(ND_IR-ND_RED)./(ND_IR+ND_RED);


% switch status_NDVI
%     
%     case 1
%         
%         ima=(ND_IR-ND_RED)./(ND_IR+ND_RED);
%         
%     case 2
%         
%         ima=((ND_IR-ND_RED)./(ND_IR+ND_RED+0.5))*1.5; %SAVI
%         
%     case 3
%         
%         ima=(((ND_IR-ND_RED)./(ND_IR+ND_RED))+1)/2; %%NDVI infragram
%         
%     case 4
%         
%         ima=(ND_IR)./(ND_RED); %PaD
% 
%     case 5
%         
%         ima=(((ND_IR)./(ND_RED))+1)/2; %PaD Infragram
%         
% end

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
                        NDRVI_im_save(name_im,'NDVI',chkProceso,ima,ColMap); 


                    end

else
            path=char(R780.path(iteracion));
         [~, name_im, ~] = fileparts(path);


            varargout{1}= ima;
    


end