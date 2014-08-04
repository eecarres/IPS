
%% Iniciamos el servidor y abrimos el archivo
% Iniciamos el servidor ActiveX de Excel
servidorExcel=actxserver('Excel.Application');
% Abrimos el archivo en cuestión
pathExcel ='C:\Users\Ethan\Documents\MATLAB\HEMAV\Agro\Bloque 2 Matlab y C Sharp\Espectrometre/Originales/Vol2_3_Espectrometre.xlsx';
archivoExcel=servidorExcel.Workbooks.Open(pathExcel);


%% Modificamos el excel
Hoja1=servidorExcel.Worksheets.get('Item', 'Sheet1');

%% Guardamos y Cerramos
archivoExcel.Save;
archivoExcel.Close;
delete(servidorExcel);