function varargout = NDRVI_Menu_Multibanda(varargin)
% NDRVI_Menu_Multibanda MATLAB code for NDRVI_Menu_Multibanda.fig
%      NDRVI_Menu_Multibanda, by itself, creates a new NDRVI_Menu_Multibanda or raises the existing
%      singleton*.
%
%      H = NDRVI_Menu_Multibanda returns the handle to a new NDRVI_Menu_Multibanda or the handle to
%      the existing singleton*.
%
%      NDRVI_Menu_Multibanda('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NDRVI_Menu_Multibanda.M with the given input arguments.
%
%      NDRVI_Menu_Multibanda('Property','Value',...) creates a new NDRVI_Menu_Multibanda or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NDRVI_Menu_Multibanda_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NDRVI_Menu_Multibanda_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NDRVI_Menu_Multibanda

% Last Modified by GUIDE v2.5 03-Jul-2014 13:42:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_Menu_Multibanda_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_Menu_Multibanda_OutputFcn, ...
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


% --- Executes just before NDRVI_Menu_Multibanda is made visible.
function NDRVI_Menu_Multibanda_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NDRVI_Menu_Multibanda (see VARARGIN)

% Choose default command line output for NDRVI_Menu_Multibanda
handles.output = hObject;

%%  Cargamos el nombre del programa
global program_name;
set(handles.title,'string',program_name);
%% Añadimos las funciones de Indices
%clc;
%matlabpool open 2;
%% Generamos las 6 bandas del programa
handles.Master=Banda;
handles.B1=Banda;
handles.B2=Banda;
handles.B3=Banda;
handles.B4=Banda;
handles.B5=Banda;

%% Ponemos a 0 los radiobuttons
set(handles.radiobutton_dentro_imagen_Master,'value',0);
set(handles.radiobutton_fuera_imagen_Master,'value',0);
set(handles.radiobutton_dentro_imagen_1,'value',0);
set(handles.radiobutton_fuera_imagen_1,'value',0);
set(handles.radiobutton_dentro_imagen_2,'value',0);
set(handles.radiobutton_fuera_imagen_2,'value',0);
set(handles.radiobutton_dentro_imagen_3,'value',0);
set(handles.radiobutton_fuera_imagen_3,'value',0);
set(handles.radiobutton_dentro_imagen_4,'value',0);
set(handles.radiobutton_fuera_imagen_4,'value',0);
set(handles.radiobutton_dentro_imagen_5,'value',0);
set(handles.radiobutton_fuera_imagen_5,'value',0);

%Inicializa los valores de las reflectancias de cada Banda presentes en la
%DB
[Master_db,IR_db_text]=xlsread('c\..\DB_folder\Multibanda_db.xlsx',1); %% posible fallo¿? IR_db_text dond va?
IR_db_size=size(Master_db);
str_list_Master{1}=IR_db_text{1};
str_list_Master{2}=IR_db_text{2};
for i=1:IR_db_size(1)
    str_list_Master{i+2}=strcat(num2str(Master_db(i,1)),'/',num2str(Master_db(i,2)));
end

[B1_db,R_db_text]=xlsread('c\..\DB_folder\Multibanda_db.xlsx',2);
R_db_size=size(B1_db);
str_list_B1{1}=R_db_text{1};
str_list_B1{2}=R_db_text{2};
for i=1:R_db_size(1)
    str_list_B1{i+2}=strcat(num2str(B1_db(i,1)),'/',num2str(B1_db(i,2)));
end

[B2_db,R_db_text]=xlsread('c\..\DB_folder\Multibanda_db.xlsx',3);
R_db_size=size(B2_db);
str_list_B2{1}=R_db_text{1};
str_list_B2{2}=R_db_text{2};
for i=1:R_db_size(1)
    str_list_B2{i+2}=strcat(num2str(B2_db(i,1)),'/',num2str(B2_db(i,2)));
end

[B3_db,R_db_text]=xlsread('c\..\DB_folder\Multibanda_db.xlsx',4);
R_db_size=size(B3_db);
str_list_B3{1}=R_db_text{1};
str_list_B3{2}=R_db_text{2};
for i=1:R_db_size(1)
    str_list_B3{i+2}=strcat(num2str(B3_db(i,1)),'/',num2str(B3_db(i,2)));
end

[B4_db,R_db_text]=xlsread('c\..\DB_folder\Multibanda_db.xlsx',5);
R_db_size=size(B4_db);
str_list_B4{1}=R_db_text{1};
str_list_B4{2}=R_db_text{2};
for i=1:R_db_size(1)
    str_list_B4{i+2}=strcat(num2str(B4_db(i,1)),'/',num2str(B4_db(i,2)));
end

[B5_db,R_db_text]=xlsread('c\..\DB_folder\Multibanda_db.xlsx',6);
R_db_size=size(B5_db);
str_list_B5{1}=R_db_text{1};
str_list_B5{2}=R_db_text{2};
for i=1:R_db_size(1)
    str_list_B5{i+2}=strcat(num2str(B5_db(i,1)),'/',num2str(B5_db(i,2)));
end

%% cargamos los posibles indices
str_list_IV=importdata('c\..\DB_folder\IV_db.xlsx');

%% Fijamos los valores de los popupmenus
set(handles.popupmenu_valores_Master,'string',str_list_Master);
set(handles.popupmenu_valores_1,'string',str_list_B1);
set(handles.popupmenu_valores_2,'string',str_list_B2);
set(handles.popupmenu_valores_3,'string',str_list_B3);
set(handles.popupmenu_valores_4,'string',str_list_B4);
set(handles.popupmenu_valores_5,'string',str_list_B5);
set(handles.popupmenu_IV,'string',str_list_IV);

%% Guardamos en handles los valores
handles.Master.database=Master_db;
handles.B1.database=B1_db;
handles.B2.database=B2_db;
handles.B3.database=B3_db;
handles.B4.database=B4_db;
handles.B5.database=B5_db;

handles.x1_B1=[];
handles.x1_B2=[];
handles.x1_B3=[];
handles.x1_B4=[];
handles.x1_B5=[];

clear IR_db IR_db_size IR_db_text R_db R_db_size R_db_text


%% Borramos la seleccion de color para el mapa final
set(handles.radiobutton_RGB_Gris,'value',0);
set(handles.radiobutton_Jet,'value',0);
set(handles.radiobutton_Rainbow,'value',0);


%% Indice elegido por defecto NDVI

handles.opcionIndice=1;


%% Establecemos los valores de las reflectancias de cada banda

set(handles.edit_ref_blanco_master,'String',num2str(0.9));
set(handles.edit_ref_gris_master,'String',num2str(0.18));
set(handles.edit_ref_negro_master,'String',num2str(0.05));

set(handles.edit_ref_blanco_1,'String',num2str(0.9));
set(handles.edit_ref_gris_1,'String',num2str(0.18));
set(handles.edit_ref_negro_1,'String',num2str(0.05));

set(handles.edit_ref_blanco_2,'String',num2str(0.9));
set(handles.edit_ref_gris_2,'String',num2str(0.18));
set(handles.edit_ref_negro_2,'String',num2str(0.05));

set(handles.edit_ref_blanco_3,'String',num2str(0.9));
set(handles.edit_ref_gris_3,'String',num2str(0.18));
set(handles.edit_ref_negro_3,'String',num2str(0.05));

set(handles.edit_ref_blanco_4,'String',num2str(0.9));
set(handles.edit_ref_gris_4,'String',num2str(0.18));
set(handles.edit_ref_negro_4,'String',num2str(0.05));

set(handles.edit_ref_blanco_5,'String',num2str(0.9));
set(handles.edit_ref_gris_5,'String',num2str(0.18));
set(handles.edit_ref_negro_5,'String',num2str(0.05));


%% Exactamente no se a que se refiere
handles.rgb_g_limits(1)=0; handles.rgb_g_limits(2)=handles.rgb_g_limits(1);
handles.rgb_g_limits(3)=handles.rgb_g_limits(1); handles.rgb_g_limits(4)=handles.rgb_g_limits(1);
handles.rgb_g_limits(5)=handles.rgb_g_limits(1); handles.rgb_g_limits(6)=handles.rgb_g_limits(1);

handles.status_suelo=0;

handles.auxiliar_limits(1)=0; handles.auxiliar_limits(2)=handles.auxiliar_limits(1);
handles.auxiliar_limits(3)=handles.auxiliar_limits(1); handles.auxiliar_limits(4)=handles.auxiliar_limits(1);
handles.auxiliar_limits(5)=handles.auxiliar_limits(1); handles.auxiliar_limits(6)=handles.auxiliar_limits(1);

handles.check_aux(1)=0; handles.check_aux(2)=handles.check_aux(1); handles.check_aux(3)=handles.check_aux(1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NDRVI_Menu_Multibanda wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_Menu_Multibanda_OutputFcn(hObject, eventdata, handles) 
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
function menu_editor_Archivo_Biblioteca_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Archivo_Biblioteca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

winopen('c\..\DB_folder\BIBLIO_IND_db.xlsx');


% --------------------------------------------------------------------
function menu_editor_Archivo_Volver_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Archivo_Volver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all;
close NDRVI_Menu_Multibanda;
NDRVI_Main;


% --------------------------------------------------------------------
function menu_editor_Archivo_Salir_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Archivo_Salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all;
close NDRVI_Menu_Multibanda;


% --------------------------------------------------------------------
function menu_editor_Ayuda_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_editor_Ayuda_Acerca_de_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Ayuda_Acerca_de (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NDRVI_About;


% --- Executes when selected object is changed in uipanel_calibracion_master.
function uipanel_calibracion_master_SelectionChangeFcn(hObject, eventdata, handles)


fuera_imagen_value_Master=get(handles.radiobutton_fuera_imagen_Master,'Value');

% si es 0 es dentro de imagen y 1 es fuera imagen
if fuera_imagen_value_Master==1
    % Calibración Master
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*.*'},'Selecciona imagen calibración Master');
    % Leemos la imagen y nos quedamos solo con el canal que nos interesa (Tiff tiene 3 canales iguales aunque sea monocroma)
    ND=double(imread(strcat(Im_PathName,Im_Name)));
    ND_Master=ND(:,:,1);
    % Obtenemos el máximo y el mínimo y hacemos el stretching
    minimo1=min(min(ND_Master)); %% Doble min pq es matriz
    maximo1=max(max(ND_Master)); %% Doble max pq es matriz
    ima1=figure;
    imshow(ND_Master);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda Master)');
    colorbar;
    [x,y]= ginput(3);
    handles.XY=[x,y];
    handles.PathCalibracion=strcat(Im_PathName,Im_Name);
    %% Guardamos los valores digitales de los puntos para luego mostrarlos en la UI
    maximo= ND_Master( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_Master( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_Master( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_Master=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n x y
else
    %% Si es dentro de imagen se colocan como 0 los valores digitales de negro blanco y gris
    handles.x1_Master(1)=0; handles.x1_Master(2)=handles.x1_Master(1); handles.x1_Master(3)=handles.x1_Master(1);
end
%% Mostramos en la UI los valores digitales de los tres colores
set(handles.edit_calib_blanco_master,'String',handles.x1_Master(1));
set(handles.edit_calib_gris_master,'String',handles.x1_Master(2));
set(handles.edit_calib_negro_master,'String',handles.x1_Master(3));


guidata(hObject, handles);


% --- Executes when selected object is changed in uipanel_calibracion_1.
function uipanel_calibracion_1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_calibracion_1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

fuera_imagen_value_B1=get(handles.radiobutton_fuera_imagen_1,'Value');
if fuera_imagen_value_B1==1
    %Calibración B1
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagen calibración Banda 1');
    ND=double(imread(strcat(Im_PathName,Im_Name)));
    ND_B1=ND(:,:,1);
    minimo1=min(min(ND_B1));
    maximo1=max(max(ND_B1));
    ima1=figure;
    imshow(ND_B1);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda 1)');
    colorbar;
    [x,y]= ginput(3);
    maximo= ND_B1( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B1( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B1( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B1=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_B1 minimo1 maximo1 ima1 maximo minimo_g minimo_n x y
else
    handles.x1_B1(1)=0; handles.x1_B1(2)=handles.x1_B1(1); handles.x1_B1(3)=handles.x1_B1(1);
end

set(handles.edit_calib_blanco_1,'String',handles.x1_B1(1));
set(handles.edit_calib_gris_1,'String',handles.x1_B1(2));
set(handles.edit_calib_negro_1,'String',handles.x1_B1(3));

guidata(hObject, handles);



% --- Executes when selected object is changed in uipanel_calibracion_2.
function uipanel_calibracion_2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_calibracion_2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
fuera_imagen_value_B2=get(handles.radiobutton_fuera_imagen_2,'Value');
if fuera_imagen_value_B2==1
    %Calibración B2
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagen calibración Banda 2');
    ND=double(imread(strcat(Im_PathName,Im_Name)));
    ND_B2=ND(:,:,1);
    minimo1=min(min(ND_B2));
    maximo1=max(max(ND_B2));
    ima1=figure;
    imshow(ND_B2);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda 2)');
    colorbar;
    [x,y]= ginput(3);
    maximo= ND_B2( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B2( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B2( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B2=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_B2 minimo1 maximo1 ima1 maximo minimo_g minimo_n x y
else
    handles.x1_B2(1)=0; handles.x1_B2(2)=handles.x1_B2(1); handles.x1_B2(3)=handles.x1_B2(1);
end

set(handles.edit_calib_blanco_2,'String',handles.x1_B2(1));
set(handles.edit_calib_gris_2,'String',handles.x1_B2(2));
set(handles.edit_calib_negro_2,'String',handles.x1_B2(3));

guidata(hObject, handles);

% --- Executes when selected object is changed in uipanel_calibracion_2.
function uipanel_calibracion_3_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_calibracion_2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
fuera_imagen_value_B3=get(handles.radiobutton_fuera_imagen_3,'Value');
if fuera_imagen_value_B3==1
    %Calibración B3
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagen calibración Banda 3');
    ND=double(imread(strcat(Im_PathName,Im_Name)));
    ND_B3=ND(:,:,1);
    minimo1=min(min(ND_B3));
    maximo1=max(max(ND_B3));
    ima1=figure;
    imshow(ND_B3);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda 3)');
    colorbar;
    [x,y]= ginput(3);
    maximo= ND_B3( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B3( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B3( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B3=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_B3 minimo1 maximo1 ima1 maximo minimo_g minimo_n x y
else
    handles.x1_B3(1)=0; handles.x1_B3(2)=handles.x1_B3(1); handles.x1_B3(3)=handles.x1_B3(1);
end

set(handles.edit_calib_blanco_3,'String',handles.x1_B3(1));
set(handles.edit_calib_gris_3,'String',handles.x1_B3(2));
set(handles.edit_calib_negro_3,'String',handles.x1_B3(3));

guidata(hObject, handles);


% --- Executes when selected object is changed in uipanel_calibracion_2.
function uipanel_calibracion_4_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_calibracion_2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
fuera_imagen_value_B4=get(handles.radiobutton_fuera_imagen_4,'Value');
if fuera_imagen_value_B4==1
    %Calibración B2
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagen calibración Banda 4');
    ND=double(imread(strcat(Im_PathName,Im_Name)));
    ND_B4=ND(:,:,1);
    minimo1=min(min(ND_B4));
    maximo1=max(max(ND_B4));
    ima1=figure;
    imshow(ND_B4);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda 4)');
    colorbar;
    [x,y]= ginput(3);
    maximo= ND_B4( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B4( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B4( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B4=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_B4 minimo1 maximo1 ima1 maximo minimo_g minimo_n x y
else
    handles.x1_B4(1)=0; handles.x1_B4(2)=handles.x1_B4(1); handles.x1_B4(3)=handles.x1_B4(1);
end

set(handles.edit_calib_blanco_4,'String',handles.x1_B4(1));
set(handles.edit_calib_gris_4,'String',handles.x1_B4(2));
set(handles.edit_calib_negro_4,'String',handles.x1_B4(3));

guidata(hObject, handles);

% --- Executes when selected object is changed in uipanel_calibracion_2.
function uipanel_calibracion_5_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_calibracion_2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
fuera_imagen_value_B5=get(handles.radiobutton_fuera_imagen_5,'Value');
if fuera_imagen_value_B5==1
    %Calibración B5
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagen calibración Banda 5');
    ND=double(imread(strcat(Im_PathName,Im_Name)));
    ND_B5=ND(:,:,1);
    minimo1=min(min(ND_B5));
    maximo1=max(max(ND_B5));
    ima1=figure;
    imshow(ND_B5);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda 5)');
    colorbar;
    [x,y]= ginput(3);
    maximo= ND_B5( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B5( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B5( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B5=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_B5 minimo1 maximo1 ima1 maximo minimo_g minimo_n x y
else
    handles.x1_B5(1)=0; handles.x1_B5(2)=handles.x1_B5(1); handles.x1_B5(3)=handles.x1_B5(1);
end

set(handles.edit_calib_blanco_5,'String',handles.x1_B5(1));
set(handles.edit_calib_gris_5,'String',handles.x1_B5(2));
set(handles.edit_calib_negro_5,'String',handles.x1_B5(3));

guidata(hObject, handles);

% --- Executes on selection change in popupmenu_valores_1.
function popupmenu_valores_1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valores_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valores_1


% --- Executes during object creation, after setting all properties.
function popupmenu_valores_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_valores_Master.
function popupmenu_valores_Master_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_Master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valores_Master contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valores_Master


% --- Executes during object creation, after setting all properties.
function popupmenu_valores_Master_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_Master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_IV.
function popupmenu_IV_Callback(hObject, eventdata, handles)

handles.opcionIndice=get(handles.popupmenu_IV,'Value');

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_IV_CreateFcn(hObject, eventdata, handles)
handles.opcionIndice=1;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel_colormap.
function uipanel_colormap_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_colormap 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

rgb_gris_value=get(handles.radiobutton_RGB_Gris,'Value');
if rgb_gris_value==1
    [handles.rgb_g_limits(1),handles.rgb_g_limits(2),handles.rgb_g_limits(3),handles.rgb_g_limits(4),handles.rgb_g_limits(5),handles.rgb_g_limits(6),handles.status_suelo,...
        handles.auxiliar_limits(1),handles.auxiliar_limits(2),handles.auxiliar_limits(3),handles.auxiliar_limits(4),handles.auxiliar_limits(5),handles.auxiliar_limits(6),...
        handles.check_aux(1),handles.check_aux(2),handles.check_aux(3)]=...
        NDRVI_RGB_Menu(handles.rgb_g_limits(1),handles.rgb_g_limits(2),handles.rgb_g_limits(3),handles.rgb_g_limits(4),handles.rgb_g_limits(5),handles.rgb_g_limits(6),handles.status_suelo,...
        handles.auxiliar_limits(1),handles.auxiliar_limits(2),handles.auxiliar_limits(3),handles.auxiliar_limits(4),handles.auxiliar_limits(5),handles.auxiliar_limits(6),...
        handles.check_aux(1),handles.check_aux(2),handles.check_aux(3));
end

guidata(hObject, handles);


function edit_ref_blanco_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_blanco_master as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_blanco_master as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_blanco_master_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_gris_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_gris_master as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_gris_master as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_gris_master_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_negro_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_negro_master as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_negro_master as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_negro_master_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ref_blanco_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_blanco_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_blanco_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_blanco_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_gris_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_gris_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_gris_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_gris_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_negro_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_negro_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_negro_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_negro_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_hist.
function checkbox_hist_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_hist

% --- Executes on button press in checkbox_cuadricula.
function checkbox_cuadricula_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_cuadricula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_cuadricula

status_cuad=get(handles.checkbox_cuadricula,'Value');
if status_cuad==1
    prompt={'Divisiones en X:','Divisiones en Y:'};
    dlg_title='Cuadrícula';
    num_lines=1;
    def={'',''};
    answer=inputdlg(prompt,dlg_title,num_lines,def);
    handles.cuad_div=str2double(answer);
    guidata(hObject, handles);
end


% --- Executes on button press in pushbutton_examinar_master.
function pushbutton_examinar_master_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_examinar_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagenes a procesar (Master)','MultiSelect', 'on');
handles.Master.path=strcat(Im_PathName,Im_Name);
set(handles.text_examinar_Master,'String',handles.Master.path);
clear Im_Name Im_PathName
guidata(hObject, handles);


% --- Executes on button press in pushbutton_examinar_1.
function pushbutton_examinar_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_examinar_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagenes a procesar (Banda 1)','MultiSelect', 'on');
handles.B1.path=strcat(Im_PathName,Im_Name);
set(handles.text_examinar_1,'String',handles.B1.path);
clear Im_Name Im_PathName
guidata(hObject, handles);


% --- Executes on button press in pushbutton_examinar_2.
function pushbutton_examinar_2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_examinar_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagenes a procesar (Banda 2)','MultiSelect', 'on');
handles.B2.path=strcat(Im_PathName,Im_Name);
set(handles.text_examinar_2,'String',handles.B2.path);
clear Im_Name Im_PathName
guidata(hObject, handles);

% --- Executes on button press in pushbutton_examinar_3.
function pushbutton_examinar_3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_examinar_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagenes a procesar (Banda 3)','MultiSelect', 'on');
handles.B3.path=strcat(Im_PathName,Im_Name);
set(handles.text_examinar_3,'String',handles.B3.path);
clear Im_Name Im_PathName
guidata(hObject, handles);

% --- Executes on button press in pushbutton_examinar_4.
function pushbutton_examinar_4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_examinar_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagenes a procesar (Banda 4)','MultiSelect', 'on');
handles.B4.path=strcat(Im_PathName,Im_Name);
set(handles.text_examinar_4,'String',handles.B4.path);
clear Im_Name Im_PathName
guidata(hObject, handles);

% --- Executes on button press in pushbutton_examinar_5.
function pushbutton_examinar_5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_examinar_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagenes a procesar (Banda 5)','MultiSelect', 'on');
handles.B5.path=strcat(Im_PathName,Im_Name);
set(handles.text_examinar_5,'String',handles.B5.path);
clear Im_Name Im_PathName
guidata(hObject, handles);

%% %% Llamada a funcion externa!



% --- Executes on button press in pushbutton_procesa.
function pushbutton_procesa_Callback(hObject, eventdata, handles)

if get(handles.chkCalibSimple,'Value')==1
%% Opcion de calibrar todas a la vez
% En caso de haber seleccionado la opción de calibrado simple, se evalúan
% el resto de  reflectancias

% para ello hay que abrir una imagen de cada banda de la 1 a la 5 con los
% mismos puntos de calibracion que la banda master

% Primero buscamos el path de la imagen. Sabemos que acabará en 1 y tiene
% el mismo nombre que la master:
    [pathGeneral,nombreMaster,extension] = fileparts(handles.PathCalibracion);
    nombreGeneral=nombreMaster(1:end-1);
    pathB1=strcat(pathGeneral,'/',nombreGeneral,num2str(1),extension);
    pathB2=strcat(pathGeneral,'/',nombreGeneral,num2str(2),extension);
    pathB3=strcat(pathGeneral,'/',nombreGeneral,num2str(3),extension);
    pathB4=strcat(pathGeneral,'/',nombreGeneral,num2str(4),extension);
    pathB5=strcat(pathGeneral,'/',nombreGeneral,num2str(5),extension);
    % Leemos la imagen y nos quedamos solo con el canal que nos interesa (Tiff tiene 3 canales iguales aunque sea monocroma)
    x= handles.XY(:,1);
    y= handles.XY(:,2);
    %Leemos la imagen de la banda correspondiente y obtenemos los valores
    %de calibracion usando los mismos puntos que para la banda master
    ND=double(imread(pathB1));
    ND_B1=ND(:,:,1);

    maximo= ND_B1( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B1( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B1( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B1=[maximo minimo_g minimo_n];
    
    % Mostramos en la UI los valores digitales de los tres colores
    set(handles.edit_calib_blanco_1,'String',handles.x1_B1(1));
    set(handles.edit_calib_gris_1,'String',handles.x1_B1(2));
    set(handles.edit_calib_negro_1,'String',handles.x1_B1(3));
    
        ND=double(imread(pathB2));
    ND_B2=ND(:,:,1);

    maximo= ND_B2( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B2( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B2( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B2=[maximo minimo_g minimo_n];
    
    % Mostramos en la UI los valores digitales de los tres colores
    set(handles.edit_calib_blanco_2,'String',handles.x1_B2(1));
    set(handles.edit_calib_gris_2,'String',handles.x1_B2(2));
    set(handles.edit_calib_negro_2,'String',handles.x1_B2(3));
    
    
        ND=double(imread(pathB3));
    ND_B3=ND(:,:,1);

    maximo= ND_B3( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B3( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B3( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B3=[maximo minimo_g minimo_n];
    
    % Mostramos en la UI los valores digitales de los tres colores
    set(handles.edit_calib_blanco_3,'String',handles.x1_B3(1));
    set(handles.edit_calib_gris_3,'String',handles.x1_B3(2));
    set(handles.edit_calib_negro_3,'String',handles.x1_B3(3));
    
        ND=double(imread(pathB4));
    ND_B4=ND(:,:,1);

    maximo= ND_B4( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B4( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B4( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B4=[maximo minimo_g minimo_n];
    
    % Mostramos en la UI los valores digitales de los tres colores
    set(handles.edit_calib_blanco_4,'String',handles.x1_B4(1));
    set(handles.edit_calib_gris_4,'String',handles.x1_B4(2));
    set(handles.edit_calib_negro_4,'String',handles.x1_B4(3));
    
    
        ND=double(imread(pathB5));
    ND_B5=ND(:,:,1);

    maximo= ND_B5( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B5( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B5( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B5=[maximo minimo_g minimo_n];
    
    % Mostramos en la UI los valores digitales de los tres colores
    set(handles.edit_calib_blanco_5,'String',handles.x1_B5(1));
    set(handles.edit_calib_gris_5,'String',handles.x1_B5(2));
    set(handles.edit_calib_negro_5,'String',handles.x1_B5(3));

end



%% Recogemos las opciones seleccionadas

handles.Master.valores=get(handles.popupmenu_valores_Master,'Value');
handles.B1.valores=get(handles.popupmenu_valores_1,'Value');
handles.B2.valores=get(handles.popupmenu_valores_2,'Value');
handles.B3.valores=get(handles.popupmenu_valores_3,'Value');
handles.B4.valores=get(handles.popupmenu_valores_4,'Value');
handles.B5.valores=get(handles.popupmenu_valores_5,'Value');

handles.Master.dentroIm=get(handles.radiobutton_dentro_imagen_Master,'Value');
handles.Master.fueraIm=get(handles.radiobutton_fuera_imagen_Master,'Value');
handles.B1.dentroIm=get(handles.radiobutton_dentro_imagen_1,'Value');
handles.B1.fueraIm=get(handles.radiobutton_fuera_imagen_1,'Value');
handles.B2.dentroIm=get(handles.radiobutton_dentro_imagen_2,'Value');
handles.B2.fueraIm=get(handles.radiobutton_fuera_imagen_2,'Value');
handles.B3.dentroIm=get(handles.radiobutton_dentro_imagen_3,'Value');
handles.B3.fueraIm=get(handles.radiobutton_fuera_imagen_3,'Value');
handles.B4.dentroIm=get(handles.radiobutton_dentro_imagen_4,'Value');
handles.B4.fueraIm=get(handles.radiobutton_fuera_imagen_4,'Value');
handles.B5.dentroIm=get(handles.radiobutton_dentro_imagen_5,'Value');
handles.B5.fueraIm=get(handles.radiobutton_fuera_imagen_5,'Value');

cmap_rgb_g=get(handles.radiobutton_RGB_Gris,'Value');
cmap_jet=get(handles.radiobutton_Jet,'Value');
cmap_rb=get(handles.radiobutton_Rainbow,'Value');

handles.Master.reflectancias(1)=str2double(get(handles.edit_ref_blanco_master,'String'));
handles.Master.reflectancias(2)=str2double(get(handles.edit_ref_gris_master,'String'));
handles.Master.reflectancias(3)=str2double(get(handles.edit_ref_negro_master,'String'));
handles.B1.reflectancias(1)=str2double(get(handles.edit_ref_blanco_1,'String'));
handles.B1.reflectancias(2)=str2double(get(handles.edit_ref_gris_1,'String'));
handles.B1.reflectancias(3)=str2double(get(handles.edit_ref_negro_1,'String'));
handles.B2.reflectancias(1)=str2double(get(handles.edit_ref_blanco_2,'String'));
handles.B2.reflectancias(2)=str2double(get(handles.edit_ref_gris_2,'String'));
handles.B2.reflectancias(3)=str2double(get(handles.edit_ref_negro_2,'String'));
handles.B3.reflectancias(1)=str2double(get(handles.edit_ref_blanco_3,'String'));
handles.B3.reflectancias(2)=str2double(get(handles.edit_ref_gris_3,'String'));
handles.B3.reflectancias(3)=str2double(get(handles.edit_ref_negro_3,'String'));
handles.B4.reflectancias(1)=str2double(get(handles.edit_ref_blanco_4,'String'));
handles.B4.reflectancias(2)=str2double(get(handles.edit_ref_gris_4,'String'));
handles.B4.reflectancias(3)=str2double(get(handles.edit_ref_negro_4,'String'));
handles.B5.reflectancias(1)=str2double(get(handles.edit_ref_blanco_5,'String'));
handles.B5.reflectancias(2)=str2double(get(handles.edit_ref_gris_5,'String'));
handles.B5.reflectancias(3)=str2double(get(handles.edit_ref_negro_5,'String'));

handles.Master.X1(1)=str2double(get(handles.edit_calib_blanco_master,'String'));
handles.Master.X1(2)=str2double(get(handles.edit_calib_gris_master,'String'));
handles.Master.X1(3)=str2double(get(handles.edit_calib_negro_master,'String'));
handles.B1.X1(1)=str2double(get(handles.edit_calib_blanco_1,'String'));
handles.B1.X1(2)=str2double(get(handles.edit_calib_gris_1,'String'));
handles.B1.X1(3)=str2double(get(handles.edit_calib_negro_1,'String'));
handles.B2.X1(1)=str2double(get(handles.edit_calib_blanco_2,'String'));
handles.B2.X1(2)=str2double(get(handles.edit_calib_gris_2,'String'));
handles.B2.X1(3)=str2double(get(handles.edit_calib_negro_2,'String'));
handles.B3.X1(1)=str2double(get(handles.edit_calib_blanco_3,'String'));
handles.B3.X1(2)=str2double(get(handles.edit_calib_gris_3,'String'));
handles.B3.X1(3)=str2double(get(handles.edit_calib_negro_3,'String'));
handles.B4.X1(1)=str2double(get(handles.edit_calib_blanco_4,'String'));
handles.B4.X1(2)=str2double(get(handles.edit_calib_gris_4,'String'));
handles.B4.X1(3)=str2double(get(handles.edit_calib_negro_4,'String'));
handles.B5.X1(1)=str2double(get(handles.edit_calib_blanco_5,'String'));
handles.B5.X1(2)=str2double(get(handles.edit_calib_gris_5,'String'));
handles.B5.X1(3)=str2double(get(handles.edit_calib_negro_5,'String'));

status_hist=get(handles.checkbox_hist,'Value');
status_cuad=get(handles.checkbox_cuadricula,'Value');

if status_cuad==0
    handles.cuad_div(1)=0;
    handles.cuad_div(2)=handles.cuad_div(1);
end

handles.Master.calib=[handles.Master.dentroIm handles.Master.fueraIm];
handles.B1.calib=[handles.B1.dentroIm handles.B1.fueraIm];
handles.B2.calib=[handles.B2.dentroIm handles.B2.fueraIm];
handles.B3.calib=[handles.B3.dentroIm handles.B3.fueraIm];
handles.B4.calib=[handles.B4.dentroIm handles.B4.fueraIm];
handles.B5.calib=[handles.B5.dentroIm handles.B5.fueraIm];
opcion_cmap=[cmap_rgb_g cmap_jet cmap_rb];

chkProceso=get(handles.chkProceso,'Value');
chkImagenes=get(handles.chkImagenes,'Value');


%% Se relacionan las bandas espectrales reales( R780, R670, etc...) con las de nuestra cámara(master, b1, etc..)
%Hay que redireccionar los canales a las bandas de la tetracam
listaOpcionesTetraCam=get(handles.pop_selecc_config,'String');

configTetracam=listaOpcionesTetraCam{get(handles.pop_selecc_config,'Value')};
switch configTetracam
    
    
    case 'Estandar'
                   R780=handles.Master;
                   R450=handles.B1;
                   R550=handles.B2;
                   R670=handles.B3;
                   R710=handles.B4;
                   R730=handles.B5;
                    
    case 'Hemav_1'
                   R780=handles.Master;
                   R450=handles.B1;
                   R550=handles.B2;
                   R670=handles.B3;
                   R710=handles.B4;
                   R730=handles.B5;
    case 'Hemav_2'
    
    otherwise
        
                     msgbox('Has seleccionado una configuración incorrecta','Cambio de configuración TetraCam');
                     return;
        
end

%% Se procesa por separado dependiendo del índice
paralelComp=get(handles.chkParalel,'Value');
indice=handles.opcionIndice;
switch indice
    case 1 %NDVI
                                    %% Buscamos el tamaño de los arrays de las imagenes de cada banda
                                    % Si no se ha seleccionado una
                                    % calibracion saldra error
                            if (R670.dentroIm==0 && R670.fueraIm==0 || R780.dentroIm==0 && R780.fueraIm==0)

                                        msgbox('Debes seleccionar un tipo de calibración para ambas bandas', 'Fallo en el programa');

                            else
                                            % Si el tamaño de cada pila de imágenes es la misma, se llama a la
                                            % función de cálculo del indice
                                        if size(R780.path)==size(R670.path)

                                        numImagenes= size(R780.path(1,:));
                                               
                                        %Llamamos al calculo del indice
                                        %para cada uno de las imagenes
                                            if paralelComp==0
                                                            tic
                                                            current_process=waitbar(0,'Procesando imágenes...');
                                                                    for i=1:numImagenes(2)     
                                                                        waitbar((i/numImagenes(2)),current_process,strcat('Procesando imagen ',num2str(i),' de ',num2str(numImagenes(2))))
                                                                        
                                                                        NDVI_Multibanda(R670,R780,i,chkImagenes,chkProceso,opcion_cmap,status_hist,status_cuad,handles.cuad_div,handles.rgb_g_limits,handles.auxiliar_limits,handles.status_suelo,handles.check_aux);
                                                                    end
                                                            close(current_process);
                                                            toc
                                            else 
                                                                tic                    
                                                                current_process=waitbar(0,'Procesando imágenes en paralelo');
                                                                    parfor i=1:numImagenes(2)     
                                                                       
                                                                        
                                                                        NDVI_Multibanda(R670,R780,i,chkImagenes,chkProceso,opcion_cmap,status_hist,status_cuad,handles.cuad_div,handles.rgb_g_limits,handles.auxiliar_limits,handles.status_suelo,handles.check_aux);
                                                                    end
                                                                close(current_process);
                                                            toc
                                            end
                                            
                                            
                                            
                                            
                                        else

                                           msgbox('El número de fotos para cada banda debe ser el mismo, por favor revisa los archivos seleccionados', 'Fallo en el programa');

                                        end
                           end

    case 2 %DCNI
                                    %% Buscamos el tamaño de los arrays de las imagenes de cada banda
                                    % Si no se ha seleccionado una calibracion saldra error
                            if ((R670.dentroIm==0 && R670.fueraIm==0) || (R730.dentroIm==0 && R730.fueraIm==0) || (R710.dentroIm==0 && R710.fueraIm==0))

                                        msgbox('Debes seleccionar un tipo de calibración para todas las bandas', 'Fallo en el programa');

                            else
                                            % Si el tamaño de cada pila de imágenes es la misma, se llama a la función de cálculo del indice
                                        if size(R730.path)==size(R710.path)

                                        numImagenes= size(R730.path(1,:));
                                               
                                        %Llamamos al calculo del indice
                                        %para cada uno de las imagenes
                                                if paralelComp==0
                                                    tic
                                                                current_process=waitbar(0,'Procesando imágenes...');
                                                                        for i=1:numImagenes(2)    
                                                                            waitbar((i/numImagenes(2)),current_process,strcat('Procesando imagen ',num2str(i),' de ',num2str(numImagenes(2))))

                                                                            DCNI_Multibanda(R730,R710,R670,i,chkImagenes,chkProceso,opcion_cmap,status_hist,status_cuad,handles.cuad_div,handles.rgb_g_limits,handles.auxiliar_limits,handles.status_suelo,handles.check_aux)
                                                                        end
                                                                close(current_process);
                                                    toc
                                                else
                                                    tic
                                                    current_process=waitbar(0,'Procesando imágenes en paralelo');
                                                                        parfor i=1:numImagenes(2)    
                                                                            
                                                                            DCNI_Multibanda(R730,R710,R670,i,chkImagenes,chkProceso,opcion_cmap,status_hist,status_cuad,handles.cuad_div,handles.rgb_g_limits,handles.auxiliar_limits,handles.status_suelo,handles.check_aux)
                                                                        end
                                                      close(current_process);
                                                    toc
                                                    
                                                end
                                        
                                        
                                        
                                        else

                                           msgbox('El número de fotos para cada banda debe ser el mismo, por favor revisa los archivos seleccionados', 'Fallo en el programa');

                                        end
                           end
            
    case 3 % TCARI/OSAVI
        
                                    %% Buscamos el tamaño de los arrays de las imagenes de cada banda
                                    % Si no se ha seleccionado una calibracion saldra error
                            if ((R670.dentroIm==0 && R670.fueraIm==0) || (R780.dentroIm==0 && R780.fueraIm==0) || (R710.dentroIm==0 && R710.fueraIm==0) || (R550.dentroIm==0 && R550.fueraIm==0))

                                        msgbox('Debes seleccionar un tipo de calibración para todas las bandas', 'Fallo en el programa');

                            else
                                            % Si el tamaño de cada pila de imágenes es la misma, se llama a la función de cálculo del indice
                                        if size(R670.path)==size(R780.path) % hay que arreglar esto! Comparar las 4 bandas no 2!

                                        numImagenes= size(R670.path(1,:));
                                               
                                        %Llamamos al calculo del indice
                                        %para cada uno de las imagenes
                                                if paralelComp==0
                                                    tic
                                                                    current_process=waitbar(0,'Procesando imágenes...');
                                                                            for i=1:numImagenes(2)    
                                                                                waitbar((i/numImagenes(2)),current_process,strcat('Procesando imagen ',num2str(i),' de ',num2str(numImagenes(2))))
                                                                                TCARI_OSAVI_Multibanda(R710,R670,R550,R780,i,chkImagenes,chkProceso,opcion_cmap,status_hist,status_cuad,handles.cuad_div,handles.rgb_g_limits,handles.auxiliar_limits,handles.status_suelo,handles.check_aux)
                                                                            end
                                                                    close(current_process);
                                                     toc
                                                else
                                                    tic
                                                    current_process=waitbar(0,'Procesando imágenes en paralelo');
                                                                            parfor i=1:numImagenes(2)    
                                                                                
                                                                                TCARI_OSAVI_Multibanda(R710,R670,R550,R780,i,chkImagenes,chkProceso,opcion_cmap,status_hist,status_cuad,handles.cuad_div,handles.rgb_g_limits,handles.auxiliar_limits,handles.status_suelo,handles.check_aux)
                                                                            end
                                                                    close(current_process);
                                                    toc
                                                end
                                        
                                        
                                        
                                        else

                                           msgbox('El número de fotos para cada banda debe ser el mismo, por favor revisa los archivos seleccionados', 'Fallo en el programa');

                                        end
                           end
        
    case 4 % PRI
    otherwise













end


% --- Executes on button press in chkProceso.
function chkProceso_Callback(hObject, eventdata, handles)
% hObject    handle to chkProceso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkProceso

guidata(hObject, handles);

% --- Executes on button press in chkImagenes.
function chkImagenes_Callback(hObject, eventdata, handles)



guidata(hObject, handles);



function edit_calib_blanco_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_blanco_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_gris_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_gris_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_negro_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_negro_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_blanco_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_master as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_master as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_blanco_master_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_gris_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_master as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_master as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_gris_master_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_negro_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_master as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_master as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_negro_master_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_blanco_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_blanco_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_blanco_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_blanco_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_gris_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_gris_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_gris_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_gris_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_negro_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_negro_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_negro_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_negro_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_blanco_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_blanco_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_gris_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_gris_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_negro_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_negro_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_blanco_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_blanco_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_blanco_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_blanco_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_gris_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_gris_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_gris_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_gris_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_negro_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_negro_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_negro_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_negro_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_blanco_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_blanco_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_gris_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_gris_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_negro_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_negro_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_valores_5.
function popupmenu_valores_5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valores_5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valores_5


% --- Executes during object creation, after setting all properties.
function popupmenu_valores_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_blanco_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_blanco_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_blanco_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_blanco_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_gris_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_gris_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_gris_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_gris_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_negro_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_negro_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_negro_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_negro_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_blanco_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_blanco_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_gris_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_gris_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_negro_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_negro_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_blanco_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_blanco_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_blanco_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_blanco_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_blanco_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_gris_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_gris_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_gris_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_gris_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_gris_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_negro_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_negro_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_negro_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_negro_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_negro_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_blanco_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_blanco_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_gris_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_gris_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_calib_negro_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_calib_negro_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_valores_3.
function popupmenu_valores_3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valores_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valores_3


% --- Executes during object creation, after setting all properties.
function popupmenu_valores_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on selection change in popupmenu_valores_4.
function popupmenu_valores_4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valores_4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valores_4


% --- Executes during object creation, after setting all properties.
function popupmenu_valores_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_valores_2.
function popupmenu_valores_2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valores_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valores_2


% --- Executes during object creation, after setting all properties.
function popupmenu_valores_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_valores_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_selecc_config.
function pop_selecc_config_Callback(hObject, eventdata, handles)



guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pop_selecc_config_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%matlabpool close;


% --- Executes on button press in chkParalel.
function chkParalel_Callback(hObject, eventdata, handles)
% hObject    handle to chkParalel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkParalel
guidata(hObject,handles);


function chkCalibSimple_Callback(hObject, eventdata, handles)


if (get(handles.chkCalibSimple,'Value')==1)
    set(handles.radiobutton_dentro_imagen_1,'Value',0);
    set(handles.radiobutton_fuera_imagen_1,'Value',1);
    set(handles.radiobutton_dentro_imagen_2,'Value',0);
    set(handles.radiobutton_fuera_imagen_2,'Value',1);
    set(handles.radiobutton_dentro_imagen_3,'Value',0);
    set(handles.radiobutton_fuera_imagen_3,'Value',1);
    set(handles.radiobutton_dentro_imagen_4,'Value',0);
    set(handles.radiobutton_fuera_imagen_4,'Value',1);
    set(handles.radiobutton_dentro_imagen_5,'Value',0);
    set(handles.radiobutton_fuera_imagen_5,'Value',1);

else
    
    set(handles.radiobutton_dentro_imagen_1,'Value',0);
    set(handles.radiobutton_fuera_imagen_1,'Value',0);
    set(handles.radiobutton_dentro_imagen_2,'Value',0);
    set(handles.radiobutton_fuera_imagen_2,'Value',0);
    set(handles.radiobutton_dentro_imagen_3,'Value',0);
    set(handles.radiobutton_fuera_imagen_3,'Value',0);
    set(handles.radiobutton_dentro_imagen_4,'Value',0);
    set(handles.radiobutton_fuera_imagen_4,'Value',0);
    set(handles.radiobutton_dentro_imagen_5,'Value',0);
    set(handles.radiobutton_fuera_imagen_5,'Value',0);
    
    
    
    
    
    
    
    % si ya tiene valores de calibración la dejamos con la opción que
    % tenían
    
    if isempty(handles.x1_B1)==0 
        
        if handles.x1_B1(1)~=0
        set(handles.radiobutton_fuera_imagen_1,'Value',1);
        else
            set(handles.radiobutton_dentro_imagen_1,'Value',1);
        end
    end
    
     if isempty(handles.x1_B2)==0 
        
        if handles.x1_B2(1)~=0
        set(handles.radiobutton_fuera_imagen_2,'Value',1);
        else
            set(handles.radiobutton_dentro_imagen_2,'Value',1);
        end
     end
    
      if isempty(handles.x1_B3)==0 
        
        if handles.x1_B3(1)~=0
        set(handles.radiobutton_fuera_imagen_3,'Value',1);
        else
            set(handles.radiobutton_dentro_imagen_3,'Value',1);
        end
      end
    
       if isempty(handles.x1_B4)==0 
        
        if handles.x1_B4(1)~=0
        set(handles.radiobutton_fuera_imagen_4,'Value',1);
        else
            set(handles.radiobutton_dentro_imagen_4,'Value',1);
        end
       end
    
        if isempty(handles.x1_B5)==0 
        
        if handles.x1_B5(1)~=0
        set(handles.radiobutton_fuera_imagen_5,'Value',1);
        else
            set(handles.radiobutton_dentro_imagen_5,'Value',1);
        end
    end
    
    
end




guidata(hObject,handles);
