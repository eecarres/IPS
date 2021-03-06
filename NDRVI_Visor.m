function varargout = NDRVI_Visor(varargin)
%% Visor de Tiffs para AgroMav IPS

% Muestra todas las im�genes procesadas del proyecto en cuesti�n
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_Visor_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_Visor_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before NDRVI_Visor is made visible.
function NDRVI_Visor_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

%% Parte com�n de gesti�n de proyectos

if nargin==5
    
    
    handles.pathProyecto=varargin{1,1};
    handles.indiceProyecto=varargin{1,2};
    
else
    load ('ultimoProyecto','pathProyecto','indiceProyecto');
    handles.pathProyecto=pathProyecto;
    handles.indiceProyecto=indiceProyecto;
end

pathProyecto=handles.pathProyecto;
nombresImagenes = dir(fullfile([pathProyecto,'/Procesadas/Multi']));

numeroImagenes= size(nombresImagenes);
numeroImagenes=numeroImagenes(1);
nombresImagenes=char(nombresImagenes.name);
j=0;
if numeroImagenes>2
for i=4:numeroImagenes
    j=j+1;
    nombresLista(j,:)=char(nombresImagenes(i,:));
    
end
set(handles.lstImagenes,'String',nombresLista);
end


% Mostramos el nombre del proyecto en la ventana
set(handles.lblNombreProyecto,'string',pathProyecto);


% Cargamos la primera banda de la primera imagen y escribimos los
% par�metros en el panel de informaci�n de la imagen
pathImagen=[pathProyecto,'/Procesadas/Multi/',(nombresLista(1,:))];
TiffActual = Tiff(pathImagen,'r+');

      [~,nombreIm, ~] = fileparts(nombresLista(1,:));
      set(handles.lblNombreImagen,'string',nombreIm);
       
       dataImOriginal=TiffActual.read();% Leemos la info del Tiff
      
       tamanoIm=size(dataImOriginal);
       set(handles.lblTamano,'string',[num2str(tamanoIm(1)),'x',num2str(tamanoIm(2))]);
       
       numBandas=tamanoIm(3);% Encontramos el n�mero de bandas de la imagen
       set(handles.lblBandas,'string',numBandas);
       
       for i=1:numBandas
           if i>9
           listaBandas(i,:)=['Banda ',num2str(i)]; % El fallo con m�s de 9 bandas viene porque intentamos guardar 8 caracteres en un vector de strings de 7 caracteres
           else
           listaBandas(i,:)=['Banda  ',num2str(i)];    
           end
       end
       set(handles.lstBandas,'string',listaBandas);
       
       axes(handles.axsImagen);
       imshow(dataImOriginal(:,:,1));
       
       axes(handles.axsHistograma);% Mostramos el histograma
       imhist(dataImOriginal(:,:,1));

guidata(hObject, handles);

function cambioImagen(indiceImagen,indiceBanda,colormapSeleccionado)
%% Leemos la imagen y la mostramos
handles = guidata(gcf);

nombreImagen=get(handles.lstImagenes,'string');
nombreImagen=nombreImagen(indiceImagen,:);
pathImagen=[handles.pathProyecto,'/Procesadas/Multi/',nombreImagen];
TiffActual = Tiff(pathImagen,'r+');

      [~,nombreIm, ~] = fileparts(nombreImagen);
      set(handles.lblNombreImagen,'string',nombreIm);
       
       dataImOriginal=TiffActual.read();% Leemos la info del Tiff
      
       tamanoIm=size(dataImOriginal);
       set(handles.lblTamano,'string',[num2str(tamanoIm(1)),'x',num2str(tamanoIm(2))]);
       
       numBandas=tamanoIm(3);
       set(handles.lblBandas,'string',numBandas);
       
       axes(handles.axsHistograma);% Dibujamos el histograma 
       imhist(dataImOriginal(:,:,indiceBanda));
       
       axes(handles.axsImagen); %Mostramos la imagen
       imshow(imadjust(dataImOriginal(:,:,indiceBanda)));
       
       switch colormapSeleccionado
           
           case 'Gray'
               
               colormap('Gray');
               
           case 'Red to Green'
               
              colormap('HSV');
               
           case 'Jet'
               
               colormap('Jet');
               
           otherwise msgbox('Error en el programa');
       end
       


% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_Visor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnInforme.
function btnInforme_Callback(hObject, eventdata, handles)
winopen([handles.pathProyecto,'/Procesadas/Multi/Informe de postprocesado.txt']);


% --- Executes on selection change in lstBandas.
function lstBandas_Callback(hObject, eventdata, handles)
colormapSeleccionado=get(get(handles.pnlColormap,'SelectedObject'),'String');% Obtenemos primero el handles del radiobutton seleccionado y luego el string de �ste.
indiceImagen=get(handles.lstImagenes,'value');
indiceBanda=get(handles.lstBandas,'value');
cambioImagen(indiceImagen,indiceBanda,colormapSeleccionado);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function lstBandas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstBandas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstImagenes.
function lstImagenes_Callback(hObject, eventdata, handles)
colormapSeleccionado=get(get(handles.pnlColormap,'SelectedObject'),'String');% Obtenemos primero el handles del radiobutton seleccionado y luego el string de �ste.
indiceImagen=get(hObject,'value');
indiceBanda=get(handles.lstBandas,'value');
cambioImagen(indiceImagen,indiceBanda,colormapSeleccionado);


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function lstImagenes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstImagenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnVolver.
function btnVolver_Callback(hObject, eventdata, handles)
% hObject    handle to btnVolver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close NDRVI_Visor
NDRVI_Main(handles.indiceProyecto);


% --- Executes on button press in btnGInput.
function btnGInput_Callback(hObject, eventdata, handles)
% hObject    handle to btnGInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axsHistograma);
ginput(1);


% --- Executes when selected object is changed in pnlColormap.
function pnlColormap_SelectionChangeFcn(hObject, eventdata, handles)
colormapSeleccionado=get(get(handles.pnlColormap,'SelectedObject'),'String');% Obtenemos primero el handles del radiobutton seleccionado y luego el string de �ste.
indiceImagen=get(handles.lstImagenes,'value');
indiceBanda=get(handles.lstBandas,'value');
cambioImagen(indiceImagen,indiceBanda,colormapSeleccionado);

guidata(hObject, handles);
