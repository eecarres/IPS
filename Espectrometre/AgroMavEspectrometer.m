function varargout = AgroMavEspectrometer(varargin)
% AGROMAVESPECTROMETER MATLAB code for AgroMavEspectrometer.fig
%      AGROMAVESPECTROMETER, by itself, creates a new AGROMAVESPECTROMETER or raises the existing
%      singleton*.
%
%      H = AGROMAVESPECTROMETER returns the handle to a new AGROMAVESPECTROMETER or the handle to
%      the existing singleton*.
%
%      AGROMAVESPECTROMETER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AGROMAVESPECTROMETER.M with the given input arguments.
%
%      AGROMAVESPECTROMETER('Property','Value',...) creates a new AGROMAVESPECTROMETER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AgroMavEspectrometer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AgroMavEspectrometer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AgroMavEspectrometer

% Last Modified by GUIDE v2.5 30-Jul-2014 12:03:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AgroMavEspectrometer_OpeningFcn, ...
                   'gui_OutputFcn',  @AgroMavEspectrometer_OutputFcn, ...
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


% --- Executes just before AgroMavEspectrometer is made visible.
function AgroMavEspectrometer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AgroMavEspectrometer (see VARARGIN)

% Choose default command line output for AgroMavEspectrometer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AgroMavEspectrometer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AgroMavEspectrometer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnCrearExcel.
function btnCrearExcel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCrearExcel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
procesoExcel=waitbar(0,'Leyendo datos...');
%% Obtenemos la info del Excel
pathExcel=get(handles.edtDatosRadio,'string');
pathLocation=get(handles.edtDatosLocation,'string');
[status,sheets] = xlsfinfo(pathExcel) ;
hojaExcel=sheets;
hojaExcelResultados='Puntos_Refl';
hojaIndices='Indexs_Refl';


%% Leemos la info del Excel
    [numeros, text ,raw]=xlsread(pathExcel);

Time=text(2,2:5:end);
numColumnasDatos=numel(numeros(1,:))-1;
numMedidas=numel(Time(1,:));
Names=zeros(numMedidas);


fila350=32-2;
LDO= numeros(fila350:end,1);
noLDO=numel(LDO);
valoresMedios=zeros(noLDO,numMedidas);
j=0;
for i=2:5:numColumnasDatos
    j=j+1;
    col1=numeros(fila350:end,i);
    col2=numeros(fila350:end,i+1);
    col3=numeros(fila350:end,i+2);
    col4=numeros(fila350:end,i+3);
    try
    col5=numeros(fila350:end,i+4);
    
    valores=(col1+col2+col3+col4+col5)/5;
    valoresMedios(:,j)=valores;
    catch
    valores=(col1+col2+col3+col4)/4;
    valoresMedios(:,j)=valores;
    end
end
waitbar(0.25,procesoExcel,'Calculando reflectancias medias');
%Sacamos los valores de reflectancias que nos interesan:

R415=valoresMedios(174-31,1:end);
R430=valoresMedios(207-31,1:end);
R435=valoresMedios(217-31,1:end);
R440=valoresMedios(228-31,1:end);
R531=valoresMedios(424-31,1:end);
R550=valoresMedios(464-31,1:end);
R570=valoresMedios(507-31,1:end);
R573=valoresMedios(513-31,1:end);
R670=valoresMedios(717-31,1:end);
R680=valoresMedios(738-31,1:end);
R700=valoresMedios(779-31,1:end);
R710=valoresMedios(800-31,1:end);
R720=valoresMedios(820-31,1:end);
R750=valoresMedios(882-31,1:end);
R800=valoresMedios(984-31,1:end);

[~,~,RAW]=xlsread(pathLocation);

Names=RAW(1,1:end);
longitud=RAW(2,1:end);
latitud=RAW(3,1:end);




%% Procesamos la info


%% Escribimos el Excel
waitbar(0.5,procesoExcel,'Generando y escribiendo hoja de datos medios');
% Hoja de datos medios
xlswrite(pathExcel,{'Noms punts'},hojaExcelResultados,'A1');
xlswrite(pathExcel,Names,hojaExcelResultados,'B1');
xlswrite(pathExcel,{'Time'},hojaExcelResultados,'A2');
xlswrite(pathExcel,Time,hojaExcelResultados,'B2');
xlswrite(pathExcel,{'Longitud'},hojaExcelResultados,'A3');
xlswrite(pathExcel,longitud,hojaExcelResultados,'B3');
xlswrite(pathExcel,{'Latitud'},hojaExcelResultados,'A4');
xlswrite(pathExcel,latitud,hojaExcelResultados,'B4');
xlswrite(pathExcel,LDO,hojaExcelResultados,'A5');
xlswrite(pathExcel,valoresMedios,hojaExcelResultados,'B5');


clear numeros text raw RAW S

%% Calculo de índices:
waitbar(0.75,procesoExcel,'Calculando Índices');
NDVI=(R800-R670)./(R800+R670);
NDVI_Verde_Azul=(R573-R440)./(R573+R440);
SAVI_05=1.5*(     (R800-R670)./  (R800+R670+0.5)  );
RDVI=(R800-R670)  ./  sqrt(R800+R670);
DCNI=  (R720-R700) ./ (R700-R670)   ./  (R720-R670 + 0.03);
MCARI= (    (R700-R670) - 0.2*(R700-R550)    ) .* (R700./R670);
TCARI=3*(    (     (R700-R670)-0.2*(R700-R550)   )  .*(R700/R670) ) ;
OSAVI=1.16*(     (R800-R670)./  (R800+R670+0.16)  );
TCARI_OSAVI=TCARI ./ OSAVI;
RVI= R800 ./ R670;
PRI=(R570-R531) ./ (R570+R531);
NPCI=(R680-R430)   ./   (R680+R430);
TVI= 0.5*(120*(R750-R550)-200*(R670-R550));
NPQI= (R415-R435)  ./  (R415+R435);
ZM=  R750 ./  R710;




waitbar(0.85,procesoExcel,'Generando y escribiendo hoja de Índices');
% Hoja de índices:

xlswrite(pathExcel,{'Noms punts'},hojaIndices,'A1');
xlswrite(pathExcel,Names,hojaIndices,'B1');
xlswrite(pathExcel,{'Time'},hojaIndices,'A2');
xlswrite(pathExcel,Time,hojaIndices,'B2');
xlswrite(pathExcel,{'Longitud'},hojaIndices,'A3');
xlswrite(pathExcel,longitud,hojaIndices,'B3');
xlswrite(pathExcel,{'Latitud'},hojaIndices,'A4');
xlswrite(pathExcel,latitud,hojaIndices,'B4');
%Indices
xlswrite(pathExcel,{'NDVI'},hojaIndices,'A5');
xlswrite(pathExcel,NDVI,hojaIndices,'B5');
xlswrite(pathExcel,{'NDVI Verde-Azul'},hojaIndices,'A6');
xlswrite(pathExcel,NDVI_Verde_Azul,hojaIndices,'B6');
xlswrite(pathExcel,{'SAVI con L=0.5'},hojaIndices,'A7');
xlswrite(pathExcel,SAVI_05,hojaIndices,'B7');
xlswrite(pathExcel,{'RDVI'},hojaIndices,'A8');
xlswrite(pathExcel,RDVI,hojaIndices,'B8');
xlswrite(pathExcel,{'DCNI'},hojaIndices,'A9');
xlswrite(pathExcel,DCNI,hojaIndices,'B9');
xlswrite(pathExcel,{'MCARI'},hojaIndices,'A10');
xlswrite(pathExcel,MCARI,hojaIndices,'B10');
xlswrite(pathExcel,{'TCARI'},hojaIndices,'A11');
xlswrite(pathExcel,TCARI,hojaIndices,'B11');
xlswrite(pathExcel,{'OSAVI'},hojaIndices,'A12');
xlswrite(pathExcel,OSAVI,hojaIndices,'B12');
xlswrite(pathExcel,{'TCARI/OSAVI'},hojaIndices,'A13');
xlswrite(pathExcel,TCARI_OSAVI,hojaIndices,'B13');
xlswrite(pathExcel,{'RVI'},hojaIndices,'A14');
xlswrite(pathExcel,RVI,hojaIndices,'B14');
xlswrite(pathExcel,{'PRI'},hojaIndices,'A15');
xlswrite(pathExcel,PRI,hojaIndices,'B15');
xlswrite(pathExcel,{'NPCI'},hojaIndices,'A16');
xlswrite(pathExcel,NPCI,hojaIndices,'B16');
xlswrite(pathExcel,{'TVI'},hojaIndices,'A17');
xlswrite(pathExcel,TVI,hojaIndices,'B17');
xlswrite(pathExcel,{'NPQI'},hojaIndices,'A18');
xlswrite(pathExcel,NPQI,hojaIndices,'B18');
xlswrite(pathExcel,{'ZM'},hojaIndices,'A19');
xlswrite(pathExcel,ZM,hojaIndices,'B19');

close(procesoExcel);

function edtDatosRadio_Callback(hObject, eventdata, handles)
% hObject    handle to edtDatosRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtDatosRadio as text
%        str2double(get(hObject,'String')) returns contents of edtDatosRadio as a double


% --- Executes during object creation, after setting all properties.
function edtDatosRadio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtDatosRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnExaminarRadio.
function btnExaminarRadio_Callback(hObject, eventdata, handles)
% hObject    handle to btnExaminarRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nombreArchivo,pathArchivo] = uigetfile({'*xlsx';'*xls';'*.*'},'Selecciona el archivo Excel con los datos del radioespectrómetro');
set(handles.edtDatosRadio,'string',[pathArchivo,nombreArchivo]);


function edtDatosLocation_Callback(hObject, eventdata, handles)
% hObject    handle to edtDatosLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtDatosLocation as text
%        str2double(get(hObject,'String')) returns contents of edtDatosLocation as a double




% --- Executes during object creation, after setting all properties.
function edtDatosLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtDatosLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnExaminarLocation.
function btnExaminarLocation_Callback(hObject, eventdata, handles)
% hObject    handle to btnExaminarLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nombreArchivo,pathArchivo] = uigetfile({'*xlsx';'*xls';'*.*'},'Selecciona el archivo Excel con los datos Location');
set(handles.edtDatosLocation,'string',[pathArchivo,nombreArchivo]);