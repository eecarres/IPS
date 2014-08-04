
clc;
clear all;
%% Obtenemos la info del Excel
pathExcel='C:\Users\Ethan\Desktop\Espectrometre\Entregables Algerri-Balaguer\Vol 5 Espectrometre.xlsx';
pathLocation='C:\Users\Ethan\Desktop\Espectrometre\Entregables Algerri-Balaguer\Vol 5 Location.xlsx';
[status,sheets] = xlsfinfo(pathExcel) ;
hojaExcel=sheets;
hojaExcelResultados='Puntos_Refl';
hojaIndices='Indexs_Refl';


%% Leemos la info del Excel
    [numeros, text ,raw]=xlsread(pathExcel);

Time=text(2,2:5:end);
numColumnasDatos=numel(numeros(1,:))-1;
numMedidas=numel(Time(1,:));
Names=zeros(numMedidas);


fila350=32-2;
LDO= numeros(fila350:end,1);
noLDO=numel(LDO);
valoresMedios=zeros(noLDO,numMedidas);
j=0;
for i=2:5:numColumnasDatos
    j=j+1;
    col1=numeros(fila350:end,i);
    col2=numeros(fila350:end,i+1);
    col3=numeros(fila350:end,i+2);
    col4=numeros(fila350:end,i+3);
    try
    col5=numeros(fila350:end,i+4);
    
    valores=(col1+col2+col3+col4+col5)/5;
    valoresMedios(:,j)=valores;
    catch
    valores=(col1+col2+col3+col4)/4;
    valoresMedios(:,j)=valores;
    end
end

%Sacamos los valores de reflectancias que nos interesan:

R415=valoresMedios(174-31,1:end);
R430=valoresMedios(207-31,1:end);
R435=valoresMedios(217-31,1:end);
R440=valoresMedios(228-31,1:end);
R531=valoresMedios(424-31,1:end);
R550=valoresMedios(464-31,1:end);
R570=valoresMedios(507-31,1:end);
R573=valoresMedios(513-31,1:end);
R670=valoresMedios(717-31,1:end);
R680=valoresMedios(738-31,1:end);
R700=valoresMedios(779-31,1:end);
R710=valoresMedios(800-31,1:end);
R720=valoresMedios(820-31,1:end);
R750=valoresMedios(882-31,1:end);
R800=valoresMedios(984-31,1:end);

[~,~,RAW]=xlsread(pathLocation);

Names=RAW(1,1:end);
longitud=RAW(2,1:end);
latitud=RAW(3,1:end);




%% Procesamos la info


%% Escribimos el Excel
% Hoja de datos medios
xlswrite(pathExcel,{'Noms punts'},hojaExcelResultados,'A1');
xlswrite(pathExcel,Names,hojaExcelResultados,'B1');
xlswrite(pathExcel,{'Time'},hojaExcelResultados,'A2');
xlswrite(pathExcel,Time,hojaExcelResultados,'B2');
xlswrite(pathExcel,{'Longitud'},hojaExcelResultados,'A3');
xlswrite(pathExcel,longitud,hojaExcelResultados,'B3');
xlswrite(pathExcel,{'Latitud'},hojaExcelResultados,'A4');
xlswrite(pathExcel,latitud,hojaExcelResultados,'B4');
xlswrite(pathExcel,LDO,hojaExcelResultados,'A5');
xlswrite(pathExcel,valoresMedios,hojaExcelResultados,'B5');


clear numeros text raw RAW S

%% Calculo de índices:

NDVI=(R800-R670)./(R800+R670);
NDVI_Verde_Azul=(R573-R440)./(R573+R440);
SAVI_05=1.5*(     (R800-R670)./  (R800+R670+0.5)  );
RDVI=(R800-R670)  ./  sqrt(R800+R670);
DCNI=  (R720-R700) ./ (R700-R670)   ./  (R720-R670 + 0.03);
MCARI= (    (R700-R670) - 0.2*(R700-R550)    ) .* (R700./R670);
TCARI=3*(    (     (R700-R670)-0.2*(R700-R550)   )  .*(R700/R670) ) ;
OSAVI=1.16*(     (R800-R670)./  (R800+R670+0.16)  );
TCARI_OSAVI=TCARI ./ OSAVI;
RVI= R800 ./ R670;
PRI=(R570-R531) ./ (R570+R531);
NPCI=(R680-R430)   ./   (R680+R430);
TVI= 0.5*(120*(R750-R550)-200*(R670-R550));
NPQI= (R415-R435)  ./  (R415+R435);
ZM=  R750 ./  R710;





% Hoja de índices:

xlswrite(pathExcel,{'Noms punts'},hojaIndices,'A1');
xlswrite(pathExcel,Names,hojaIndices,'B1');
xlswrite(pathExcel,{'Time'},hojaIndices,'A2');
xlswrite(pathExcel,Time,hojaIndices,'B2');
xlswrite(pathExcel,{'Longitud'},hojaIndices,'A3');
xlswrite(pathExcel,longitud,hojaIndices,'B3');
xlswrite(pathExcel,{'Latitud'},hojaIndices,'A4');
xlswrite(pathExcel,latitud,hojaIndices,'B4');
%Indices
xlswrite(pathExcel,{'NDVI'},hojaIndices,'A5');
xlswrite(pathExcel,NDVI,hojaIndices,'B5');
xlswrite(pathExcel,{'NDVI Verde-Azul'},hojaIndices,'A6');
xlswrite(pathExcel,NDVI_Verde_Azul,hojaIndices,'B6');
xlswrite(pathExcel,{'SAVI con L=0.5'},hojaIndices,'A7');
xlswrite(pathExcel,SAVI_05,hojaIndices,'B7');
xlswrite(pathExcel,{'RDVI'},hojaIndices,'A8');
xlswrite(pathExcel,RDVI,hojaIndices,'B8');
xlswrite(pathExcel,{'DCNI'},hojaIndices,'A9');
xlswrite(pathExcel,DCNI,hojaIndices,'B9');
xlswrite(pathExcel,{'MCARI'},hojaIndices,'A10');
xlswrite(pathExcel,MCARI,hojaIndices,'B10');
xlswrite(pathExcel,{'TCARI'},hojaIndices,'A11');
xlswrite(pathExcel,TCARI,hojaIndices,'B11');
xlswrite(pathExcel,{'OSAVI'},hojaIndices,'A12');
xlswrite(pathExcel,OSAVI,hojaIndices,'B12');
xlswrite(pathExcel,{'TCARI/OSAVI'},hojaIndices,'A13');
xlswrite(pathExcel,TCARI_OSAVI,hojaIndices,'B13');
xlswrite(pathExcel,{'RVI'},hojaIndices,'A14');
xlswrite(pathExcel,RVI,hojaIndices,'B14');
xlswrite(pathExcel,{'PRI'},hojaIndices,'A15');
xlswrite(pathExcel,PRI,hojaIndices,'B15');
xlswrite(pathExcel,{'NPCI'},hojaIndices,'A16');
xlswrite(pathExcel,NPCI,hojaIndices,'B16');
xlswrite(pathExcel,{'TVI'},hojaIndices,'A17');
xlswrite(pathExcel,TVI,hojaIndices,'B17');
xlswrite(pathExcel,{'NPQI'},hojaIndices,'A18');
xlswrite(pathExcel,NPQI,hojaIndices,'B18');
xlswrite(pathExcel,{'ZM'},hojaIndices,'A19');
xlswrite(pathExcel,ZM,hojaIndices,'B19');
