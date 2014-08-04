%%
% *Informe calidad Radioespectrómetro*
%%
% 
% <<C:\Users\Ethan\Documents\MATLAB\HEMAV\Agro\Bloque 2 Matlab y C Sharp\Espectrometre/1 Logo Final 3v.PNG>>

%banda1=R670
%banda2=R780

%% *Información sobre el vuelo*
% * *Nombre de la misión*: Vuelo 1 Algerri Balaguer
% * *Hora solar de inicio / final*: 13:25:37 /  13:32:14
% * *Observaciones meteorológicas:* Soleado
%% *Datos del radioespectrómetro con las placas de calibración*
% *Medidas de la placa de calibración para blanco gris y negro:*
%
% # *Oficina:* ..../...../....
% # *Pre Vuelo:*  ..../...../....
% # *Post Vuelo:*  ..../...../....
%
%% *Evaluación de longitud de onda R670 en crudo*
% 
%Leemos el Excel con los datos
pathDatosRdspc='C:\Users\Ethan\Documents\MATLAB\HEMAV\Agro\Bloque 2 Matlab y C Sharp\Espectrometre\Entregables Algerri-Balaguer\Vol 1 Espectrometre.xlsx';

[~,~,raw]=xlsread(pathDatosRdspc); % Extraemos datos en crudo de la hoja 1 (para los datos originales)
[~,sheets]=xlsfinfo(pathDatosRdspc); % Nombres de las hojas
medidas=numel(raw(1,2:end)); %Obtenemos el numero de medidas totales
bandaR670Raw=raw(717,2:end); % R670 en crudo
bandaR780Raw=raw(944,2:end); % R780 en crudo

clear raw; % liberamos espacio en memoria

%Analizamos la banda 1
numeracionPuntos=cell(1,medidas/5); % Inicializamos el vector
[~,~,raw]=xlsread(pathDatosRdspc,char(sheets(1,2,:))); %Leemos la segunda hoja para extraer los nombres de los puntos
numeracionPuntos(1,:)=raw(1,2:(1+medidas/5)); % Damos al vector los valores de orden de los puntos
clear raw; % liberamos espacio en memoria
analisisBanda=zeros(5,medidas/5); %Inicializamos el vector de análisis
analisisBanda(1,:)=cell2mat(numeracionPuntos); % La primera fila del vector análisis es el orden de los puntos
valoresBanda=zeros(5,medidas/5);% Inicializamos el vector que contendrá las medidas de cada punto (1 columna por punto, 5 medidas(filas) por punto).
j=0;
for i=1:5:(medidas)
    j=j+1;
    rawValores=[bandaR670Raw(i) bandaR670Raw(i+1) bandaR670Raw(i+2) bandaR670Raw(i+3) bandaR670Raw(i+4)]; %Leemos los valores como cells
    valores=cell2mat(rawValores); % Vector que contiene los 5 valores del punto en double
    valoresBanda(:,j)=valores'; %Guardamos los valores clasificados por puntos (1 columna por punto)
    
    %Hacemos las estadísticas y las guardamos en analisisBanda
    analisisBanda(2,j)=max(valores);
    analisisBanda(3,j)=min(valores);
    analisisBanda(4,j)=mean(valores);
%     analisisBanda(5,j)=max(valores)-mean(valores);
%     analisisBanda(6,j)=mean(valores)-min(valores);
    analisisBanda(5,j)=max(valores)-min(valores);
    
    
    
    
end

%Mostramos las estadísticas de cada punto
%disp(analisisBanda);

%Mostramos gráfico de los puntos
figure();
boxplot(valoresBanda);
 
%% *Evaluación de longitud de onda R670 filtrando datos*
% Se han sustituido dos valores por las medias correspondientes a sus
% puntos:
%%
% 
% # *Primer valor del quinto punto:* Más del doble de la media en el punto,
% posible vibración del drone
% # *Último valor de la muestra (punto 19):* Posiblemente se trate de un
% movimiento del drone que hizo apuntar hacia el suelo (marrón, alto
% contenido de rojo en comparación a la vegetación).
% 

% valoresBanda(1,5)=analisisBanda(4,5);
% valoresBanda(5,19)=analisisBanda(4,19);
valoresBanda(1,5)=NaN;
valoresBanda(5,19)=NaN;
figure();
boxplot(valoresBanda);

%% 
% Se puede ver que aún así hay valores fuera de la media, pero se mantiene
% un error aceptable en las muestras de cada punto
% 
disp <html>
disp(GTHTMLtable(analisisBanda' , {'ID punto' 'Máximo de la muestra' 'Mínimo de la muestra' 'Media de la muestra' 'Rango'  }      ));
disp </html>

%% *Evaluación de longitud de onda R780 en crudo*
% 

%Analizamos la banda 2
analisisBanda=zeros(5,medidas/5); %Inicializamos el vector de análisis
analisisBanda(1,:)=cell2mat(numeracionPuntos); % La primera fila del vector análisis es el orden de los puntos
valoresBanda=zeros(5,medidas/5);% Inicializamos el vector que contendrá las medidas de cada punto (1 columna por punto, 5 medidas(filas) por punto).
j=0;
for i=1:5:(medidas)
    j=j+1;
    rawValores=[bandaR780Raw(i) bandaR780Raw(i+1) bandaR780Raw(i+2) bandaR780Raw(i+3) bandaR780Raw(i+4)]; %Leemos los valores como cells
    valores=cell2mat(rawValores); % Vector que contiene los 5 valores del punto en double
    valoresBanda(:,j)=valores'; %Guardamos los valores clasificados por puntos (1 columna por punto)
    
    %Hacemos las estadísticas y las guardamos en analisisBanda
    analisisBanda(2,j)=max(valores);
    analisisBanda(3,j)=min(valores);
    analisisBanda(4,j)=mean(valores);
%     analisisBanda(5,j)=max(valores)-mean(valores);
%     analisisBanda(6,j)=mean(valores)-min(valores);
    analisisBanda(5,j)=max(valores)-min(valores);
    
    
    
    
end

%Mostramos las estadísticas de cada punto
%disp(analisisBanda);

%Mostramos gráfico de los puntos
figure();
boxplot(valoresBanda);
 
%% *Evaluación de longitud de onda R780 filtrando datos*
% Se han sustituido dos valores por las medias correspondientes a sus
% puntos:
%%
% 
% # *Primer valor del séptimo punto:* Más de la mitad de la media en el punto,
% posible vibración del drone
valoresBanda(1,7)=NaN;
figure();
boxplot(valoresBanda);

%% 
% Se puede ver que aún así hay valores fuera de la media, pero se mantiene
% un error aceptable en las muestras de cada punto
% 
disp <html>
disp(GTHTMLtable(analisisBanda' , {'ID punto' 'Máximo de la muestra' 'Mínimo de la muestra' 'Media de la muestra' 'Rango'  }      ));
disp </html>
%%
% 
close all;






