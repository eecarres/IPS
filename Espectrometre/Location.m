



numeroDeLocations=19;
pathLocation='C:\Users\Ethan\Desktop\Espectrometre\2014-07-14 15-57-06 1_LOCATION.txt';
ID=fopen(pathLocation);
%location=fscanf(ID,'%c');
filasTexto= textscan(ID,'%s','delimiter','\n');
fclose(ID);
j=0;
for i=3:numeroDeLocations
    j=j+1;
texto= filasTexto{1}{i}(7:15)
end