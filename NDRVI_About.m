function varargout = NDRVI_About(varargin)
% NDRVI_ABOUT MATLAB code for NDRVI_About.fig
%      NDRVI_ABOUT, by itself, creates a new NDRVI_ABOUT or raises the existing
%      singleton*.
%
%      H = NDRVI_ABOUT returns the handle to a new NDRVI_ABOUT or the handle to
%      the existing singleton*.
%
%      NDRVI_ABOUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NDRVI_ABOUT.M with the given input arguments.
%
%      NDRVI_ABOUT('Property','Value',...) creates a new NDRVI_ABOUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NDRVI_About_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NDRVI_About_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NDRVI_About

% Last Modified by GUIDE v2.5 17-Oct-2013 13:00:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDRVI_About_OpeningFcn, ...
                   'gui_OutputFcn',  @NDRVI_About_OutputFcn, ...
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


% --- Executes just before NDRVI_About is made visible.
function NDRVI_About_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NDRVI_About (see VARARGIN)

% Choose default command line output for NDRVI_About
handles.output = hObject;

axes(handles.axes1);
imshow('HEMAV_logo.jpg');
set(gcf,'WindowButtonDownFcn','close NDRVI_About')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NDRVI_About wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NDRVI_About_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
