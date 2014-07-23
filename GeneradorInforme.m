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




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GeneradorInforme wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
save([handles.pathProyecto,'/Informe/',nombreProyecto,'AUX.mat'], 'nombreProyecto','nombreImagen','pathProyecto');

load ([handles.pathProyecto,'/Informe/',nombreProyecto,'AUX.mat']);

uiwait(helpdlg(['Arrastra Matlab los archivos ',nombreProyecto,'.mat (tanto el normal como el AUX)']))


publish('Informe.m','codeToEvaluate','Informe(nombreProyecto,pathProyecto,nombreImagen)','showCode',false,'outputDir',['C:/Agromav IPS/', nombreProyecto,'/Informe']);