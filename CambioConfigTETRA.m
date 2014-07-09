function varargout = CambioConfigTETRA(varargin)
%% Entradas y salidas:
% Entrada: String con la configuración actual
% Salida: String con la configuración actualizada
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CambioConfigTETRA_OpeningFcn, ...
                   'gui_OutputFcn',  @CambioConfigTETRA_OutputFcn, ...
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


% --- Executes just before CambioConfigTETRA is made visible.
function CambioConfigTETRA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CambioConfigTETRA (see VARARGIN)

% Choose default command line output for CambioConfigTETRA
handles.output = hObject;


[status,sheets] = xlsfinfo('DB_folder/Config_TetraCam_db.xlsx') ; % ABrimos el excel con los datos
set(handles.popConfig,'String',char(sheets(1,:)));% Damos nombres a las configuraciones


opcion=get(handles.popConfig,'Value');

[~, ~, bandas]=xlsread('DB_folder/Config_TetraCam_db.xlsx',opcion,'B1:B6');

handles.bandas=bandas;

set(handles.lblMaster,'String',handles.bandas(1));

set(handles.lblB1,'String',handles.bandas(2));

set(handles.lblB2,'String',handles.bandas(3));

set(handles.lblB3,'String',handles.bandas(4));

set(handles.lblB4,'String',handles.bandas(5));

set(handles.lblB5,'String',handles.bandas(6));

guidata(hObject, handles);










% --- Outputs from this function are returned to the command line.
function varargout = CambioConfigTETRA_OutputFcn(hObject, eventdata, handles) 
uiwait;
try %this statement is necessary if figure is destroyed , then output argument will be empty by default
configuraciones=get(handles.popConfig,'String');
 varargout{1}=configuraciones(get(handles.popConfig,'Value'),:);
 varargout{1}=strtrim(varargout{1});
 varargout{2}=handles.bandas;
catch
    varargout{1} = [];
     varargout{2}= [];
end

close CambioConfigTETRA;


% --- Executes on selection change in popConfig.
function popConfig_Callback(hObject, eventdata, handles)

% Ponemos los valores de cada banda en funcion de la configuracion escogida

opcion=get(handles.popConfig,'Value');

[~, ~, bandas]=xlsread('DB_folder/Config_TetraCam_db.xlsx',opcion,'B1:B6');

handles.bandas=bandas;

set(handles.lblMaster,'String',handles.bandas(1));

set(handles.lblB1,'String',handles.bandas(2));

set(handles.lblB2,'String',handles.bandas(3));

set(handles.lblB3,'String',handles.bandas(4));

set(handles.lblB4,'String',handles.bandas(5));

set(handles.lblB5,'String',handles.bandas(6));


guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popConfig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAceptar.
function btnAceptar_Callback(hObject, eventdata, handles)
% hObject    handle to btnAceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume;