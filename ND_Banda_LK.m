function [ima] = ND_Banda_LK (chkImagenes,chkProceso,Banda,iteracion,varargin)
%-----------------------------------------------------%
%    SW de corrección de los valores ND a Lk
%-----------------------------------------------------%
%
%
%   ND:   Nivel Digital
%   Lk:   Valor de Irradiancia
% 
%   Mediante calibracion manual del blanco y negro/gris
%   Se utilizan placas calibradas de balance de blancos
%    
%   Valores de referencia de Refractancia:
%       Blanco: 0,9
%       Gris:   0,18
%-----------------------------------------------------%
%clear;


%% Modificación para simplificar los parámetros
valores_Banda=Banda.valores;
Banda_db=Banda.database;
calib_Banda=Banda.calib;
x1_Banda=Banda.X1;
reflectancias_Banda=Banda.reflectancias;



%% Entrada d'arxiu (convertir a valors numerics; no treballar amb uint8)
if nargin==5 % Imatges multibanda -> No es carrega la imatge, sino que ve per paràmetre
    ND=double(varargin{1});
else
    path_Banda=Banda.path(iteracion);
path_Banda=char(path_Banda);
[~, name_im, ~] = fileparts(path_Banda);
ND  = double(imread(path_Banda));
end
%% Escoger bandas (1=rojo, RGB)
ND_Banda  = ND(:,:,1);

%% Calibramos si tenemos seleccionada la opcion DentroImagen
if calib_Banda(1)==1 && calib_Banda(2)==0
    
    minimo1 = min(min(ND_Banda));
    maximo1 = max(max(ND_Banda));
    ima1=figure;
    imshow(ND_Banda);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda IR)');
    colorbar;
    [x,y]= ginput(3);
    maximo= ND_Banda( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_Banda( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_Banda( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    x1_Banda=[maximo minimo_g minimo_n];
    close(ima1);
    
end

%% Tipo de interpolación de datos
switch valores_Banda 
                case 1 %% Si seleccionamos la no interpolación NEGRO

                yi(1)=reflectancias_Banda(1);yi(2)=reflectancias_Banda(3);
                xi(1)=x1_Banda(1);xi(2)=x1_Banda(3);
                
                
                 case 2 %% Si seleccionamos la no interpolación GRIS

               yi(1)=reflectancias_Banda(1);yi(2)=reflectancias_Banda(2);
               xi(1)=x1_Banda(1);xi(2)=x1_Banda(2);
                
                case 3
    
        prompt={'Reflectancia blanco:','Reflectancia gris:','Reflectancia negro:','Param. interpolación 1:','Param. interpolación 2:','sin interpolar (0 es si):'};
        %     prompt={'Reflectancia blanco:','Reflectancia gris:','Reflectancia negro:','Param. interpolación 1:','Param. interpolación 2:'};
        dlg_title='Parámetros';
        num_lines=1;
        def={'0.9','0.18','0.05','200','150','0'};
        %     def={'0.9','0.18','0.05','200','150'};
        answer=inputdlg(prompt,dlg_title,num_lines,def);
        data=str2double(answer);

         if data(6)==1
            y1(1)=data(1); y1(2)=data(2); y1(3)=data(3); %y1=[0.9 0.18 0.1];
            xi(1)=data(4); xi(2)=data(5); %xi=[220 180];
            yi=interp1(x1_Banda,y1,xi,'linear');
        else
            yi(1)=data(1);yi(2)=data(3);
            xi(1)=x1_Banda(1);xi(2)=x1_Banda(3);
        end

        %     y1(1)=data(1); y1(2)=data(2); y1(3)=data(3); %y1=[0.9 0.18 0.1];
        %     xi(1)=data(4); xi(2)=data(5); %xi=[220 180];
        %     yi=interp1(x1_IR,y1,xi,'linear');

        otherwise

        y1(1)=reflectancias_Banda(1); y1(2)=reflectancias_Banda(2); y1(3)=reflectancias_Banda(3); %y1=[0.9 0.18 0.1];
        xi(1)=Banda_db(valores_Banda-1,1); xi(2)=Banda_db(valores_Banda-1,2); %xi=[220 180];
        yi=interp1(x1_Banda,y1,xi,'linear');

        end
   

%% Cálculo de LK
% Calcular valores LK a partir del nivel digital(radiancia)
% La referencia son las placas de grises: Blanco (0,9) y gris (0,18)
a= (yi(1)-yi(2)) /(xi(1)-xi(2));
b= yi(1) - (xi(1)*a);

ima     = ND_Banda* a + b;

%Limitar la reflectancia de 0-1
[X1,Y1] = find(ima>1);
[X2,Y2] = find(ima<0);

[M1,N1] = size(X1);
[M2,N2] = size(X2);

if isempty(M1)
    
else

for i= 1 : M1
    
    ima(X1(i), Y1(i))=1;
    
end
% msgbox (['Hay reflectancias por encima de uno en la imagen',num2str(iteracion)]);
M1
end


if isempty(M2)
    
else
for z= 1 : M2
    
    ima(X2(z), Y2(z))=0;

end
% msgbox (['Hay reflectancias por debajo de cero en la imagen',num2str(iteracion)]);
M2
end

%% Mostrar Lk si se ha pedido
if chkProceso==1
ima2=figure;
imshow(ima);
colorbar;
title('Valores de irradiancia IR');
saveas(ima2,strcat(name_im,'_LK_IR1.jpg'));  % here you save the figure
end
%% Guardar nueva Imagen si se pide
if chkImagenes==0
imwrite(ima,strcat('Procesadas/',name_im,'_LK_IR.jpg'));
end
clearvars -except ima