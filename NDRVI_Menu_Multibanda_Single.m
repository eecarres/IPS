function varargout = NDRVI_Menu_Multibanda_Single(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_Menu_Multibanda_Single_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_Menu_Multibanda_Single_OutputFcn, ...
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



% --- Executes just before NDRVI_Menu_Multibanda_Single is made visible.
function NDRVI_Menu_Multibanda_Single_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

%%  Cargamos el nombre del programa
global program_name;
set(handles.title,'string',program_name);
%% Gestion proyectos

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
    load ('ultimoProyecto','pathProyecto','indiceProyecto','referenciasCalibracion');
    handles.pathProyecto=pathProyecto;
    handles.indiceProyecto=indiceProyecto;
end



%% Generamos las 6 bandas del programa
handles.Master=Banda;
handles.Master.id=1;
handles.B1=Banda;
handles.B1.id=2;
handles.B2=Banda;   
handles.B2.id=3;
handles.B3=Banda;
handles.B3.id=4;
handles.B4=Banda;
handles.B4.id=5;
handles.B5=Banda;
handles.B5.id=6;

%% Ponemos a 0 los radiobuttons
set(handles.rdbDentroIm,'value',0);
set(handles.rdbFueraIm,'value',0);

%% Inicializa los valores de las reflectancias de cada Banda presentes en la DB
[Master_db,IR_db_text]=xlsread('c\..\DB_folder\Multibanda_db.xlsx',1); 
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
set(handles.popMaster,'string',str_list_Master);
set(handles.popB1,'string',str_list_B1);
set(handles.popB2,'string',str_list_B2);
set(handles.popB3,'string',str_list_B3);
set(handles.popB4,'string',str_list_B4);
set(handles.popB5,'string',str_list_B5);


%% Guardamos en handles los valores
handles.Master.database=Master_db;
handles.B1.database=B1_db;
handles.B2.database=B2_db;
handles.B3.database=B3_db;
handles.B4.database=B4_db;
handles.B5.database=B5_db;


clear IR_db IR_db_size IR_db_text R_db R_db_size R_db_text

%% Indice elegido por defecto NDVI

handles.opcionIndice=1;

%% Cargamos las configuraciones de reflectancias desde el Excel de la base de datos:
[~,configuracionesReflectancias]=xlsfinfo('DB_folder/Configuracion_Reflectancias_DB.xlsx');

set(handles.popReflectancias,'String',configuracionesReflectancias);

%% Establecemos los valores de las reflectancias de cada banda (primero se cargan las anteriores y si no es posible las est�ndar)

try
    set(handles.edit_ref_blanco_master,'String',num2str(referenciasCalibracion(1)));
set(handles.edit_ref_gris_master,'String',num2str(referenciasCalibracion(2)));
set(handles.edit_ref_negro_master,'String',num2str(referenciasCalibracion(3)));

set(handles.edit_ref_blanco_1,'String',num2str(referenciasCalibracion(4)));
set(handles.edit_ref_gris_1,'String',num2str(referenciasCalibracion(5)));
set(handles.edit_ref_negro_1,'String',num2str(referenciasCalibracion(6)));

set(handles.edit_ref_blanco_2,'String',num2str(referenciasCalibracion(7)));
set(handles.edit_ref_gris_2,'String',num2str(referenciasCalibracion(8)));
set(handles.edit_ref_negro_2,'String',num2str(referenciasCalibracion(9)));

set(handles.edit_ref_blanco_3,'String',num2str(referenciasCalibracion(10)));
set(handles.edit_ref_gris_3,'String',num2str(referenciasCalibracion(11)));
set(handles.edit_ref_negro_3,'String',num2str(referenciasCalibracion(12)));

set(handles.edit_ref_blanco_4,'String',num2str(referenciasCalibracion(13)));
set(handles.edit_ref_gris_4,'String',num2str(referenciasCalibracion(14)));
set(handles.edit_ref_negro_4,'String',num2str(referenciasCalibracion(15)));

set(handles.edit_ref_blanco_5,'String',num2str(referenciasCalibracion(16)));
set(handles.edit_ref_gris_5,'String',num2str(referenciasCalibracion(17)));
set(handles.edit_ref_negro_5,'String',num2str(referenciasCalibracion(18)));

catch
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

end


guidata(hObject, handles);


% --- Executes when selected object is changed in panCalib.
function panCalib_SelectionChangeFcn(hObject, eventdata, handles)

fueraIm=get(handles.rdbFueraIm,'Value');

%% si es 0 es dentro de imagen y 1 es fuera imagen
if fueraIm==1
    
    
    
    
    % si es calibracion simple se sigue el procedimiento est�ndar:
    % guardamos X e Y de la primera imagen y luego evaluamos las otras
    % bandas con esas coordenadas
if get(handles.chkCalibSimple,'Value')==1
    %% Calibraci�n Master
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*.*'},'Selecciona imagen calibraci�n de 6 bandas',strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/6 bandes'));
    %% Leemos la imagen y nos quedamos solo con el canal que nos interesa (Tiff tiene 3 canales iguales aunque sea monocroma)
    
    ND=uint16(imread(strcat(Im_PathName,Im_Name)));
    
    tamanoImagen=size(ND);
    if tamanoImagen(3) == 6
        ND_Master=ND(:,:,1);
    ND_B1=ND(:,:,2);
    ND_B2=ND(:,:,3);
    ND_B3=ND(:,:,4);
    ND_B4=ND(:,:,5);
    ND_B5=ND(:,:,6);
    else
        msgbox('Las im�genes deben ser Tif de 6 bandas','Error en el programa');
        return;
    end 
    %% Obtenemos el m�ximo y el m�nimo y hacemos el stretching
    minimo(6)=min(min(ND_Master)); %% Doble min pq es matriz
    maximo(6)=max(max(ND_Master)); %% Doble max pq es matriz
    minimo(1)=min(min(ND_B1)); 
    maximo(1)=max(max(ND_B1));
    minimo(2)=min(min(ND_B2)); 
    maximo(2)=max(max(ND_B2));
    minimo(3)=min(min(ND_B3)); 
    maximo(3)=max(max(ND_B3));
    minimo(4)=min(min(ND_B4)); 
    maximo(4)=max(max(ND_B4));
    minimo(5)=min(min(ND_B5)); 
    maximo(5)=max(max(ND_B5));
    
    
    minimoTotal=min(minimo);
    maximoTotal=max(maximo);
    
    ima1=figure;
    imshow(ND_Master);
    caxis([ minimoTotal maximoTotal]);
    title('Marcar primero blanco, luego gris y finalmente negro');
    colorbar;
    [x,y]= ginput(3);
    
    %% Guardamos los valores digitales de los puntos para luego mostrarlos en la UI
    maximo= ND_Master( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_Master( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_Master( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_Master=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n
    
    maximo= ND_B1( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B1( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B1( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B1=[maximo minimo_g minimo_n];
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n 
    
    maximo= ND_B2( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B2( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B2( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B2=[maximo minimo_g minimo_n];
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n 
    
    maximo= ND_B3( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B3( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B3( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B3=[maximo minimo_g minimo_n];
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n 
    
    maximo= ND_B4( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B4( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B4( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B4=[maximo minimo_g minimo_n];
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n 
    
    maximo= ND_B5( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_B5( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_B5( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_B5=[maximo minimo_g minimo_n];
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n x 


else % Si se quiere seleccionar banda por banda


    % Calibraci�n Master
    [Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*.*'},'Selecciona imagen calibraci�n',strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/6 bandes'));;
    % Leemos la imagen y nos quedamos solo con el canal que nos interesa (Tiff tiene 3 canales iguales aunque sea monocroma)
    ND=uint16(imread(strcat(Im_PathName,Im_Name)));
    
    tamanoImagen=size(ND);
    if tamanoImagen(3) == 6
    ND_Master=ND(:,:,1);
    ND_B1=ND(:,:,2);
    ND_B2=ND(:,:,3);
    ND_B3=ND(:,:,4);
    ND_B4=ND(:,:,5);
    ND_B5=ND(:,:,6);
    else
        msgbox('Las im�genes deben ser Tif de 6 bandas','Error en el programa');
        return;
    end
    
    % Master
    
    % Obtenemos el m�ximo y el m�nimo y hacemos el stretching
    minimo1=min(min(ND_Master)); %% Doble min pq es matriz
    maximo1=max(max(ND_Master)); %% Doble max pq es matriz
    ima1=figure;
    imshow(ND_Master);
    caxis([ minimo1 maximo1]);
    title('Marcar primero blanco, luego gris y finalmente negro (banda Master)');
    colorbar;
    [x,y]= ginput(3);
      
    %% Guardamos los valores digitales de los puntos para luego mostrarlos en la UI
    maximo= ND_Master( round(y(1,1)) , round(x(1,1)) );  %blanco
    minimo_g= ND_Master( round(y(2,1)) , round(x(2,1)) );  %negro/gris
    minimo_n= ND_Master( round(y(3,1)) , round(x(3,1)) );  %negro/gris
    handles.x1_Master=[maximo minimo_g minimo_n];
    close(ima1);
    clear Im_PathName Im_Name ND ND_IR minimo1 maximo1 ima1 maximo minimo_g minimo_n x y


    % Banda 1

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
    
    
    % Banda 2
    
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

    
    % Banda 3
    
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

    
    %Banda 4
    
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

    
    % Banda 5
    
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

end 
    
else
    %% Si es dentro de imagen se colocan como 0 los valores digitales de negro blanco y gris
    handles.x1_Master(1)=0; handles.x1_Master(2)=handles.x1_Master(1); handles.x1_Master(3)=handles.x1_Master(1);
end
%% Mostramos en la UI los valores digitales de los tres colores
set(handles.edit_calib_blanco_master,'String',handles.x1_Master(1));
set(handles.edit_calib_gris_master,'String',handles.x1_Master(2));
set(handles.edit_calib_negro_master,'String',handles.x1_Master(3));

set(handles.edit_calib_blanco_1,'String',handles.x1_B1(1));
set(handles.edit_calib_gris_1,'String',handles.x1_B1(2));
set(handles.edit_calib_negro_1,'String',handles.x1_B1(3));

set(handles.edit_calib_blanco_2,'String',handles.x1_B2(1));
set(handles.edit_calib_gris_2,'String',handles.x1_B2(2));
set(handles.edit_calib_negro_2,'String',handles.x1_B2(3));

set(handles.edit_calib_blanco_3,'String',handles.x1_B3(1));
set(handles.edit_calib_gris_3,'String',handles.x1_B3(2));
set(handles.edit_calib_negro_3,'String',handles.x1_B3(3));

set(handles.edit_calib_blanco_4,'String',handles.x1_B4(1));
set(handles.edit_calib_gris_4,'String',handles.x1_B4(2));
set(handles.edit_calib_negro_4,'String',handles.x1_B4(3));

set(handles.edit_calib_blanco_5,'String',handles.x1_B5(1));
set(handles.edit_calib_gris_5,'String',handles.x1_B5(2));
set(handles.edit_calib_negro_5,'String',handles.x1_B5(3));


guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_Menu_Multibanda_Single_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in btnProcesa.
function btnProcesa_Callback(hObject, eventdata, handles)

% Se guardan en los objetos Banda los valores de configuraci�n escogidos
% por el usuario
handles.Master.valores=get(handles.popMaster,'Value');
handles.B1.valores=get(handles.popB1,'Value');
handles.B2.valores=get(handles.popB2,'Value');
handles.B3.valores=get(handles.popB3,'Value');
handles.B4.valores=get(handles.popB4,'Value');
handles.B5.valores=get(handles.popB5,'Value');

handles.Master.dentroIm=get(handles.rdbDentroIm,'Value');
handles.Master.fueraIm=get(handles.rdbFueraIm,'Value');

handles.Master.calib=[handles.Master.dentroIm handles.Master.fueraIm];
handles.B1.calib=[handles.Master.dentroIm handles.Master.fueraIm];
handles.B2.calib=[handles.Master.dentroIm handles.Master.fueraIm];
handles.B3.calib=[handles.Master.dentroIm handles.Master.fueraIm];
handles.B4.calib=[handles.Master.dentroIm handles.Master.fueraIm];
handles.B5.calib=[handles.Master.dentroIm handles.Master.fueraIm];




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






chkProceso=get(handles.chkProceso,'Value');
chkImagenes=get(handles.chkImagenes,'Value');

%% Iniciamos todas las bandas como un objeto nulo para reconocer si las tenemos en la configuraci�n actual o no;

R420=[];
R450=[];
R530=[];
R550=[];
R570=[];
R670=[];
R700=[];
R710=[];
R720=[];
R730=[];
R780=[];
R800=[];
R910=[];
R950=[];

% Se guardan las �ltimas configuraciones de reflectancias empleadas
referenciasCalibracion=[handles.Master.reflectancias handles.B1.reflectancias handles.B2.reflectancias handles.B3.reflectancias handles.B4.reflectancias handles.B5.reflectancias];
pathProyecto=handles.pathProyecto;
indiceProyecto=handles.indiceProyecto;
save ('ultimoProyecto', 'referenciasCalibracion', 'pathProyecto','indiceProyecto');



%% Aqui se definen las configuraciones disponibles de TetraCam. VectorOrden tiene que decir que banda es cual si las ordenamos de menos a mas LDO, 
%% y bandasProyecto es un simple vector que  contiene todos los objetos banda para poder emplearlos luego (tienen que
%% estar ordenados o dar� fallos)

configTetracam=get(handles.lblConfig,'String');
switch configTetracam
                   
    case 'Estandar (ilerdair)'
                   R780=handles.Master;
                   R780.banda=780;
                   
                   R450=handles.B1;
                   R450.banda=450;
                   
                   R550=handles.B2;
                   R550.banda=550;
                   
                   R670=handles.B3;
                   R670.banda=670;
                   
                   R710=handles.B4;
                   R710.banda=710;
                   
                   R730=handles.B5;
                   R730.banda=730;
                    
                   vectorOrden=[2 3 4 5 6 1];
                   bandasProyecto=[R450 R550 R670 R710 R730 R780];
                   
    case 'RGBN Pruebas'
                   R780=handles.Master;
                   R780.banda=780;
                   
                   R450=handles.B1;
                   R450.banda=450;
                   
                   R550=handles.B2;
                   R550.banda=550;
                   
                   R670=handles.B3;
                   R670.banda=670;
                   
                   R710=handles.B4;
                   R710.banda=710;
                   
                   R800=handles.B5;
                   R800.banda=800;
                    
                   vectorOrden=[2 3 4 5 6 1];
                   bandasProyecto=[R450 R550 R670 R710 R800 R780];
                   
    case 'Config 1 Algerri'
                   R800=handles.Master;
                   R800.banda=800;
                   
                   R450=handles.B1;
                   R450.banda=450;
                   
                   R550=handles.B2;
                   R550.banda=550;
                   
                   R670=handles.B3;
                   R670.banda=670;
                   
                   R710=handles.B4;
                   R710.banda=710;
                   
                   R720=handles.B5;
                   R720.banda=720;
                   
                   vectorOrden=[2 3 4 5 6 1];
                   bandasProyecto=[R450 R550 R670 R710 R720 R800];
                   
    case 'Config 2 Algerri'
                   R780=handles.Master;
                   R780.banda=780;
                   
                   R530=handles.B1;
                   R530.banda=530;
                   
                   R570=handles.B2;
                   R570.banda=570;
                   
                   R670=handles.B3;
                   R670.banda=670;
                   
                   R710=handles.B4;
                   R710.banda=710;
                   
                   R730=handles.B5;  
                   R730.banda=730;
                   
                   vectorOrden=[2 3 4 5 6 1];
                   bandasProyecto=[R530 R570 R670 R710 R730 R780];
                   
                   case 'AB F2 C1'
                   R800=handles.Master;
                   R800.banda=800;
                   
                   R450=handles.B1;
                   R450.banda=450;
                   
                   R550=handles.B2;
                   R550.banda=550;
                   
                   R670=handles.B3;
                   R670.banda=670;
                   
                   R700=handles.B4;
                   R700.banda=700;
                   
                   R730=handles.B5;  
                   R730.banda=730;
                   
                   vectorOrden=[2 3 4 5 6 1];
                   bandasProyecto=[R450 R550 R670 R700 R730 R800];
                   
                   
                   case 'AB F2 C2'
                   R780=handles.Master;
                   R780.banda=780;
                   
                   R530=handles.B1;
                   R530.banda=530;
                   
                   R570=handles.B2;
                   R570.banda=570;
                   
                   R670=handles.B3;
                   R670.banda=670;
                   
                   R720=handles.B4;
                   R720.banda=720;
                   
                   R950=handles.B5;  
                   R950.banda=950;
                   
                   vectorOrden=[2 3 4 5 1 6];
                   bandasProyecto=[R530 R570 R670 R720 R780 R950];
                   
    otherwise
        
                     msgbox('Has seleccionado una configuraci�n incorrecta. Comprueba que se haya a�adido al Excel y al c�digo','Cambio de configuraci�n TetraCam');
                     return;
        
end


Bandas=handles.bandas;




%Creamos el archivo de guardado para el generado del informe
[direccion,nombreProyecto]=strtok(handles.pathProyecto,'/');
[direccion,nombreProyecto]=strtok(nombreProyecto,'/');
nombreProyecto=nombreProyecto(2:end);
save([handles.pathProyecto,'/Informe/',nombreProyecto,'.mat'],'configTetracam','bandasProyecto','Bandas','vectorOrden');



%% Iniciamos el informe de postprocesado

fileID = fopen(strcat(handles.pathProyecto,'/Procesadas/Multi/','Informe de postprocesado.txt'),'w');
fprintf(fileID,'%s \r\n',strcat('Directorio del proyecto: ',handles.pathProyecto));
fprintf(fileID,'%s \r\n','---------------------------------------------------------------');
fprintf(fileID,'%s \r\n',['Fecha: ',datestr(now)]);
fprintf(fileID,'%s \r\n','---------------------------------------------------------------');
fprintf(fileID,'%s \r\n',['Configuraci�n de los filtros TetraCam: ',configTetracam]);
fprintf(fileID,'%s \r\n','---------------------------------------------------------------');
fprintf(fileID,'%s \r\n','Mapa de la configuraci�n ( de m�ster a banda 5):');
fprintf(fileID,'%s \r\n',char(Bandas(1)));
fprintf(fileID,'%s \r\n',char(Bandas(2)));
fprintf(fileID,'%s \r\n',char(Bandas(3)));
fprintf(fileID,'%s \r\n',char(Bandas(4)));
fprintf(fileID,'%s \r\n',char(Bandas(5)));
fprintf(fileID,'%s \r\n',char(Bandas(6)));
fprintf(fileID,'%s \r\n','---------------------------------------------------------------');
fprintf(fileID,'%s \r\n','Datos de calibraci�n de cada banda [reflectancia / valor digital]');
fprintf(fileID,'%s \r\n',['Banda M�ster (',char(Bandas(1)),'):']);
fprintf(fileID,'%s \r\n',['         Blanco:',num2str(handles.Master.reflectancias(1)),' / ',num2str(handles.Master.X1(1))]);
fprintf(fileID,'%s \r\n',['         Gris:',num2str(handles.Master.reflectancias(2)),' / ',num2str(handles.Master.X1(2))]);
fprintf(fileID,'%s \r\n',['         Negro:',num2str(handles.Master.reflectancias(3)),' / ',num2str(handles.Master.X1(3))]);
fprintf(fileID,'%s \r\n',['Banda 1 (',char(Bandas(2)),'):']);
fprintf(fileID,'%s \r\n',['         Blanco:',num2str(handles.B1.reflectancias(1)),' / ',num2str(handles.B1.X1(1))]);
fprintf(fileID,'%s \r\n',['         Gris:',num2str(handles.B1.reflectancias(2)),' / ',num2str(handles.B1.X1(2))]);
fprintf(fileID,'%s \r\n',['         Negro:',num2str(handles.B1.reflectancias(3)),' / ',num2str(handles.B1.X1(3))]);
fprintf(fileID,'%s \r\n',['Banda 2 (',char(Bandas(3)),'):']);
fprintf(fileID,'%s \r\n',['         Blanco:',num2str(handles.B2.reflectancias(1)),' / ',num2str(handles.B2.X1(1))]);
fprintf(fileID,'%s \r\n',['         Gris:',num2str(handles.B2.reflectancias(2)),' / ',num2str(handles.B2.X1(2))]);
fprintf(fileID,'%s \r\n',['         Negro:',num2str(handles.B2.reflectancias(3)),' / ',num2str(handles.B2.X1(3))]);
fprintf(fileID,'%s \r\n',['Banda 3 (',char(Bandas(4)),'):']);
fprintf(fileID,'%s \r\n',['         Blanco:',num2str(handles.B3.reflectancias(1)),' / ',num2str(handles.B3.X1(1))]);
fprintf(fileID,'%s \r\n',['         Gris:',num2str(handles.B3.reflectancias(2)),' / ',num2str(handles.B3.X1(2))]);
fprintf(fileID,'%s \r\n',['         Negro:',num2str(handles.B3.reflectancias(3)),' / ',num2str(handles.B3.X1(3))]);
fprintf(fileID,'%s \r\n',['Banda 4 (',char(Bandas(5)),'):']);
fprintf(fileID,'%s \r\n',['         Blanco:',num2str(handles.B4.reflectancias(1)),' / ',num2str(handles.B4.X1(1))]);
fprintf(fileID,'%s \r\n',['         Gris:',num2str(handles.B4.reflectancias(2)),' / ',num2str(handles.B4.X1(2))]);
fprintf(fileID,'%s \r\n',['         Negro:',num2str(handles.B4.reflectancias(3)),' / ',num2str(handles.B4.X1(3))]);
fprintf(fileID,'%s \r\n',['Banda 5 (',char(Bandas(6)),'):']);
fprintf(fileID,'%s \r\n',['         Blanco:',num2str(handles.B5.reflectancias(1)),' / ',num2str(handles.B5.X1(1))]);
fprintf(fileID,'%s \r\n',['         Gris:',num2str(handles.B5.reflectancias(2)),' / ',num2str(handles.B5.X1(2))]);
fprintf(fileID,'%s \r\n',['         Negro:',num2str(handles.B5.reflectancias(3)),' / ',num2str(handles.B5.X1(3))]);
fprintf(fileID,'%s \r\n','---------------------------------------------------------------');
fprintf(fileID,'%s \r\n','Indices calculados y Rango correspondiente: ');

%% Calculo Indices seleccionados
if get(handles.rdbDentroIm,'Value')==0 && get(handles.rdbFueraIm,'Value')==0

msgbox('Debes calibrar primero las bandas espectrales','Fallo en el programa')

else
    % Se cargan los tiff de uno en uno y se llama a las funciones
    numImagenes=size(handles.MultiPath);
    current_process=waitbar(0,'Procesando im�genes...');
    
    tic 
    for i=1:numImagenes(2) 
        
      TiffActual = Tiff(char(handles.MultiPath(1,i)),'r+');
      [~,nombreIm, ~] = fileparts(char(handles.MultiPath(1,i)));
      dataImOriginal=TiffActual.read();
      tamanoIm=size(dataImOriginal);
      numBandas=tamanoIm(3);
      
     % Pasar todas las bandas a LK y guardar sus LK's;
     
      for j=1:numel(bandasProyecto)
          
          bandasProyecto(j).LK=LK_Banda(bandasProyecto(j),dataImOriginal( : , : , vectorOrden(j) )) ;% Calculo de LK con las opciones de la banda y los datos originales de la imagen
          
           dataImProcesada(:,:,j)=uint16(bandasProyecto(j).LK*(2^16));

           if i==1
                        maxBanda=max(max(dataImProcesada(:,:,j)));
                        minBanda=min(min(dataImProcesada(:,:,j)));
                         fprintf(fileID,'%s \r\n',['Banda n�mero ',num2str(j),': R',num2str(bandasProyecto(j).banda),'   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
          end
           
      end
    if get(handles.chkComprobacion,'Value')  
      %Mostramos las im�genes
      figure('Name',['Imagen numero ',num2str(i)]);
          subplot(2,3,1);
          imshow(dataImProcesada(:,:,1));
                    subplot(2,3,2);
          imshow(dataImProcesada(:,:,2));
                    subplot(2,3,3);
          imshow(dataImProcesada(:,:,3));
                    subplot(2,3,4);
          imshow(dataImProcesada(:,:,4));
                    subplot(2,3,5);
          imshow(dataImProcesada(:,:,5));
                    subplot(2,3,6);
          imshow(dataImProcesada(:,:,6));
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
        
 
      set(0, 'CurrentFigure', current_process); 
      
    end
    
    
         waitbar((i/numImagenes(2)),current_process,['Procesando imagen ',num2str(i),' de ',num2str(numImagenes(2))])
         
%          % A�adimos capa Stretching
%             if get(handles.chkComprobacion,'Value')==1    
%              numBandas=numBandas+1;   
%                                if i==1
%                         fprintf(fileID,'%s \r\n',['Banda n�mero',' ','1',': Banda con Stretching']);
%                                end
%             bandaStretching=get(handles.numStretching,'Value');
%             
%             bandaNueva=dataImOriginal(:,:,bandaStretching);
%             minBanda=min(min(bandaNueva));
%             maxBanda=max(max(bandaNueva));
%             bandaNueva=bandaNueva-minBanda;
%             bandaNueva=((2^16)/(maxBanda-minBanda))*bandaNueva;
%             dataImProcesada(:,:,1)=bandaNueva;
%             dataImProcesada(:,:,2)=dataImOriginal(:,:,vectorOrden(1));
%             dataImProcesada(:,:,3)=dataImOriginal(:,:,vectorOrden(2));
%             dataImProcesada(:,:,4)=dataImOriginal(:,:,vectorOrden(3));
%             dataImProcesada(:,:,5)=dataImOriginal(:,:,vectorOrden(4));
%             dataImProcesada(:,:,6)=dataImOriginal(:,:,vectorOrden(5));
%             dataImProcesada(:,:,7)=dataImOriginal(:,:,vectorOrden(6));
%             end 
         
         
         
         
         % Calculamos NDVI 800 si se ha seleccionado la opci�n
            if get(handles.chkNDVI800,'Value')==1   
                                 if isempty(R670) || isempty(R800) 
                                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice NDVI');
                                    return;
                                else
                                          NDVI_Actual=NDVI_BandaConLK(R670,R800,i,chkImagenes,chkProceso );                 
                                            numBandas=numBandas+1;
                                             dataImProcesada(:,:,numBandas)=NDVI_Actual*1000;
                                                         if i==1
                                                             maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                                        fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': NDVI - 800','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                                         end
                                 end
            end    
            % Calculamos NDVI 780 si se ha seleccionado la opci�n
            if get(handles.chkNDVI780,'Value')==1   
                                 if isempty(R670) || isempty(R780) 
                                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice NDVI');
                                    return;
                                else
                                          NDVI_Actual=NDVI_BandaConLK(R670,R780,i,chkImagenes,chkProceso );                 
                                            numBandas=numBandas+1;
                                             dataImProcesada(:,:,numBandas)=NDVI_Actual*1000;
                                                         if i==1
                                                            maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                                        fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': NDVI - 780','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                                         end
                                 end
            end 
            
            % Calculamos DCNI si se ha seleccionado la opci�n
            if get(handles.chkDCNI,'Value')==1              
                                    if isempty(R730) || isempty(R700) || isempty(R670)
                                                        msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice DCNI');
                                                        return;
                                    else
                                        DCNI_Actual=DCNI_BandaConLK(R730,R700,R670,i,chkImagenes,chkProceso );                 
                                        numBandas=numBandas+1;
                                        dataImProcesada(:,:,numBandas)=DCNI_Actual*1000;
                                                    if i==1
                                                        maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': DCNI','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                                    end
                                    end
            end  
            
            % Calculamos TCARI si se ha seleccionado la opci�n
            if get(handles.chkTCARI,'Value')==1     
                                if isempty(R710) || isempty(R670) || isempty(R550) || isempty(R780)
                                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice TCARI');
                                    return;
                                else
                                       TCARI_Actual=TCARI_OSAVI_BandaConLK(R710,R670,R550,R780,i,chkImagenes,chkProceso );                 
                                        numBandas=numBandas+1;
                                        dataImProcesada(:,:,numBandas)=TCARI_Actual*1000;
                                                       if i==1
                                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': TCARI','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                                       end
                                end
            end
            
            % Calculamos PRI si se ha seleccionado la opci�n
            if get(handles.chkPRI,'Value')==1       
                if isempty(R530) || isempty(R570)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice PRI');
                    return;
                else
                        PRI_Actual=PRI_BandaConLK(R530,R570,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(PRI_Actual+1)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': PRI','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            % Calculamos MCARI si se ha seleccionado la opci�n
            if get(handles.chkMCARI,'Value')==1       
                if isempty(R550) || isempty(R670) || isempty(R700)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice MCARI');
                    return;
                else
                        MCARI=MCARI_BandaConLK(R550,R670,R700,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(MCARI)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': MCARI','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            % Calculamos MCARI2 si se ha seleccionado la opci�n
            if get(handles.chkMCARI2,'Value')==1       
                if isempty(R550) || isempty(R670) || isempty(R800)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice MCARI2');
                    return;
                else
                        MCARI2=MCARI2_BandaConLK(R550,R670,R800,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(MCARI2)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': MCARI2','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            % Calculamos TVI si se ha seleccionado la opci�n %% SE ESTA
            % CAMBIANDO EL PROGRAMA PARA QUE PUEDA USARSE CON R730!!!!
            if get(handles.chkTVI,'Value')==1       
                if isempty(R550) || isempty(R670) || isempty(R730)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice TVI');
                    return;
                else
                        TVI=TVI_BandaConLK(R550,R670,R730,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(TVI)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': TVI','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            % Calculamos MTVI2 si se ha seleccionado la opci�n
            if get(handles.chkMTVI2,'Value')==1       
                if isempty(R550) || isempty(R670) || isempty(R800)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice MTVI2');
                    return;
                else
                        MTVI2=MTVI2_BandaConLK(R550,R670,R800,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(MTVI2)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': MTVI2','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
      
            
            % Calculamos NTest1 si se ha seleccionado la opci�n
            if get(handles.chkNTest1,'Value')==1       
                if isempty(R670) || isempty(R950)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice Ntest1');
                    return;
                else
                        Ntest1=NTest1_BandaConLK(R670,R950,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(Ntest1)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': Ntest1','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            
            % Calculamos Ntest2 si se ha seleccionado la opci�n
            if get(handles.chkNTest2,'Value')==1       
                if  isempty(R670) || isempty(R950)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice Ntest2');
                    return;
                else
                        Ntest2=NTest2_BandaConLK(R670,R950,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(Ntest2)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': Ntest2','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            
            % Calculamos FB1 si se ha seleccionado la opci�n
            if get(handles.chkFB1,'Value')==1       
                if  isempty(R670) || isempty(R730) || isempty(R550)  || isempty(R450)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice FB1 Hemav');
                    return;
                else
                        FB1=FB1_BandaConLK(R670,R730,R550,R450,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(FB1)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': FB1 Hemav','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            % Calculamos FB2 si se ha seleccionado la opci�n
            if get(handles.chkFB2,'Value')==1       
                if  isempty(R670) || isempty(R780) || isempty(R550)  || isempty(R450)
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice FB2 Hemav');
                    return;
                else
                        FB2=FB2_BandaConLK(R670,R780,R550,R450,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(FB2)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': FB2 Hemav','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            
            % Calculamos PCD 780 si se ha seleccionado la opci�n
            if get(handles.chkPCD780,'Value')==1       
                if  isempty(R670) || isempty(R780) 
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice PCD 780 Hemav');
                    return;
                else
                        PCD780=PCD_BandaConLK(R670,R780,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(PCD780)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': PCD 780 Hemav','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
            
            % Calculamos PCD 800 si se ha seleccionado la opci�n
            if get(handles.chkPCD800,'Value')==1       
                if  isempty(R670) || isempty(R800) 
                    msgbox('No hay informaci�n suficiente para calcular el �ndice: Comprueba las bandas de entrada','Error calculando �ndice PCD 800 Hemav');
                    return;
                else
                        PCD800=PCD_BandaConLK(R670,R800,i,chkImagenes,chkProceso );                 
                        numBandas=numBandas+1;
                        dataImProcesada(:,:,numBandas)=(PCD800)*1000;
                                       if i==1
                                           maxBanda=max(max(dataImProcesada(:,:,numBandas)));
                                                             minBanda=min(min(dataImProcesada(:,:,numBandas)));
                                    fprintf(fileID,'%s \r\n',['Banda n�mero',' ',num2str(numBandas),': PCD 800 Hemav','   Rango:(',num2str(maxBanda),' - ',num2str(minBanda),')']);
                                       end
                end
            end
             
         
          
           TiffGuardar = Tiff(strcat(handles.pathProyecto,'/Procesadas/Multi/',nombreIm,'ConIndices.tif'),'w');
            tagstruct.ImageLength = size(dataImOriginal,1);
            tagstruct.ImageWidth = size(dataImOriginal,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =numBandas;
            tagstruct.RowsPerStrip = 16;
            tagstruct.ExtraSamples =zeros(1,numBandas);
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
            tagstruct.Software = 'MATLAB';
            TiffGuardar.setTag(tagstruct);
            TiffGuardar.write(dataImProcesada); 
            TiffGuardar.close;

          TiffActual.close;
          clear dataImProcesada dataImOriginal;
          toc
     end
    toc
    close(current_process);
    
    
    [~,nombrePrimeraFoto, ~] = fileparts(char(handles.MultiPath(1,1)));
     [~,nombreUltimaFoto, ~] = fileparts(char(handles.MultiPath(1,numImagenes(2))));
    
    
fprintf(fileID,'%s \r\n','---------------------------------------------------------------');
fprintf(fileID,'%s \r\n','Im�genes procesadas:');
fprintf(fileID,'%s \r\n',['Inicial:     ',nombrePrimeraFoto]);    
 fprintf(fileID,'%s \r\n',['                                      Final:     ',nombreUltimaFoto]);     
 fprintf(fileID,'%s \r\n','---------------------------------------------------------------');  
  fprintf(fileID,'%s \r\n',['Tiempo estimado de c�lculo (segundos): ',num2str(toc)]);
 fprintf(fileID,'%s \r\n',['Fin del informe de postprocesado, ',datestr(now)]);
 fclose(fileID);   
    
        
end
guidata(hObject, handles);




% --- Executes on selection change in popMaster.
function popMaster_Callback(hObject, eventdata, handles)
% hObject    handle to popMaster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMaster contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMaster
guidata(hObject, handles);


% --- Executes on selection change in popB1.
function popB1_Callback(hObject, eventdata, handles)
% hObject    handle to popB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popB1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popB1
guidata(hObject, handles);


% --- Executes on selection change in popB2.
function popB2_Callback(hObject, eventdata, handles)
% hObject    handle to popB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popB2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popB2
guidata(hObject, handles);


% --- Executes on selection change in popB3.
function popB3_Callback(hObject, eventdata, handles)
% hObject    handle to popB3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popB3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popB3
guidata(hObject, handles);


% --- Executes on selection change in popB4.
function popB4_Callback(hObject, eventdata, handles)
% hObject    handle to popB4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popB4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popB4
guidata(hObject, handles);


% --- Executes on selection change in popB5.
function popB5_Callback(hObject, eventdata, handles)
% hObject    handle to popB5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popB5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popB5
guidata(hObject, handles);


% --- Executes on button press in btnExaminar.
function btnExaminar_Callback(hObject, eventdata, handles)

[Im_Name,Im_PathName] = uigetfile({'*tif';'*.jpg';'*.jpeg';'*tiff';'*.*'},'Selecciona imagenes a procesar',strcat(handles.pathProyecto,'/Tiffs 16 bits para procesar/6 bandes'),'MultiSelect', 'on');
handles.MultiPath=strcat(Im_PathName,Im_Name);
handles.Master.path=strcat(Im_PathName,Im_Name);
handles.B1.path=strcat(Im_PathName,Im_Name);
handles.B2.path=strcat(Im_PathName,Im_Name);
handles.B3.path=strcat(Im_PathName,Im_Name);
handles.B4.path=strcat(Im_PathName,Im_Name);
handles.B5.path=strcat(Im_PathName,Im_Name);
set(handles.text_examinar,'String',handles.MultiPath);
clear Im_Name Im_PathName

guidata(hObject, handles);


% --- Executes on button press in chkHisto.
function chkHisto_Callback(hObject, eventdata, handles)
% hObject    handle to chkHisto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkHisto
guidata(hObject, handles);

% --- Executes when selected object is changed in panColMap.
function panColMap_SelectionChangeFcn(hObject, eventdata, handles)
rgb_gris_value=get(handles.rdbGris,'Value');
if rgb_gris_value==1
    [handles.rgb_g_limits(1),handles.rgb_g_limits(2),handles.rgb_g_limits(3),handles.rgb_g_limits(4),handles.rgb_g_limits(5),handles.rgb_g_limits(6),handles.status_suelo,...
        handles.auxiliar_limits(1),handles.auxiliar_limits(2),handles.auxiliar_limits(3),handles.auxiliar_limits(4),handles.auxiliar_limits(5),handles.auxiliar_limits(6),...
        handles.check_aux(1),handles.check_aux(2),handles.check_aux(3)]=...
        NDRVI_RGB_Menu(handles.rgb_g_limits(1),handles.rgb_g_limits(2),handles.rgb_g_limits(3),handles.rgb_g_limits(4),handles.rgb_g_limits(5),handles.rgb_g_limits(6),handles.status_suelo,...
        handles.auxiliar_limits(1),handles.auxiliar_limits(2),handles.auxiliar_limits(3),handles.auxiliar_limits(4),handles.auxiliar_limits(5),handles.auxiliar_limits(6),...
        handles.check_aux(1),handles.check_aux(2),handles.check_aux(3));
end
guidata(hObject, handles);% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in chkCuadr.
function chkCuadr_Callback(hObject, eventdata, handles)
status_cuad=get(handles.chkCuadr,'Value');
if status_cuad==1
    prompt={'Divisiones en X:','Divisiones en Y:'};
    dlg_title='Cuadr�cula';
    num_lines=1;
    def={'',''};
    answer=inputdlg(prompt,dlg_title,num_lines,def);
    handles.cuad_div=str2double(answer);
    guidata(hObject, handles);r
end

% --- Executes on button press in chkProceso.
function chkProceso_Callback(hObject, eventdata, handles)
% hObject    handle to chkProceso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkProceso
guidata(hObject, handles);


% --- Executes on button press in chkParalel.
function chkParalel_Callback(hObject, eventdata, handles)
% hObject    handle to chkParalel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkParalel
guidata(hObject, handles);


% --- Executes on button press in chkImagenes.
function chkImagenes_Callback(hObject, eventdata, handles)
% hObject    handle to chkImagenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkImagenes
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popMaster_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMaster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popB1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popB2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popB3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popB3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popB4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popB4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popB5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popB5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;


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



function edit_calib_blanco_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_5 as a double



function edit_calib_gris_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_5 as a double



function edit_calib_negro_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_5 as a double



function edit_calib_blanco_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_4 as a double



function edit_calib_gris_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_4 as a double



function edit_calib_negro_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_4 as a double



function edit_calib_blanco_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_3 as a double



function edit_calib_gris_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_3 as a double



function edit_calib_negro_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_3 as a double



function edit_calib_blanco_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_2 as a double



function edit_calib_gris_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_2 as a double



function edit_calib_negro_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_2 as a double



function edit_calib_blanco_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_1 as a double



function edit_calib_gris_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_1 as a double



function edit_calib_negro_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_1 as a double



function edit_calib_blanco_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_blanco_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_blanco_master as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_blanco_master as a double



function edit_calib_gris_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_gris_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_gris_master as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_gris_master as a double



function edit_calib_negro_master_Callback(hObject, eventdata, handles)
% hObject    handle to edit_calib_negro_master (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_calib_negro_master as text
%        str2double(get(hObject,'String')) returns contents of edit_calib_negro_master as a double


% --- Executes on button press in chkNDVI780.
function chkNDVI780_Callback(hObject, eventdata, handles)
% hObject    handle to chkNDVI780 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkNDVI780


% --- Executes on button press in chkDCNI.
function chkDCNI_Callback(hObject, eventdata, handles)
% hObject    handle to chkDCNI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkDCNI


% --- Executes on button press in chkTCARI.
function chkTCARI_Callback(hObject, eventdata, handles)
% hObject    handle to chkTCARI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkTCARI


% --- Executes on button press in chkPRI.
function chkPRI_Callback(hObject, eventdata, handles)
% hObject    handle to chkPRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkPRI


% --- Executes on button press in chkNADA.
function chkNADA_Callback(hObject, eventdata, handles)
% hObject    handle to chkNADA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkNADA


function chkComprobacion_Callback(hObject, eventdata, handles)




guidata(hObject,handles);


function numStretching_Callback(hObject, eventdata, handles)


function numStretching_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'value',1);
end


% --- Executes on button press in btnConfig.
function btnConfig_Callback(hObject, eventdata, handles)
% hObject    handle to btnConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.configActual,handles.bandas]=CambioConfigTETRA;

    set(handles.lblConfig,'String',handles.configActual);
    guidata(hObject,handles);



% --- Executes on button press in chkCalibSimple.
function chkCalibSimple_Callback(hObject, eventdata, handles)
% hObject    handle to chkCalibSimple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkCalibSimple


% --- Executes on button press in btnVolver.
function btnVolver_Callback(hObject, eventdata, handles)

close NDRVI_Menu_Multibanda_Single;
NDRVI_Main(handles.indiceProyecto);




function popReflectancias_Callback(hObject, eventdata, handles)
%%  Cambiamos las reflectancias dependiendo de la opci�n seleccionada:
procesoCambioReflectancias=waitbar(0,'Cambiando Reflectancias');
configuracionesPosibles=get(handles.popReflectancias,'String');
numConfiguracionSeleccionada=get(handles.popReflectancias,'Value');

waitbar(0.25,procesoCambioReflectancias,'Cambiando Reflectancias');
reflectancias=xlsread('DB_folder/Configuracion_Reflectancias_DB.xlsx',char(configuracionesPosibles(numConfiguracionSeleccionada)),'C1:C18');

waitbar(0.75,procesoCambioReflectancias,'Cambiando Reflectancias');
set(handles.edit_ref_blanco_master,'String',num2str(reflectancias(1)));
set(handles.edit_ref_gris_master,'String',num2str(reflectancias(2)));
set(handles.edit_ref_negro_master,'String',num2str(reflectancias(3)));

set(handles.edit_ref_blanco_1,'String',num2str(reflectancias(4)));
set(handles.edit_ref_gris_1,'String',num2str(reflectancias(5)));
set(handles.edit_ref_negro_1,'String',num2str(reflectancias(6)));

set(handles.edit_ref_blanco_2,'String',num2str(reflectancias(7)));
set(handles.edit_ref_gris_2,'String',num2str(reflectancias(8)));
set(handles.edit_ref_negro_2,'String',num2str(reflectancias(9)));

set(handles.edit_ref_blanco_3,'String',num2str(reflectancias(10)));
set(handles.edit_ref_gris_3,'String',num2str(reflectancias(11)));
set(handles.edit_ref_negro_3,'String',num2str(reflectancias(12)));

set(handles.edit_ref_blanco_4,'String',num2str(reflectancias(13)));
set(handles.edit_ref_gris_4,'String',num2str(reflectancias(14)));
set(handles.edit_ref_negro_4,'String',num2str(reflectancias(15)));

set(handles.edit_ref_blanco_5,'String',num2str(reflectancias(16)));
set(handles.edit_ref_gris_5,'String',num2str(reflectancias(17)));
set(handles.edit_ref_negro_5,'String',num2str(reflectancias(18)));
close(procesoCambioReflectancias);

% --- Executes during object creation, after setting all properties.
function popReflectancias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popReflectancias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkMCARI.
function chkMCARI_Callback(hObject, eventdata, handles)
% hObject    handle to chkMCARI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkMCARI


% --- Executes on button press in chkMCARI2.
function chkMCARI2_Callback(hObject, eventdata, handles)
% hObject    handle to chkMCARI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkMCARI2


% --- Executes on button press in chkTVI.
function chkTVI_Callback(hObject, eventdata, handles)
% hObject    handle to chkTVI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkTVI


% --- Executes on button press in chkMTVI2.
function chkMTVI2_Callback(hObject, eventdata, handles)
% hObject    handle to chkMTVI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkMTVI2


% --- Executes on button press in chkNDVI800.
function chkNDVI800_Callback(hObject, eventdata, handles)
% hObject    handle to chkNDVI800 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkNDVI800


% --- Executes on button press in chkNTest2.
function chkNTest2_Callback(hObject, eventdata, handles)
% hObject    handle to chkNTest2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkNTest2


% --- Executes on button press in chkNTest1.
function chkNTest1_Callback(hObject, eventdata, handles)
% hObject    handle to chkNTest1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkNTest1


% --- Executes on button press in chkFB1.
function chkFB1_Callback(hObject, eventdata, handles)
% hObject    handle to chkFB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkFB1


% --- Executes on button press in chkFB2.
function chkFB2_Callback(hObject, eventdata, handles)
% hObject    handle to chkFB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkFB2


% --- Executes on button press in chkPCD780.
function chkPCD780_Callback(hObject, eventdata, handles)
% hObject    handle to chkPCD780 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkPCD780


% --- Executes on button press in chkPCD800.
function chkPCD800_Callback(hObject, eventdata, handles)
% hObject    handle to chkPCD800 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkPCD800
