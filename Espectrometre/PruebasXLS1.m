Excel = actxserver ('Excel.Application'); 
[nombreArchivos,path]=uigetfile('*.csv','Selecciona los archivos','Multiselect','on');
datosGND=cell(numel(nombreArchivos)+1,1024);

for i=1:numel(nombreArchivos)
tic
    File=[path,char(nombreArchivos(1,i))]; 
if ~exist(File,'file') 
    ExcelWorkbook = Excel.Workbooks.Add; 
    ExcelWorkbook.SaveAs(File,1); 
    ExcelWorkbook.Close(false); 
end 
Excel.Workbooks.Open(File); 
  
[~,~,raw]=xlsread1(File);
%En la primera iteración recuperamos los valores de LDO
if i==1
datosGND(1,:)=raw(2,1:end);
end
datosGND(i+1,:)=raw(3,1:end);
toc
end
Excel.ActiveWorkbook.Save; 
Excel.Quit 
Excel.delete 
clear Excel

datosGNDNum=cell2mat(datosGND(2:end,:));
LDORaw=datosGND(1,:);
isnum=cellfun(@isnumeric,LDORaw);
valoresNum=LDORaw(isnum);
LDONum=str2double(LDORaw);
valoresNum=cell2mat(valoresNum);
j=1;
for i=1:numel(isnum)
    if isnum(i)==1
        LDONum(i)=valoresNum(j);
        j=j+1;
    end
end


% Creamos el gráfico con los ejes X = LDO y las y son cada una de las filas
% de data
figure('Name','Evolución huella espectral cruda');
plot(LDONum,datosGNDNum);


%% Comprobamos que esten bien todas las medidas del espectrometro: en este caso la 9 hay que eliminarla ya que no tiene sentido

datosGNDNum=datosGNDNum([1:8,10:end],:);
figure('Name','Evolución huella espectral corregida');
plot(LDONum,datosGNDNum);
%% Hay que escoger al azar unas cuantas LDO's y dibujar el grafico estilo Agus 

[LDOsRandom,indices] = datasample(LDONum,4);

for i=1:numel(indices)
    figure('Name',['R',num2str(LDOsRandom(i))]);
    plot(1:(numel(nombreArchivos)-1),datosGNDNum(:,indices(i))' );
end

% La parte de la huella espectral del blanco es muy fácil: Hay que leer la
% primera columna del excel de radiancias y dibujar la huella

