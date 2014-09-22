

[nombreSPEC,pathSPEC]=uigetfile('*.csv','Selecciona el archivo SPEC.cvs','C:\Users\Ethan\Documents\MATLAB\HEMAV\Agro\Bloque 2 Matlab y C Sharp\IPS\Espectrometre\Corrector Excels AB F2\Raw RDSPC AB F2\Andreas_3_09_2014_ SOLO 1 ESPECTROMETRO\measurements\SPEC.cvs');
[nombreModelo,pathModelo]=uigetfile('*.csv','Selecciona el archivo merged modelo.cvs','C:\Users\Ethan\Documents\MATLAB\HEMAV\Agro\Bloque 2 Matlab y C Sharp\IPS\Espectrometre\Corrector Excels AB F2\Raw RDSPC AB F2\Andreas_3_09_2014_ SOLO 1 ESPECTROMETRO\merged\Modelo.cvs');

[~,~,dataSPEC]=xlsread([pathSPEC,nombreSPEC]);
[~,~,dataModelo]=xlsread([pathModelo,nombreModelo]);

numMedidas=size(dataSPEC);

numMedidas=numMedidas(1)/3;

for i=1:numMedidas
% dataMedida comprende el modelo de spectrum pero con los datos cambiados, que lee del SPEC    
dataMedida=dataModelo;
filaSPEC=((i-1)*3)+2; %calculamos la fila en la que debe leer los datos del SPEC

for j=2:1025
    
    dataMedida(6,j)=dataSPEC(filaSPEC,j-1);% Copiamos los datos del SPEC a dataMedida
    
end


%% No se puede emplear un csvWrite porque no permite escribir Arrays Cell
if (i<10)
fid = fopen([pathModelo,'Medida 0',num2str(i),'.csv'],'w');
else
fid = fopen([pathModelo,'Medida ',num2str(i),'.csv'],'w');   
end
 % Primera fila
  fprintf(fid,'%s;',dataMedida{1,1:2});
  fprintf(fid,'%g;',dataMedida{1,3});
  fprintf(fid,'%s;',dataMedida{1,4});
  fprintf(fid,'%g;',dataMedida{1,5});
  fprintf(fid,'%s;',dataMedida{1,6});
  fprintf(fid,'%g\n',dataMedida{1,7});
  % Segunda fila
  fprintf(fid,'%s;',dataMedida{2,1});
  fprintf(fid,'%g;',dataMedida{2,2:1024});
  fprintf(fid,'%g\n',dataMedida{2,1025});
  % Tercera fila
  fprintf(fid,'%s;',dataMedida{3,1});
  fprintf(fid,'%g;',dataMedida{3,2:1024});
  fprintf(fid,'%g;\n',dataMedida{3,1025});
  % Cuarta fila
  fprintf(fid,'%s;',dataMedida{4,1:2});
  fprintf(fid,'%g;',dataMedida{4,3});
  fprintf(fid,'%s;',dataMedida{4,4});
  fprintf(fid,'%g;',dataMedida{4,5});
  fprintf(fid,'%s;',dataMedida{4,6});
  fprintf(fid,'%g;\n',dataMedida{4,7});
  % Quinta fila
  fprintf(fid,'%s;',dataMedida{5,1});
  fprintf(fid,'%g;',dataMedida{5,2:1024});
  fprintf(fid,'%g\n',dataMedida{5,1025});
  % Sexta fila
  fprintf(fid,'%s;',dataMedida{6,1});
  fprintf(fid,'%g;',dataMedida{6,2:1024});
  fprintf(fid,'%g;',dataMedida{6,1025});
    fclose(fid);
end

