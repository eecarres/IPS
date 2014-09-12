function varargout = GeneradorInforme(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GeneradorInforme_OpeningFcn, ...
                   'gui_OutputFcn',  @GeneradorInforme_OutputFcn, ...
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


% --- Executes just before GeneradorInforme is made visible.
function GeneradorInforme_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GeneradorInforme (see VARARGIN)

% Choose default command line output for GeneradorInforme
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

set(handles.lblNombreProyecto,'String',char(pathProyecto));

nombresProyectos = dir(fullfile([pathProyecto,'/Tiffs 16 bits para procesar/6 bandes']));

numeroProyectos= size(nombresProyectos);
numeroProyectos=numeroProyectos(1);
nombresProyectos=char(nombresProyectos.name);
j=0;
if numeroProyectos>2
for i=3:numeroProyectos
    j=j+1;
    nombresLista(j,:)=char(nombresProyectos(i,:));
    
end
set(handles.lstImagenes,'String',nombresLista);
end

%% Cargar las bandas y su orden para CIR del proyecto:
nombreProyecto=strsplit(pathProyecto,'/'); % Sacamos el nombre del path
nombreProyecto=nombreProyecto{3};
load(['C:/Agromav IPS/',nombreProyecto,'/Informe/',nombreProyecto,'.mat']); % Cargamos el archivo con la info del proyecto;
bandasOrdenadas=[Bandas(vectorOrden(1)) Bandas(vectorOrden(2)) Bandas(vectorOrden(3)) Bandas(vectorOrden(4)) Bandas(vectorOrden(5)) Bandas(vectorOrden(6))];% Ordenamos las bandas

set(handles.popIR,'String',bandasOrdenadas);
set(handles.popR,'String',bandasOrdenadas);
set(handles.popG,'String',bandasOrdenadas);

guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = GeneradorInforme_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function btnVolver_Callback(hObject, eventdata, handles)
close GeneradorInforme;
NDRVI_Main(handles.indiceProyecto);


function lstImagenes_Callback(hObject, eventdata, handles)


function lstImagenes_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function btnGenerarInforme_Callback(hObject, eventdata, handles)
%Nombre de la imagen
nombresImagenes=get(handles.lstImagenes,'string');
nombreImagen=char(nombresImagenes(get(handles.lstImagenes,'value'),:))  ;
nombreImagen=strtrim(nombreImagen);
%Sacamos el nombre del proyecto
[direccion,nombreProyecto]=strtok(handles.pathProyecto,'/');
[direccion,nombreProyecto]=strtok(nombreProyecto,'/');
nombreProyecto=nombreProyecto(2:end);

pathProyecto=[handles.pathProyecto,'/Tiffs 16 bits para procesar/6 bandes'];
%Generamos el string de llamada al informe

bandaIR=get(handles.popIR,'Value');
bandaR=get(handles.popR,'Value');
bandaG=get(handles.popG,'Value');

CIR=[bandaIR bandaR bandaG];

save([handles.pathProyecto,'/Informe/',nombreProyecto,'AUX.mat'], 'nombreProyecto','nombreImagen','pathProyecto','CIR');

load ([handles.pathProyecto,'/Informe/',nombreProyecto,'AUX.mat']);

uiwait(helpdlg(['Arrastra Matlab los archivos ',nombreProyecto,'.mat (tanto el normal como el AUX)']))





% --- Executes on selection change in popIR.
function popIR_Callback(hObject, eventdata, handles)
% hObject    handle to popIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popIR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popIR


% --- Executes during object creation, after setting all properties.
function popIR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popR.
function popR_Callback(hObject, eventdata, handles)
% hObject    handle to popR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popR


% --- Executes during object creation, after setting all properties.
function popR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popG.
function popG_Callback(hObject, eventdata, handles)
% hObject    handle to popG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popG contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popG


% --- Executes during object creation, after setting all properties.
function popG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnInforme.
function btnInforme_Callback(hObject, eventdata, handles)
%Nombre de la imagen
nombresImagenes=get(handles.lstImagenes,'string');
nombreImagen=char(nombresImagenes(get(handles.lstImagenes,'value'),:))  ;
nombreImagen=strtrim(nombreImagen);
%Sacamos el nombre del proyecto
[direccion,nombreProyecto]=strtok(handles.pathProyecto,'/');
[direccion,nombreProyecto]=strtok(nombreProyecto,'/');
nombreProyecto=nombreProyecto(2:end);


load ([handles.pathProyecto,'/Informe/',nombreProyecto,'AUX.mat']);

publish('Informe.m','codeToEvaluate','Informe(nombreProyecto,pathProyecto,nombreImagen,CIR)','showCode',false,'outputDir',['C:/Agromav IPS/', nombreProyecto,'/Informe']);