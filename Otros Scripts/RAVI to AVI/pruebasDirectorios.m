clc
clearvars

path='E:\Inspección Líneas Eléctricas\Endesa\SANTA COLOMA - MATARÓ\TERMO';
dirData = dir(path);      %# Get the data for the current directory
  dirIndex = [dirData.isdir];  %# Find the index for directories
  fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
 mkdir([path,'\AVI']);
  disp('Inicio de conversión...')
  for i=1:size(fileList,1)
  
  disp(i)
  filePath=[path,'\',(fileList{i})];
  processRavi2(20,filePath)
  
  end