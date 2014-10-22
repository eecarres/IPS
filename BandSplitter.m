function varargout = BandSplitter(varargin)
% BANDSPLITTER MATLAB code for BandSplitter.fig
%      BANDSPLITTER, by itself, creates a new BANDSPLITTER or raises the existing
%      singleton*.
%
%      H = BANDSPLITTER returns the handle to a new BANDSPLITTER or the handle to
%      the existing singleton*.
%
%      BANDSPLITTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BANDSPLITTER.M with the given input arguments.
%
%      BANDSPLITTER('Property','Value',...) creates a new BANDSPLITTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BandSplitter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BandSplitter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BandSplitter

% Last Modified by GUIDE v2.5 09-Oct-2014 18:00:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BandSplitter_OpeningFcn, ...
                   'gui_OutputFcn',  @BandSplitter_OutputFcn, ...
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


% --- Executes just before BandSplitter is made visible.
function BandSplitter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BandSplitter (see VARARGIN)

% Choose default command line output for BandSplitter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BandSplitter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BandSplitter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnCargaTiffs.
function btnCargaTiffs_Callback(hObject, eventdata, handles)
[Im_Name,Im_PathName] = uigetfile({'*tif';'*tiff';'*.*'},'Selecciona imagenes a dividir','C:\Agromav IPS\', 'on');
set(handles.lstImagenes,'string',Im_Name);
handles.multiPath=strcat(Im_PathName,Im_Name);
guidata(hObject, handles);

% --- Executes on selection change in lstImagenes.
function lstImagenes_Callback(hObject, eventdata, handles)
% hObject    handle to lstImagenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstImagenes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstImagenes


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


% --- Executes on button press in btnDividir.
function btnDividir_Callback(hObject, eventdata, handles)
 

for i=1:numel(handles.multiPath)
    
    
    
    
    
    %% Obtenemos la información del archivo de imagen
      TiffActual = Tiff(char(handles.multiPath(1,i)),'r+');
      [path,nombreIm, ~] = fileparts(char(handles.multiPath(1,i)));
      dataImOriginal=TiffActual.read();
      tamanoIm=size(dataImOriginal);
      numBandas=tamanoIm(3);
      
      %% Creamos los directorios
      mkdir([path,'\Bandas 1-4']);
      mkdir([path,'\Bandas 5-8']);
      mkdir([path,'\Bandas 9-10']);
      %% En función del número de bandas se divide en más o menos trozos (Por ahora debe tener 10 bandas o no funcionará!)

      
      %Bandas 1-4
           TiffGuardar = Tiff([path,'\Bandas 1-4\',nombreIm,'.tif'],'w');
            tagstruct.ImageLength = size(dataImOriginal,1);
            tagstruct.ImageWidth = size(dataImOriginal,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =4;
            tagstruct.RowsPerStrip = 16;
            tagstruct.ExtraSamples =zeros(1,4);
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
            tagstruct.Software = 'MATLAB';
            TiffGuardar.setTag(tagstruct);
            TiffGuardar.write(dataImOriginal(:,:,1:4)); 
            TiffGuardar.close;
            
            %Bandas 5-8
           TiffGuardar = Tiff([path,'\Bandas 5-8\',nombreIm,'.tif'],'w');
            tagstruct.ImageLength = size(dataImOriginal,1);
            tagstruct.ImageWidth = size(dataImOriginal,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =4;
            tagstruct.RowsPerStrip = 16;
            tagstruct.ExtraSamples =zeros(1,4);
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
            tagstruct.Software = 'MATLAB';
            TiffGuardar.setTag(tagstruct);
            TiffGuardar.write(dataImOriginal(:,:,5:8)); 
            TiffGuardar.close;
            
            %Bandas 9-10
           TiffGuardar = Tiff([path,'\Bandas 9-10\',nombreIm,'.tif'],'w');
            tagstruct.ImageLength = size(dataImOriginal,1);
            tagstruct.ImageWidth = size(dataImOriginal,2);
            tagstruct.Photometric = Tiff.Photometric.Separated;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel =2;
            tagstruct.RowsPerStrip = 16;
            tagstruct.ExtraSamples =zeros(1,2);
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Separate;
            tagstruct.Software = 'MATLAB';
            TiffGuardar.setTag(tagstruct);
            TiffGuardar.write(dataImOriginal(:,:,9:10)); 
            TiffGuardar.close;

          TiffActual.close;
end