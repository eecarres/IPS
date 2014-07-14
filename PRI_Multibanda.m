function [varargout]= PRI_Multibanda (R530,R570,iteracion,chkImagenes,chkProceso,tipoCmap,boolHist,status_cuad,cuad_div,rgb_g_limits,auxiliar_limits,status_suelo,check_aux,varargin)

%---------------------------------------------------------------%
%    SW de Obtencion de TCARI/OSAVI a partir de irradiancia (Lk)
%---------------------------------------------------------------%
%   
%   LK:   Nivel de radiancia
%   NDVI: Indice de vigor de planta
%---------------------------------------------------------------%

%% Obtener valores de irradiancia de cada banda


if nargin==15% En este caso entra una imagen multibanda, de modo que en lugar de los paths se pasan las matrices
%msgbox(num2str(nargin));
LK_R530= ND_Banda_LK (chkImagenes,chkProceso,R530,iteracion,varargin{1}); 
LK_R570= ND_Banda_LK (chkImagenes,chkProceso,R570,iteracion,varargin{2}); 

     
elseif nargin ==13
LK_R530= ND_Banda_LK (chkImagenes,chkProceso,R530,iteracion); 
LK_R570= ND_Banda_LK (chkImagenes,chkProceso,R570,iteracion); 

    

else % Entran las imágenes en los objetos banda, por lo tanto el procedimiento es el típico y se pasan los paths
  
msgbox(['Error, caso no identificado, entradas totales= ',num2str( nargin)],'Error');
    return;
    
end


%% Calcular valores NDVI
A=LK_R530;
B=LK_R570;

 ima= (A-B)./(A+B);



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
s_cmap=size(tipoCmap);
for i=1:s_cmap(2)
    if tipoCmap(i)==1
        selection=i;
    end
end

switch selection
    
    case 1 %RGB/Gris
        
        g_div=64;
        cmap=zeros(g_div,3);

        for i=1:g_div %Preparar colormap escala grises
            cmap(i,1)=(i-1)/(g_div-1); cmap(i,2)=cmap(i,1); cmap(i,3)=cmap(i,1);
        end
        
        if status_suelo==1 %Opción suelo blanco
            if rgb_g_limits(1)*g_div>=2 %Comprobar donde empieza el primer límite
                for i=1:round(rgb_g_limits(1)*g_div) %Asignar color blanco
                    cmap(i,1)=1; cmap(i,2)=cmap(i,1); cmap(i,3)=cmap(i,1);
                end 
            end 
        end
        
        if rgb_g_limits(1)*g_div<0.5 %Comprobar el primer límite para índice diferente 0
            for i=1:round(rgb_g_limits(2)*g_div)
                cmap(i,1)=0; cmap(i,2)=0; cmap(i,3)=1;
            end 
        else
            for i=round(rgb_g_limits(1)*g_div):round(rgb_g_limits(2)*g_div)
                cmap(i,1)=0; cmap(i,2)=0; cmap(i,3)=1;
            end
        end

        for i=round(rgb_g_limits(3)*g_div)+1:round(rgb_g_limits(4)*g_div)
            cmap(i,1)=0; cmap(i,2)=1; cmap(i,3)=0;
        end

        for i=round(rgb_g_limits(5)*g_div)+1:round(rgb_g_limits(6)*g_div)
            cmap(i,1)=1; cmap(i,2)=0; cmap(i,3)=0;
        end
        
        if check_aux(1)==1
            for i=round(auxiliar_limits(1)*g_div):round(auxiliar_limits(2)*g_div)
                cmap(i,1)=1; cmap(i,2)=cmap(i,1); cmap(i,3)=cmap(i,1);
            end
        end
        
        if check_aux(2)==1
            for i=round(auxiliar_limits(3)*g_div):round(auxiliar_limits(4)*g_div)
                cmap(i,1)=1; cmap(i,2)=cmap(i,1); cmap(i,3)=cmap(i,1);
            end            
        end
        
        if check_aux(3)==1
            for i=round(auxiliar_limits(5)*g_div):round(auxiliar_limits(6)*g_div)
                cmap(i,1)=1; cmap(i,2)=cmap(i,1); cmap(i,3)=cmap(i,1);
            end            
        end
        
        colormap(cmap);
        
    case 2 %Jet
        
        load colormaps
        ColMap=Edu;
        
    case 3 %Rainbow
        
        rainbow=zeros(10,3);
        
        rainbow(1,1)=1; rainbow(1,2)=0; rainbow(1,3)=0;
        rainbow(2,1)=1; rainbow(2,2)=127/255; rainbow(2,3)=0;
        rainbow(3,1)=1; rainbow(3,2)=1; rainbow(3,3)=0;
        rainbow(4,1)=0; rainbow(4,2)=1; rainbow(4,3)=0;
        rainbow(5,1)=0; rainbow(5,2)=1; rainbow(5,3)=127/255;
        rainbow(6,1)=0; rainbow(6,2)=1; rainbow(6,3)=1;
        rainbow(7,1)=0; rainbow(7,2)=127/255; rainbow(7,3)=1;
        rainbow(8,1)=0; rainbow(8,2)=0; rainbow(8,3)=1;
        rainbow(9,1)=127/255; rainbow(9,2)=0; rainbow(9,3)=1;
        rainbow(10,1)=1; rainbow(10,2)=0; rainbow(10,3)=1;
        
        cmap=rainbow;
        colormap(rainbow);
        
end

if status_cuad==1
%     s_ima=size(ima);
    for i=1:cuad_div(1)-1
        hold on
        x_cuad(1)=i*s_ima(2)/cuad_div(1);
        x_cuad(2)=x_cuad(1);
        y_cuad(1)=0;
        y_cuad(2)=s_ima(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
    for j=1:cuad_div(2)-1
        hold on
        x_cuad(1)=0;
        x_cuad(2)=s_ima(2);
        y_cuad(1)=j*s_ima(1)/cuad_div(2);
        y_cuad(2)=y_cuad(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
end

%% Histograma

if boolHist==1
    ima_aux=ima;
    for i=1:s_ima(1)
        for j=1:s_ima(2)
            if ima_aux(i,j)<0
                ima_aux(i,j)=0;
            end
        end
    end
    figure;
    imhist(ima_aux);
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
    path=char(R530.path(iteracion));
[~, name_im, ~] = fileparts(path);


if nargin==15
    varargout{1}= ima;
    
else
  NDRVI_im_save(name_im,'PRI',chkProceso,ima,ColMap); 
end

end
