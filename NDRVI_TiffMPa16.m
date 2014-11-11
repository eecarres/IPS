function varargout = NDRVI_TiffMPa16(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_TiffMPa16_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_TiffMPa16_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Executes just before NDRVI_TiffMPa16 is made visible.
function NDRVI_TiffMPa16_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NDRVI_TiffMPa16 (see VARARGIN)

% Choose default command line output for NDRVI_TiffMPa16
handles.output = hObject;

if nargin==5
    
    load ('ultimoProyecto','referenciasCalibracion');
    handles.pathProyecto=varargin{1,1};
    handles.indiceProyecto=varargin{1,2};
    pathProyecto=handles.pathProyecto;
    indiceProyecto=handles.indiceProyecto;
    try
    save ('ultimoProyecto','pathProyecto','indiceProyecto','referenciasCalibracion');
    catch
       save ('ultimoProyecto','pathProyecto','indiceProyecto'); 
    end
    
else
    load ('ultimoProyecto','pathProyecto','indiceProyecto');
    handles.pathProyecto=pathProyecto;
    handles.indiceProyecto=indiceProyecto;
end

guidata(hObject, handles); 


% UIWAIT makes NDRVI_TiffMPa16 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_TiffMPa16_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function btnCargaTiffs_Callback(hObject, eventdata, handles)
[Im_Name,Im_PathName] = uigetfile({'*tif';'*tiff';'*.*'},'Selecciona imagene',strcat(handles.pathProyecto,'/Tiffs Multipage'),'MultiSelect', 'on');
set(handles.lstImagenes,'string',Im_Name);
handles.multiPath=strcat(Im_PathName,Im_Name);
guidata(hObject, handles);

function lstImagenes_Callback(hObject, eventdata, handles)


function lstImagenes_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Llama a la función que crea un Tiff para cada banda por separado
function btnSingleTiffs_Callback(hObject, eventdata, handles) % Crea Tifs de 3 capas UINT8, donde las 3 capas tienen los mismos valores (todo esto viene de herencia, con monocroma de 16 bits seria mejor)

paths=handles.multiPath;
numImagenes=size(paths());
tic
proceso=waitbar(0,'Convirtiendo Imágenes');
for i=1:numImagenes(2)
    waitbar((i/numImagenes(2)),proceso,['Convirtiendo Imágenes ', num2str(i), ' de ', num2str(numImagenes(2))]);
    %Abrimos cada una de las páginas, convertimos a 16 bits y borramos el
    %resto de variables hasta juntarlo en una imagen.
    imagenActual=imread(char(paths(1,i)),1);
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    BM= Green4 + Green - Blue;
    
    clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),2);
    
  Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B1= Green4 + Green - Blue;
    
   clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),3);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B2= Green4 + Green - Blue;
    
    clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),4);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B3= Green4 + Green - Blue;
    
    clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),5);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B4= Green4 + Green - Blue;
    
   clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),6);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B5= Green4 + Green - Blue;
    
    clear imagenActual Green Blue;
    

    
    
    [~, name_im, ~] = fileparts(char(paths(1,i)));
    
    tiffBM= Tiff(strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_0.tif'),'w');
            tagstruct.ImageLength = size(BM,1);
            tagstruct.ImageWidth = size(BM,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =1;
            tagstruct.RowsPerStrip = 16;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            tagstruct.Software = 'MATLAB';
            tiffBM.setTag(tagstruct);
            tiffBM.write(BM); 
            tiffBM.close;
       
%             BM=(BM)./max(max(BM)) .*(2^16);
%             imwrite(BM,strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_0_AUX.tif')); % Prueba para abrir en Photoshop
            
            
        tiffB1= Tiff(strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_1.tif'),'w');
            tagstruct.ImageLength = size(B1,1);
            tagstruct.ImageWidth = size(B1,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =1;
            tagstruct.RowsPerStrip = 16;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            tagstruct.Software = 'MATLAB';
            tiffB1.setTag(tagstruct);
            tiffB1.write(B1); 
            tiffB1.close;
            
%             imwrite(B1,strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_1_AUX.tif')); % Prueba para abrir en Photoshop
            
            
        tiffB2= Tiff(strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_2.tif'),'w');
            tagstruct.ImageLength = size(B2,1);
            tagstruct.ImageWidth = size(B2,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =1;
            tagstruct.RowsPerStrip = 16;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            tagstruct.Software = 'MATLAB';
            tiffB2.setTag(tagstruct);
            tiffB2.write(B2); 
            tiffB2.close;
            
%             imwrite(B2,strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_2_AUX.tif')); % Prueba para abrir en Photoshop
            
            
            tiffB3= Tiff(strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_3.tif'),'w');
            tagstruct.ImageLength = size(B3,1);
            tagstruct.ImageWidth = size(B3,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =1;
            tagstruct.RowsPerStrip = 16;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            tagstruct.Software = 'MATLAB';
            tiffB3.setTag(tagstruct);
            tiffB3.write(B3); 
            tiffB3.close;
            
%             imwrite(B3,strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_3_AUX.tif')); % Prueba para abrir en Photoshop
            
            
            
            tiffB4= Tiff(strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_4.tif'),'w');
            tagstruct.ImageLength = size(B4,1);
            tagstruct.ImageWidth = size(B4,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =1;
            tagstruct.RowsPerStrip = 16;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            tagstruct.Software = 'MATLAB';
            tiffB4.setTag(tagstruct);
            tiffB4.write(B4); 
            tiffB4.close;
            
%             imwrite(B4,strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_4_AUX.tif')); % Prueba para abrir en Photoshop
            
            
            
            tiffB5= Tiff(strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_5.tif'),'w');
            tagstruct.ImageLength = size(B5,1);
            tagstruct.ImageWidth = size(B5,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =1;
            tagstruct.RowsPerStrip = 16;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            tagstruct.Software = 'MATLAB';
            tiffB5.setTag(tagstruct);
            tiffB5.write(B5); 
            tiffB5.close;
            
%             imwrite(B5,strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/Per bandes/',name_im,'_5_AUX.tif')); % Prueba para abrir en Photoshop
            
            
            
end
close(proceso);
toc





guidata(hObject, handles);

%% Llama a la función que crea Tiffs de 6 bandas
function btnMultiTiff_Callback(hObject, eventdata, handles)
paths=handles.multiPath;
numImagenes=size(paths());
tic
proceso=waitbar(0,'Convirtiendo Imágenes');
for i=1:numImagenes(2)
    waitbar((i/numImagenes(2)),proceso,['Convirtiendo Imágenes ', num2str(i), ' de ', num2str(numImagenes(2))]);
    %Abrimos cada una de las páginas, convertimos a 16 bits y borramos el
    %resto de variables hasta juntarlo en una imagen.
    imagenActual=imread(char(paths(1,i)),1);
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    BM= Green4 + Green - Blue;  
    
    clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),2);
    
  Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B1= Green4 + Green - Blue;
    
   clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),3);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B2= Green4 + Green - Blue;
    
    clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),4);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B3= Green4 + Green - Blue;
    
    clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),5);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B4= Green4 + Green - Blue;
    
   clear imagenActual Green Blue;
    
    imagenActual=imread(char(paths(1,i)),6);
    
    Green=uint16(imagenActual(:,:,2));
    Blue=uint16(imagenActual(:,:,3));
    Green4=4*Green;
    B5= Green4 + Green - Blue;
    
    clear imagenActual Green Blue;
    
    imagenFinal(:,:,1)=BM;
    imagenFinal(:,:,2)=B1;
    imagenFinal(:,:,3)=B2;
    imagenFinal(:,:,4)=B3;
    imagenFinal(:,:,5)=B4;
    imagenFinal(:,:,6)=B5;
    
    clear BM B1 B2 B3 B4 B5;
    [~, name_im, ~] = fileparts(char(paths(1,i)));
    tiffFinal= Tiff(strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/6 bandes/',name_im,'.tif'),'w');
            tagstruct.ImageLength = size(imagenFinal,1);
            tagstruct.ImageWidth = size(imagenFinal,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =6;
            tagstruct.RowsPerStrip = 16;
            tagstruct.ExtraSamples =[0 0 0];
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
            tagstruct.Software = 'MATLAB';
            tiffFinal.setTag(tagstruct);
            tiffFinal.write(imagenFinal); 
            tiffFinal.close;
end
close(proceso);
toc





guidata(hObject, handles);


function btnVolver_Callback(hObject, eventdata, handles)

close NDRVI_TiffMPa16
NDRVI_Main(handles.indiceProyecto);


