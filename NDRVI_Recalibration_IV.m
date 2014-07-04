function varargout = NDRVI_Recalibration_IV(varargin)
% NDRVI_RECALIBRATION_IV MATLAB code for NDRVI_Recalibration_IV.fig
%      NDRVI_RECALIBRATION_IV, by itself, creates a new NDRVI_RECALIBRATION_IV or raises the existing
%      singleton*.
%
%      H = NDRVI_RECALIBRATION_IV returns the handle to a new NDRVI_RECALIBRATION_IV or the handle to
%      the existing singleton*.
%
%      NDRVI_RECALIBRATION_IV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NDRVI_RECALIBRATION_IV.M with the given input arguments.
%
%      NDRVI_RECALIBRATION_IV('Property','Value',...) creates a new NDRVI_RECALIBRATION_IV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NDRVI_Recalibration_IV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NDRVI_Recalibration_IV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above title to modify the response to help NDRVI_Recalibration_IV

% Last Modified by GUIDE v2.5 13-Nov-2013 13:44:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_Recalibration_IV_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_Recalibration_IV_OutputFcn, ...
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


% --- Executes just before NDRVI_Recalibration_IV is made visible.
function NDRVI_Recalibration_IV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NDRVI_Recalibration_IV (see VARARGIN)

% Choose default command line output for NDRVI_Recalibration_IV
handles.output = hObject;

% % %
global program_name;
set(handles.title,'string',program_name);

%varargin{1} = primer índice de calibración seteado a 0
%varargin{2} = imagen "ima"
%varargin{3} = colormap
%varargin{4} = maximo
%varargin{5} = minimo
%varargin{6} = estatus de la cuadrícula
%varargin{7} = valores cuadrícula

handles.IV_rec=varargin{1};
handles.ima=varargin{2};
handles.cmap=varargin{3};
handles.maximo=varargin{4};
handles.minimo=varargin{5};
handles.status_cuad=varargin{6};
handles.cuad_div=varargin{7};

handles.size_ima=size(handles.ima);
handles.delta_IV=0.01;

set(handles.edit_delta_IV,'String',num2str(varargin{1}));

%axes(handles.axes1);
%imshow(handles.ima,'Colormap',handles.cmap);
%colorbar;

axes(handles.axes1);
handles.im=imagesc(handles.ima);
colormap(handles.cmap)
set(handles.axes1,'xtick',[]);
set(handles.axes1,'xcolor',[0.941 0.941 0.941])
set(handles.axes1,'ytick',[]);
set(handles.axes1,'ycolor',[0.941 0.941 0.941])
set(handles.im,'HitTest','off')
caxis([0,1])
colorbar;

if handles.status_cuad==1
    im_size=size(handles.ima);
    for i=1:handles.cuad_div(1)-1
        hold on
        x_cuad(1)=i*im_size(2)/handles.cuad_div(1);
        x_cuad(2)=x_cuad(1);
        y_cuad(1)=0;
        y_cuad(2)=im_size(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
    for j=1:handles.cuad_div(2)-1
        hold on
        x_cuad(1)=0;
        x_cuad(2)=im_size(2);
        y_cuad(1)=j*im_size(1)/handles.cuad_div(2);
        y_cuad(2)=y_cuad(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
end

set(handles.text_maximo,'String',num2str(handles.maximo));
set(handles.text_minimo,'String',num2str(handles.minimo));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NDRVI_Recalibration_IV wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_Recalibration_IV_OutputFcn(hObject, eventdata, handles) 
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
function menu_editor_Archivo_Cerrar_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Archivo_Cerrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close NDRVI_Recalibration_IV;


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


% --------------------------------------------------------------------
function menu_editor_Archivo_Guardar_Imagen_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Archivo_Guardar_Imagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NDRVI_im_save(handles.ima,handles.cmap);


% --------------------------------------------------------------------
function axes_context_menu_Callback(hObject, eventdata, handles)
% hObject    handle to axes_context_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_editor_Herramientas_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Herramientas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_editor_Herramientas_Histograma_Callback(hObject, eventdata, handles)
% hObject    handle to menu_editor_Herramientas_Histograma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure;
imhist(handles.ima);


function edit_delta_IV_Callback(hObject, eventdata, handles)
% hObject    handle to edit_delta_IV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_delta_IV as title
%        str2double(get(hObject,'String')) returns contents of edit_delta_IV as a double

handles.IV_rec=str2double(get(handles.edit_delta_IV,'String'));

current_process=waitbar(0,'Recalibrando...0%');

for i=1:handles.size_ima(1)
    
    waitbar(i/handles.size_ima(1),current_process,strcat('Recalibrando...',num2str(round(i*100/handles.size_ima(1))),'%'));
    
    for j=1:handles.size_ima(2)
        
        if handles.ima(i,j)+handles.IV_rec>=1
            
            handles.ima(i,j)=1;
            
        end
            
        if handles.ima(i,j)+handles.IV_rec<=-1
            
            handles.ima(i,j)=-1;
            
        end
        
        if handles.ima(i,j)+handles.IV_rec<1 && handles.ima(i,j)+handles.IV_rec>-1
            
            handles.ima(i,j)=handles.ima(i,j)+handles.IV_rec;
            
        end
        
    end
    
end

close(current_process);

%axes(handles.axes1);
%imshow(handles.ima,'Colormap',handles.cmap);
%colorbar;

axes(handles.axes1);
handles.im=imagesc(handles.ima);
colormap(handles.cmap)
set(handles.axes1,'xtick',[]);
set(handles.axes1,'xcolor',[0.941 0.941 0.941])
set(handles.axes1,'ytick',[]);
set(handles.axes1,'ycolor',[0.941 0.941 0.941])
set(handles.im,'HitTest','off')
caxis([0,1])
colorbar;

if handles.status_cuad==1
    im_size=size(handles.ima);
    for i=1:handles.cuad_div(1)-1
        hold on
        x_cuad(1)=i*im_size(2)/handles.cuad_div(1);
        x_cuad(2)=x_cuad(1);
        y_cuad(1)=0;
        y_cuad(2)=im_size(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
    for j=1:handles.cuad_div(2)-1
        hold on
        x_cuad(1)=0;
        x_cuad(2)=im_size(2);
        y_cuad(1)=j*im_size(1)/handles.cuad_div(2);
        y_cuad(2)=y_cuad(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
end

handles.minimo = min(min(handles.ima)); set(handles.text_minimo,'String',num2str(handles.minimo));
handles.maximo = max(max(handles.ima)); set(handles.text_maximo,'String',num2str(handles.maximo));

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_delta_IV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta_IV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_menos_IV.
function pushbutton_menos_IV_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_menos_IV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_process=waitbar(0,'Recalibrando...0%');

for i=1:handles.size_ima(1)
    
    waitbar(i/handles.size_ima(1),current_process,strcat('Recalibrando...',num2str(round(i*100/handles.size_ima(1))),'%'));
    
    for j=1:handles.size_ima(2)
        
        if handles.ima(i,j)-handles.delta_IV<=-1
            
            handles.ima(i,j)=-1;
            
        end
            
        if handles.ima(i,j)-handles.delta_IV<1 && handles.ima(i,j)-handles.delta_IV>-1
            
            handles.ima(i,j)=handles.ima(i,j)-handles.delta_IV;
            
        end
        
    end
    
end

close(current_process);

%axes(handles.axes1);
%imshow(handles.ima,'Colormap',handles.cmap);
%colorbar;

axes(handles.axes1);
handles.im=imagesc(handles.ima);
colormap(handles.cmap)
set(handles.axes1,'xtick',[]);
set(handles.axes1,'xcolor',[0.941 0.941 0.941])
set(handles.axes1,'ytick',[]);
set(handles.axes1,'ycolor',[0.941 0.941 0.941])
set(handles.im,'HitTest','off')
caxis([0,1])
colorbar;

if handles.status_cuad==1
    im_size=size(handles.ima);
    for i=1:handles.cuad_div(1)-1
        hold on
        x_cuad(1)=i*im_size(2)/handles.cuad_div(1);
        x_cuad(2)=x_cuad(1);
        y_cuad(1)=0;
        y_cuad(2)=im_size(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
    for j=1:handles.cuad_div(2)-1
        hold on
        x_cuad(1)=0;
        x_cuad(2)=im_size(2);
        y_cuad(1)=j*im_size(1)/handles.cuad_div(2);
        y_cuad(2)=y_cuad(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
end

handles.IV_rec=handles.IV_rec-handles.delta_IV;
set(handles.edit_delta_IV,'String',num2str(handles.IV_rec));
handles.minimo = min(min(handles.ima)); set(handles.text_minimo,'String',num2str(handles.minimo));
handles.maximo = max(max(handles.ima)); set(handles.text_maximo,'String',num2str(handles.maximo));

guidata(hObject, handles);


% --- Executes on button press in pushbutton_mas_IV.
function pushbutton_mas_IV_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mas_IV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_process=waitbar(0,'Recalibrando...0%');

for i=1:handles.size_ima(1)
    
    waitbar(i/handles.size_ima(1),current_process,strcat('Recalibrando...',num2str(round(i*100/handles.size_ima(1))),'%'));
    
    for j=1:handles.size_ima(2)
        
        if handles.ima(i,j)+handles.delta_IV>=1
            
            handles.ima(i,j)=1;
            
        end
            
        if handles.ima(i,j)+handles.delta_IV<1 && handles.ima(i,j)+handles.delta_IV>-1
            
            handles.ima(i,j)=handles.ima(i,j)+handles.delta_IV;
            
        end
        
    end
    
end

close(current_process);

%axes(handles.axes1);
%imshow(handles.ima,'Colormap',handles.cmap);
%colorbar;

axes(handles.axes1);
handles.im=imagesc(handles.ima);
colormap(handles.cmap)
set(handles.axes1,'xtick',[]);
set(handles.axes1,'xcolor',[0.941 0.941 0.941])
set(handles.axes1,'ytick',[]);
set(handles.axes1,'ycolor',[0.941 0.941 0.941])
set(handles.im,'HitTest','off')
caxis([0,1])
colorbar;

if handles.status_cuad==1
    im_size=size(handles.ima);
    for i=1:handles.cuad_div(1)-1
        hold on
        x_cuad(1)=i*im_size(2)/handles.cuad_div(1);
        x_cuad(2)=x_cuad(1);
        y_cuad(1)=0;
        y_cuad(2)=im_size(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
    for j=1:handles.cuad_div(2)-1
        hold on
        x_cuad(1)=0;
        x_cuad(2)=im_size(2);
        y_cuad(1)=j*im_size(1)/handles.cuad_div(2);
        y_cuad(2)=y_cuad(1);
        plot(x_cuad,y_cuad,'Color','k','LineStyle',':');
    end
end

handles.IV_rec=handles.IV_rec+handles.delta_IV;
set(handles.edit_delta_IV,'String',num2str(handles.IV_rec));
handles.minimo = min(min(handles.ima)); set(handles.text_minimo,'String',num2str(handles.minimo));
handles.maximo = max(max(handles.ima)); set(handles.text_maximo,'String',num2str(handles.maximo));

guidata(hObject, handles);


% --------------------------------------------------------------------
function axes_context_menu_hist_Callback(hObject, eventdata, handles)
% hObject    handle to axes_context_menu_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure;
imhist(handles.ima);
