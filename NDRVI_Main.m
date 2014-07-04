function varargout = NDRVI_Main(varargin)
% NDRVI_Main MATLAB code for NDRVI_Main.fig
%      NDRVI_Main, by itself, creates a new NDRVI_Main or raises the existing
%      singleton*.
%
%      H = NDRVI_Main returns the handle to a new NDRVI_Main or the handle to
%      the existing singleton*.
%
%      NDRVI_Main('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NDRVI_Main.M with the given input arguments.
%
%      NDRVI_Main('Property','Value',...) creates a new NDRVI_Main or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NDRVI_Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NDRVI_Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NDRVI_Main

% Last Modified by GUIDE v2.5 01-Jul-2014 10:26:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_Main_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_Main_OutputFcn, ...
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


% --- Executes just before NDRVI_Main is made visible.
function NDRVI_Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NDRVI_Main (see VARARGIN)

% Choose default command line output for NDRVI_Main
handles.output = hObject;

global program_name;
program_name='AgroMav Image Processing Software';
set(handles.title,'string',program_name);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NDRVI_Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_editor_Archivo_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_editor_Archivo_Salir_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Archivo_Salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all;
close NDRVI_Main;


% --------------------------------------------------------------------
function menu_editor_Ayuda_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_editor_Ayuda_Acerda_de_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Ayuda_Acerda_de (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NDRVI_About;


% --------------------------------------------------------------------
function menu_editor_Ayuda_Guia_NDRVI_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Ayuda_Guia_NDRVI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

winopen('Guía NDRVI Program.pdf');


% --- Executes on button press in NDRVI_MultiBanda.
function NDRVI_MultiBanda_Callback(hObject, eventdata, handles)
% hObject    handle to NDRVI_MultiBanda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close NDRVI_Main;
NDRVI_Menu_Multibanda;


% --- Executes on button press in NDRVI_Blue.
function NDRVI_Blue_Callback(hObject, eventdata, handles)
% hObject    handle to NDRVI_Blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close NDRVI_Main;
NDRVI_Menu_Blue;


% --- Executes on button press in PostProc.
function PostProc_Callback(hObject, eventdata, handles)
% hObject    handle to PostProc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close NDRVI_Main;
NDRVI_Im_PostProc;


% --- Executes on button press in NDRVI_MultiBandaSingle.
function NDRVI_MultiBandaSingle_Callback(hObject, eventdata, handles)
% hObject    handle to NDRVI_MultiBandaSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close NDRVI_Main;
NDRVI_Menu_Multibanda_Single;


function btnTif16_Callback(hObject, eventdata, handles)
close NDRVI_Main;
NDRVI_TiffMPa16;
