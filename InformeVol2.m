function [varargout] = InformeVol2(nombreProyecto,pathProyecto,nombreImagen)
%Informe de calidad para el cliente, no hay que incluir cosas propias de la
%empresa como puede ser la configuraci�n de la TetraCam
%Para llamar a la funcion de creacion de informe=> publish('Informe.m','codeToEvaluate','Informe(R780)');
%bandasProyecto est� ordenada de menos a mas LDO (LDO menor primero)
%imagen16Bits esta desodenada (Master primero)
%% Informe de calidad del post procesado - Hemav: Datos de la misi�n
% Nombre de la misi�n:
disp('Vol 1 Algerri Balaguer');
disp('TTC3218.tif');
load(['C:/Agromav IPS/',nombreProyecto,'/Informe/',nombreProyecto,'.mat']);
%% 
% Configuraci�n de las bandas en TetraCam
bandasOrdenadas(1)=Bandas(2);
bandasOrdenadas(2)=Bandas(3);
bandasOrdenadas(3)=Bandas(4);
bandasOrdenadas(4)=Bandas(5);
bandasOrdenadas(5)=Bandas(6);
bandasOrdenadas(6)=Bandas(1);
disp(char(bandasOrdenadas));

%% 
% Datos de calibraci�n
disp('Datos de calibraci�n de cada banda [reflectancia / valor digital]');
disp(['Banda 1 (',char(Bandas(2)),'):']);
disp(['         Blanco:',num2str(bandasProyecto(1).reflectancias(1)),' / ',num2str(bandasProyecto(1).X1(1))]);
% disp(['         Gris:',num2str(bandasProyecto(1).reflectancias(2)),' / ',num2str(bandasProyecto(1).X1(2))]);
% disp(['         Negro:',num2str(bandasProyecto(1).reflectancias(3)),' / ',num2str(bandasProyecto(1).X1(3))]);
disp(['Banda 2 (',char(Bandas(3)),'):']);
disp(['         Blanco:',num2str(bandasProyecto(2).reflectancias(1)),' / ',num2str(bandasProyecto(2).X1(1))]);
% disp(['         Gris:',num2str(bandasProyecto(2).reflectancias(2)),' / ',num2str(bandasProyecto(2).X1(2))]);
% disp(['         Negro:',num2str(bandasProyecto(2).reflectancias(3)),' / ',num2str(bandasProyecto(2).X1(3))]);
disp(['Banda 3 (',char(Bandas(4)),'):']);
disp(['         Blanco:',num2str(bandasProyecto(3).reflectancias(1)),' / ',num2str(bandasProyecto(3).X1(1))]);
% disp(['         Gris:',num2str(bandasProyecto(3).reflectancias(2)),' / ',num2str(bandasProyecto(3).X1(2))]);
% disp(['         Negro:',num2str(bandasProyecto(3).reflectancias(3)),' / ',num2str(bandasProyecto(3).X1(3))]);
disp(['Banda 4 (',char(Bandas(5)),'):']);
disp(['         Blanco:',num2str(bandasProyecto(4).reflectancias(1)),' / ',num2str(bandasProyecto(4).X1(1))]);
% disp(['         Gris:',num2str(bandasProyecto(4).reflectancias(2)),' / ',num2str(bandasProyecto(4).X1(2))]);
% disp(['         Negro:',num2str(bandasProyecto(4).reflectancias(3)),' / ',num2str(bandasProyecto(4).X1(3))]);
disp(['Banda 5 (',char(Bandas(6)),'):']);
disp(['         Blanco:',num2str(bandasProyecto(5).reflectancias(1)),' / ',num2str(bandasProyecto(5).X1(1))]);
% disp(['         Gris:',num2str(bandasProyecto(5).reflectancias(2)),' / ',num2str(bandasProyecto(5).X1(2))]);
% disp(['         Negro:',num2str(bandasProyecto(5).reflectancias(3)),' / ',num2str(bandasProyecto(5).X1(3))]);
disp(['Banda M�ster (',char(Bandas(1)),'):']);
disp(['         Blanco:',num2str(bandasProyecto(6).reflectancias(1)),' / ',num2str(bandasProyecto(6).X1(1))]);
% disp(['         Gris:',num2str(bandasProyecto(6).reflectancias(2)),' / ',num2str(bandasProyecto(6).X1(2))]);
% disp(['         Negro:',num2str(bandasProyecto(6).reflectancias(3)),' / ',num2str(bandasProyecto(6).X1(3))]);

%% An�lisis de las im�genes de Entrada
% Imagen aleatoria del vuelo y histograma asociado a cada banda
imagen16Bits=imread([pathProyecto,'/',nombreImagen]);
imAjustadaB1=imadjust(imagen16Bits(:,:,1));
imAjustadaB2=imadjust(imagen16Bits(:,:,2));
imAjustadaB3=imadjust(imagen16Bits(:,:,3));
imAjustadaB4=imadjust(imagen16Bits(:,:,4));
imAjustadaB5=imadjust(imagen16Bits(:,:,5));
imAjustadaB6=imadjust(imagen16Bits(:,:,6));


 leyendaBandas(1)=Bandas(2);
 leyendaBandas(2)=Bandas(3);
 leyendaBandas(3)=Bandas(4);
 leyendaBandas(4)=Bandas(5);
 leyendaBandas(5)=Bandas(6);
 leyendaBandas(6)=Bandas(1);

%Mostramos las im�genes
      figure('Name','Imagen original 16 bits','Position',[0 0 1920 700]);
          subplot(2,6,1);
          imshow(imAjustadaB2);
                    subplot(2,6,2);
          imshow(imAjustadaB3);
                    subplot(2,6,3);
          imshow(imAjustadaB4);
                    subplot(2,6,4);
          imshow(imAjustadaB5);
                    subplot(2,6,5);
          imshow(imAjustadaB6);
                    subplot(2,6,6);
          imshow(imAjustadaB1);
%Sacamos cada histograma como un grafico de barras para simplificar

 subplot(2,6,7);
          [valoresY1,valoresX1]=imhist(imagen16Bits(:,:,2),4096);
          valoresY1PCT=(valoresY1/sum(valoresY1))*100;
          bar(valoresX1,valoresY1PCT);
          axis([0 max(max(imagen16Bits(:,:,2))) 0 max(valoresY1PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(1).banda) ]);
          ylabel('%');
          
                    subplot(2,6,8);
          [valoresY2,valoresX2]=imhist(imagen16Bits(:,:,3),4096);
          valoresY2PCT=(valoresY2/sum(valoresY2))*100;
          bar(valoresX2,valoresY2PCT);
          axis([0 max(max(imagen16Bits(:,:,3))) 0 max(valoresY2PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(2).banda) ]);
          ylabel('%');
          
                    subplot(2,6,9);
         [valoresY3,valoresX3]=imhist(imagen16Bits(:,:,4),4096);
          valoresY3PCT=(valoresY3/sum(valoresY3))*100;
          bar(valoresX3,valoresY3PCT);
          axis([0 max(max(imagen16Bits(:,:,4))) 0 max(valoresY3PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(3).banda) ]);
          ylabel('%');
          
                    subplot(2,6,10);
          [valoresY4,valoresX4]=imhist(imagen16Bits(:,:,5),4096);
          valoresY4PCT=(valoresY4/sum(valoresY4))*100;
          bar(valoresX4,valoresY4PCT);
          axis([0 max(max(imagen16Bits(:,:,5))) 0 max(valoresY4PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(4).banda) ]);
          ylabel('%');
          
                    subplot(2,6,11);
          [valoresY5,valoresX5]=imhist(imagen16Bits(:,:,6),4096);
          valoresY5PCT=(valoresY5/sum(valoresY5))*100;
          bar(valoresX5,valoresY5PCT);
          axis([0 max(max(imagen16Bits(:,:,6))) 0 max(valoresY5PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(5).banda) ]);
          ylabel('%');
          
                    subplot(2,6,12);
         [valoresY6,valoresX6]=imhist(imagen16Bits(:,:,1),1024);
          valoresY6PCT=(valoresY6/sum(valoresY6))*100;
          bar(valoresX6,valoresY6PCT);
          axis([0 max(max(imagen16Bits(:,:,1))) 0 max(valoresY6PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(6).banda) ]);
          ylabel('%');
  %%        
 % Histograma combinado de todas las bandas      
 
%  figure();
%             valoresXCombinados=[valoresX1,valoresX2,valoresX3,valoresX4,valoresX5,valoresX6];
%             valoresYPCTCombinados=[valoresY1PCT,valoresY2PCT,valoresY3PCT,valoresY4PCT,valoresY5PCT,valoresY6PCT];
%             bar(valoresXCombinados,valoresYPCTCombinados,'grouped');
%           legend(leyendaBandas); % Cargar la leyenda!
%           axis([0 max(max(max(imagen16Bits))) 0 max(max(valoresYPCTCombinados))]);
%           xlabel('ND');
%           ylabel('%');      

%% 
% Estad�sticas de cada banda

disp('Banda:       Max  /  Min  /  Med');
disp([Bandas(2),': ',num2str(max(max(imagen16Bits(:,:,2)))),'  /  ',num2str(min(min(imagen16Bits(:,:,2)))),'  /  ' ,num2str(mean(mean(imagen16Bits(:,:,2)))) ]);
disp([Bandas(3),': ',num2str(max(max(imagen16Bits(:,:,3)))),'  /  ',num2str(min(min(imagen16Bits(:,:,3)))),'  /  ' ,num2str(mean(mean(imagen16Bits(:,:,3)))) ]);
disp([Bandas(4),': ',num2str(max(max(imagen16Bits(:,:,4)))),'  /  ',num2str(min(min(imagen16Bits(:,:,4)))),'  /  ' ,num2str(mean(mean(imagen16Bits(:,:,4)))) ]);
disp([Bandas(5),': ',num2str(max(max(imagen16Bits(:,:,5)))),'  /  ',num2str(min(min(imagen16Bits(:,:,5)))),'  /  ' ,num2str(mean(mean(imagen16Bits(:,:,5)))) ]);
disp([Bandas(6),': ',num2str(max(max(imagen16Bits(:,:,6)))),'  /  ',num2str(min(min(imagen16Bits(:,:,6)))),'  /  ' ,num2str(mean(mean(imagen16Bits(:,:,6)))) ]);
disp([Bandas(1),': ',num2str(max(max(imagen16Bits(:,:,1)))),'  /  ',num2str(min(min(imagen16Bits(:,:,1)))),'  /  ' ,num2str(mean(mean(imagen16Bits(:,:,1)))) ]);






%% An�lisis de las reflectancias de las im�genes

% Reflectancia calculada de la imagen anterior y histograma asociado a cada banda

% reflectanciaUnitaria=imread('C:\Agromav IPS\Proves Xavi\Tiffs 16 bits para procesar\6 bandes/TTC3749.tif');
reflectanciaUnitaria(:,:,1)=LK_Banda(bandasProyecto(1),imagen16Bits(:,:,2));
reflectanciaUnitaria(:,:,2)=LK_Banda(bandasProyecto(2),imagen16Bits(:,:,3));
reflectanciaUnitaria(:,:,3)=LK_Banda(bandasProyecto(3),imagen16Bits(:,:,4));
reflectanciaUnitaria(:,:,4)=LK_Banda(bandasProyecto(4),imagen16Bits(:,:,5));
reflectanciaUnitaria(:,:,5)=LK_Banda(bandasProyecto(5),imagen16Bits(:,:,6));
reflectanciaUnitaria(:,:,6)=LK_Banda(bandasProyecto(6),imagen16Bits(:,:,1));

imAjustadaB1=imadjust(reflectanciaUnitaria(:,:,1));
imAjustadaB2=imadjust(reflectanciaUnitaria(:,:,2));
imAjustadaB3=imadjust(reflectanciaUnitaria(:,:,3));
imAjustadaB4=imadjust(reflectanciaUnitaria(:,:,4));
imAjustadaB5=imadjust(reflectanciaUnitaria(:,:,5));
imAjustadaB6=imadjust(reflectanciaUnitaria(:,:,6));

%Mostramos las im�genes
      figure('Name','Imagen Calibrada (reflectancia)','Position',[0 0 1920 700]);
          subplot(2,6,1);
          imshow(imAjustadaB1);
                    subplot(2,6,2);
          imshow(imAjustadaB2);
                    subplot(2,6,3);
          imshow(imAjustadaB3);
                    subplot(2,6,4);
          imshow(imAjustadaB4);
                    subplot(2,6,5);
          imshow(imAjustadaB5);
                    subplot(2,6,6);
          imshow(imAjustadaB6);
%Sacamos cada histograma como un grafico de barras para simplificar

 subplot(2,6,7);
          [valoresY1,valoresX1]=imhist(reflectanciaUnitaria(:,:,1),16);
          valoresY1PCT=(valoresY1/sum(valoresY1))*100;
          bar(valoresX1,valoresY1PCT);
          axis([0 1 0 max(valoresY1PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(1).banda) ]);
          ylabel('%');
          
                    subplot(2,6,8);
          [valoresY2,valoresX2]=imhist(reflectanciaUnitaria(:,:,2),16);
          valoresY2PCT=(valoresY2/sum(valoresY2))*100;
          bar(valoresX2,valoresY2PCT);
          axis([0 1 0 max(valoresY2PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(2).banda) ]);
          ylabel('%');
          
                    subplot(2,6,9);
         [valoresY3,valoresX3]=imhist(reflectanciaUnitaria(:,:,3),16);
          valoresY3PCT=(valoresY3/sum(valoresY3))*100;
          bar(valoresX3,valoresY3PCT);
          axis([0 1 0 max(valoresY3PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(3).banda) ]);
          ylabel('%');
          
                    subplot(2,6,10);
          [valoresY4,valoresX4]=imhist(reflectanciaUnitaria(:,:,4),16);
          valoresY4PCT=(valoresY4/sum(valoresY4))*100;
          bar(valoresX4,valoresY4PCT);
          axis([0 1 0 max(valoresY4PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(4).banda) ]);
          ylabel('%');
          
                    subplot(2,6,11);
          [valoresY5,valoresX5]=imhist(reflectanciaUnitaria(:,:,5),16);
          valoresY5PCT=(valoresY5/sum(valoresY5))*100;
          bar(valoresX5,valoresY5PCT);
          axis([0 1 0 max(valoresY5PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(5).banda) ]);
          ylabel('%');
          
                    subplot(2,6,12);
         [valoresY6,valoresX6]=imhist(reflectanciaUnitaria(:,:,6),16);
          valoresY6PCT=(valoresY6/sum(valoresY6))*100;
          bar(valoresX6,valoresY6PCT);
          axis([0 1 0 max(valoresY6PCT)]);
          xlabel(['ND R',num2str(bandasProyecto(6).banda) ]);
          ylabel('%');
  %%        
 % Histograma combinado de todas las bandas      
 

 figure();
            valoresXCombinados=[valoresX1,valoresX2,valoresX3,valoresX4,valoresX5,valoresX6];
            valoresYPCTCombinados=[valoresY1PCT,valoresY2PCT,valoresY3PCT,valoresY4PCT,valoresY5PCT,valoresY6PCT];
            bar(valoresXCombinados,valoresYPCTCombinados,'grouped');
          legend(leyendaBandas); % Cargar la leyenda!
          axis([0 max(max(max(reflectanciaUnitaria))) 0 max(max(valoresYPCTCombinados))]);
          xlabel('ND');
          ylabel('%');      

%% 
% Estad�sticas de cada banda

disp('Banda       Max  /  Min  /  Med');
disp([Bandas(2),': ',num2str(max(max(reflectanciaUnitaria(:,:,1)))),'  /  ',num2str(min(min(reflectanciaUnitaria(:,:,1)))),'  /  ' ,num2str(mean(mean(reflectanciaUnitaria(:,:,1)))) ]);
disp([Bandas(3),': ',num2str(max(max(reflectanciaUnitaria(:,:,2)))),'  /  ',num2str(min(min(reflectanciaUnitaria(:,:,2)))),'  /  ' ,num2str(mean(mean(reflectanciaUnitaria(:,:,2)))) ]);
disp([Bandas(4),': ',num2str(max(max(reflectanciaUnitaria(:,:,3)))),'  /  ',num2str(min(min(reflectanciaUnitaria(:,:,3)))),'  /  ' ,num2str(mean(mean(reflectanciaUnitaria(:,:,3)))) ]);
disp([Bandas(5),': ',num2str(max(max(reflectanciaUnitaria(:,:,4)))),'  /  ',num2str(min(min(reflectanciaUnitaria(:,:,4)))),'  /  ' ,num2str(mean(mean(reflectanciaUnitaria(:,:,4)))) ]);
disp([Bandas(6),': ',num2str(max(max(reflectanciaUnitaria(:,:,5)))),'  /  ',num2str(min(min(reflectanciaUnitaria(:,:,5)))),'  /  ' ,num2str(mean(mean(reflectanciaUnitaria(:,:,5)))) ]);
disp([Bandas(1),': ',num2str(max(max(reflectanciaUnitaria(:,:,6)))),'  /  ',num2str(min(min(reflectanciaUnitaria(:,:,6)))),'  /  ' ,num2str(mean(mean(reflectanciaUnitaria(:,:,6)))) ]);




%% Comparaci�n entre im�genes calibradas y sin calibrar
% Imagenes en CIR ( Sin calibrar / Calibrada )
im16BitsCIR(:,:,1)=imagen16Bits(:,:,1);
im16BitsCIR(:,:,2)=imagen16Bits(:,:,4);
im16BitsCIR(:,:,3)=imagen16Bits(:,:,3);

im16BitsCIR=double(im16BitsCIR);
im16BitsCIR=im16BitsCIR/1024;
reflectanciaCIR(:,:,1)=reflectanciaUnitaria(:,:,6);
reflectanciaCIR(:,:,2)=reflectanciaUnitaria(:,:,3);
reflectanciaCIR(:,:,3)=reflectanciaUnitaria(:,:,2);

figure('Name','Comparaci�n Im�genes en CIR','Position',[0 0 1920 700]);


subplot(1,2,1);
imshow(im16BitsCIR);


subplot(1,2,2);

imshow(reflectanciaCIR);


    
%%  


%% 
close all;
end








