clc
clearvars

path='D:\Inspecci�n L�neas El�ctricas\Endesa\SANTA COLOMA - MATAR�\TERMO';
addpath='../parforProgress';
dirData = dir(path);      %# Get the data for the current directory
  dirIndex = [dirData.isdir];  %# Find the index for directories
  fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
 mkdir([path,'\AVI_2']);
%  ppm = ParforProgressStarter2('test', size(fileList,1), (100/size(fileList,1)), 1, 1, 1); % Clase para mostrar progreso parfor
  disp('Inicio de conversi�n...')
  parfor i=1:size(fileList,1)
  
  disp(i)
  filePath=[path,'\',(fileList{i})];
  processRavi2(25,filePath)
%   ppm.increment(i);
  end