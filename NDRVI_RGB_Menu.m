function varargout = NDRVI_RGB_Menu(varargin)
% NDRVI_RGB_MENU MATLAB code for NDRVI_RGB_Menu.fig
%      NDRVI_RGB_MENU, by itself, creates a new NDRVI_RGB_MENU or raises the existing
%      singleton*.
%
%      H = NDRVI_RGB_MENU returns the handle to a new NDRVI_RGB_MENU or the handle to
%      the existing singleton*.
%
%      NDRVI_RGB_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NDRVI_RGB_MENU.M with the given input arguments.
%
%      NDRVI_RGB_MENU('Property','Value',...) creates a new NDRVI_RGB_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NDRVI_RGB_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NDRVI_RGB_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NDRVI_RGB_Menu

% Last Modified by GUIDE v2.5 18-Nov-2013 10:53:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_RGB_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_RGB_Menu_OutputFcn, ...
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


% --- Executes just before NDRVI_RGB_Menu is made visible.
function NDRVI_RGB_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NDRVI_RGB_Menu (see VARARGIN)

% Choose default command line output for NDRVI_RGB_Menu
handles.output = hObject;

handles.rgb_g_limits(1)=varargin{1};
handles.rgb_g_limits(2)=varargin{2};
handles.rgb_g_limits(3)=varargin{3};
handles.rgb_g_limits(4)=varargin{4};
handles.rgb_g_limits(5)=varargin{5};
handles.rgb_g_limits(6)=varargin{6};

handles.suelo=varargin{7};

handles.auxiliar_limits(1)=varargin{8};
handles.auxiliar_limits(2)=varargin{9};
handles.auxiliar_limits(3)=varargin{10};
handles.auxiliar_limits(4)=varargin{11};
handles.auxiliar_limits(5)=varargin{12};
handles.auxiliar_limits(6)=varargin{13};

handles.check_aux(1)=varargin{14};
handles.check_aux(2)=varargin{15};
handles.check_aux(3)=varargin{16};

set(handles.edit_Banda_Azul,'String',handles.rgb_g_limits(1));
set(handles.edit_hasta_Azul,'String',handles.rgb_g_limits(2));
set(handles.edit_Banda_Verde,'String',handles.rgb_g_limits(3));
set(handles.edit_hasta_Verde,'String',handles.rgb_g_limits(4));
set(handles.edit_Banda_Roja,'String',handles.rgb_g_limits(5));
set(handles.edit_hasta_Roja,'String',handles.rgb_g_limits(6));

set(handles.checkbox_suelo,'Value',handles.suelo);

set(handles.edit_Banda_Auxiliar1,'String',handles.auxiliar_limits(1));
set(handles.edit_hasta_Auxiliar1,'String',handles.auxiliar_limits(2));
set(handles.edit_Banda_Auxiliar2,'String',handles.auxiliar_limits(3));
set(handles.edit_hasta_Auxiliar2,'String',handles.auxiliar_limits(4));
set(handles.edit_Banda_Auxiliar3,'String',handles.auxiliar_limits(5));
set(handles.edit_hasta_Auxiliar3,'String',handles.auxiliar_limits(6));

set(handles.checkbox_Auxiliar1,'Value',handles.check_aux(1));
set(handles.checkbox_Auxiliar2,'Value',handles.check_aux(2));
set(handles.checkbox_Auxiliar3,'Value',handles.check_aux(3));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NDRVI_RGB_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);
uiwait(handles.figure1); %MODIFICADO


% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_RGB_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output; MODIFICADO

%varargout{1} = handles.output;
varargout{1} = handles.rtrn(1); %Banda Azul
varargout{2} = handles.rtrn(2); %Hasta Banda Azul
varargout{3} = handles.rtrn(3); %Banda Verde
varargout{4} = handles.rtrn(4); %Hasta Banda Verde
varargout{5} = handles.rtrn(5); %Banda Roja
varargout{6} = handles.rtrn(6); %Hasta Banda Roja
varargout{7} = handles.rtrn(7); %Suelo
varargout{8} = handles.rtrn(8); %Banda Auxiliar 1
varargout{9} = handles.rtrn(9); %Hasta Banda Auxiliar 1
varargout{10} = handles.rtrn(10); %Banda Auxiliar 2
varargout{11} = handles.rtrn(11); %Hasta Banda Auxiliar 2
varargout{12} = handles.rtrn(12); %Banda Auxiliar 3
varargout{13} = handles.rtrn(13); %Hasta Banda Auxiliar 3
varargout{14} = handles.rtrn(14); %Check Auxiliar 1
varargout{15} = handles.rtrn(15); %Check Auxiliar 2
varargout{16} = handles.rtrn(16); %Check Auxiliar 3
% The figure can be deleted now
delete(handles.figure1);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% delete(hObject); MODIFICADO

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


function edit_Banda_Azul_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Azul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Banda_Azul as text
%        str2double(get(hObject,'String')) returns contents of edit_Banda_Azul as a double


% --- Executes during object creation, after setting all properties.
function edit_Banda_Azul_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Azul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hasta_Azul_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Azul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hasta_Azul as text
%        str2double(get(hObject,'String')) returns contents of edit_hasta_Azul as a double

set(handles.edit_Banda_Verde,'String',get(handles.edit_hasta_Azul,'String'));


% --- Executes during object creation, after setting all properties.
function edit_hasta_Azul_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Azul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Banda_Verde_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Verde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Banda_Verde as text
%        str2double(get(hObject,'String')) returns contents of edit_Banda_Verde as a double

set(handles.edit_hasta_Azul,'String',get(handles.edit_Banda_Verde,'String'));


% --- Executes during object creation, after setting all properties.
function edit_Banda_Verde_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Verde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hasta_Verde_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Verde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hasta_Verde as text
%        str2double(get(hObject,'String')) returns contents of edit_hasta_Verde as a double

set(handles.edit_Banda_Roja,'String',get(handles.edit_hasta_Verde,'String'));


% --- Executes during object creation, after setting all properties.
function edit_hasta_Verde_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Verde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Banda_Roja_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Roja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Banda_Roja as text
%        str2double(get(hObject,'String')) returns contents of edit_Banda_Roja as a double

set(handles.edit_hasta_Verde,'String',get(handles.edit_Banda_Roja,'String'));


% --- Executes during object creation, after setting all properties.
function edit_Banda_Roja_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Roja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hasta_Roja_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Roja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hasta_Roja as text
%        str2double(get(hObject,'String')) returns contents of edit_hasta_Roja as a double


% --- Executes during object creation, after setting all properties.
function edit_hasta_Roja_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Roja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Banda_Auxiliar1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Auxiliar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Banda_Auxiliar1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Banda_Auxiliar1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Banda_Auxiliar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Auxiliar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hasta_Auxiliar1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Auxiliar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hasta_Auxiliar1 as text
%        str2double(get(hObject,'String')) returns contents of edit_hasta_Auxiliar1 as a double


% --- Executes during object creation, after setting all properties.
function edit_hasta_Auxiliar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Auxiliar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Banda_Auxiliar2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Auxiliar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Banda_Auxiliar2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Banda_Auxiliar2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Banda_Auxiliar2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Auxiliar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hasta_Auxiliar2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Auxiliar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hasta_Auxiliar2 as text
%        str2double(get(hObject,'String')) returns contents of edit_hasta_Auxiliar2 as a double


% --- Executes during object creation, after setting all properties.
function edit_hasta_Auxiliar2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Auxiliar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Banda_Auxiliar3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Auxiliar3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Banda_Auxiliar3 as text
%        str2double(get(hObject,'String')) returns contents of edit_Banda_Auxiliar3 as a double


% --- Executes during object creation, after setting all properties.
function edit_Banda_Auxiliar3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Banda_Auxiliar3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hasta_Auxiliar3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Auxiliar3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hasta_Auxiliar3 as text
%        str2double(get(hObject,'String')) returns contents of edit_hasta_Auxiliar3 as a double


% --- Executes during object creation, after setting all properties.
function edit_hasta_Auxiliar3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hasta_Auxiliar3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_suelo.
function checkbox_suelo_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_suelo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_suelo


% --- Executes on button press in checkbox_Auxiliar1.
function checkbox_Auxiliar1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Auxiliar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Auxiliar1


% --- Executes on button press in checkbox_Auxiliar2.
function checkbox_Auxiliar2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Auxiliar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Auxiliar2


% --- Executes on button press in checkbox_Auxiliar3.
function checkbox_Auxiliar3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Auxiliar3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Auxiliar3


% --- Executes on button press in pushbutton_ok.
function pushbutton_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.rtrn(1)=str2double(get(handles.edit_Banda_Azul,'String'));
handles.rtrn(2)=str2double(get(handles.edit_hasta_Azul,'String'));
handles.rtrn(3)=str2double(get(handles.edit_Banda_Verde,'String'));
handles.rtrn(4)=str2double(get(handles.edit_hasta_Verde,'String'));
handles.rtrn(5)=str2double(get(handles.edit_Banda_Roja,'String'));
handles.rtrn(6)=str2double(get(handles.edit_hasta_Roja,'String'));
handles.rtrn(7)=get(handles.checkbox_suelo,'Value');

handles.rtrn(14)=get(handles.checkbox_Auxiliar1,'Value');
handles.rtrn(15)=get(handles.checkbox_Auxiliar2,'Value');
handles.rtrn(16)=get(handles.checkbox_Auxiliar3,'Value');

if handles.rtrn(14)==1
    handles.rtrn(8)=str2double(get(handles.edit_Banda_Auxiliar1,'String'));
    handles.rtrn(9)=str2double(get(handles.edit_hasta_Auxiliar1,'String'));
else
    handles.rtrn(8)=0;
    handles.rtrn(9)=0;
end

if handles.rtrn(15)==1
    handles.rtrn(10)=str2double(get(handles.edit_Banda_Auxiliar2,'String'));
    handles.rtrn(11)=str2double(get(handles.edit_hasta_Auxiliar2,'String'));
else
    handles.rtrn(10)=0;
    handles.rtrn(11)=0;
end

if handles.rtrn(16)==1
    handles.rtrn(12)=str2double(get(handles.edit_Banda_Auxiliar3,'String'));
    handles.rtrn(13)=str2double(get(handles.edit_hasta_Auxiliar3,'String'));
else
    handles.rtrn(12)=0;
    handles.rtrn(13)=0;
end

guidata(hObject, handles);

close NDRVI_RGB_Menu;
