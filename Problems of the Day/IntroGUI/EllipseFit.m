function varargout = EllipseFit(varargin)
% ELLIPSEFIT M-file for EllipseFit.fig
%      ELLIPSEFIT, by itself, creates a new ELLIPSEFIT or raises the existing
%      singleton*.
%
%      H = ELLIPSEFIT returns the handle to a new ELLIPSEFIT or the handle to
%      the existing singleton*.
%
%      ELLIPSEFIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELLIPSEFIT.M with the given input arguments.
%
%      ELLIPSEFIT('Property','Value',...) creates a new ELLIPSEFIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EllipseFit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EllipseFit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EllipseFit

% Last Modified by GUIDE v2.5 16-Jan-2014 15:03:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EllipseFit_OpeningFcn, ...
                   'gui_OutputFcn',  @EllipseFit_OutputFcn, ...
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


% --- Executes just before EllipseFit is made visible.
function EllipseFit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EllipseFit (see VARARGIN)

% Choose default command line output for EllipseFit
handles.output = hObject;

handles.N = 20;
set(handles.N_slider,'Min',10,'Max',100,'Value',handles.N,'SliderStep',[1/9,.1]);
set(handles.N_edit,'String',sprintf('%3d',handles.N));

handles.noise = .05;
set(handles.noise_slider,'Min',.0,'Max',.20,'Value',handles.noise,'SliderStep',[1/20,.1]);
set(handles.Noise_Edit,'String',sprintf('%4.2f',handles.noise));

set(handles.conic_check,'Value',0);

[handles.x,handles.y] = RandomEllipsePoints(handles.N,handles.noise);
DisplayData(handles.x,handles.y)
handles.C = FitConicLS(handles.x,handles.y);
alfa = Fit(handles.C,handles.x,handles.y);
set(handles.FC_edit,'String',sprintf('%6.3f',alfa))


E = MakeEllipse(2,2,0,0,0);
handles.E = E;

set(handles.a_slider,'Min',handles.E.b,'Max',4.0,'Value',handles.E.a,'SliderStep',[1/500,.1]);
set(handles.a_edit,'String',sprintf('%7.3f',handles.E.a));

set(handles.b_slider,'Min',.1,'Max',handles.E.a,'Value',handles.E.b,'SliderStep',[1/500,.1]);
set(handles.b_edit,'String',sprintf('%7.3f',handles.E.b));

set(handles.h_slider,'Min',-1,'Max',1,'Value',handles.E.h,'SliderStep',[1/200,.1]);
set(handles.h_edit,'String',sprintf('%7.3f',handles.E.h));

set(handles.k_slider,'Min',-1,'Max',1,'Value',handles.E.k,'SliderStep',[1/200,.1]);
set(handles.k_edit,'String',sprintf('%7.3f',handles.E.k));

set(handles.tau_slider,'Min',-180,'Max',180,'Value',handles.E.tau,'SliderStep',[1/360,.1]);
set(handles.tau_edit,'String',sprintf('%7.3f',handles.E.tau));


DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EllipseFit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EllipseFit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in NewButton.
function NewButton_Callback(hObject, eventdata, handles)
% hObject    handle to NewButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.x,handles.y] = RandomEllipsePoints(handles.N,handles.noise);
E = MakeEllipse(2,2,0,0,0);
handles.E = E;
set(handles.a_slider,'Min',handles.E.b,'Value',handles.E.a)
set(handles.b_slider,'Max',handles.E.a,'Value',handles.E.b)
set(handles.h_slider,'Value',0)
set(handles.k_slider,'Value',0)
set(handles.tau_slider,'Value',0)
set(handles.a_edit,'String',sprintf('%7.3f',handles.E.a))
set(handles.b_edit,'String',sprintf('%7.3f',handles.E.b))
set(handles.h_edit,'String',sprintf('%7.3f',handles.E.h))
set(handles.k_edit,'String',sprintf('%7.3f',handles.E.k))
set(handles.tau_edit,'String',sprintf('%4d',handles.E.tau))

DisplayData(handles.x,handles.y)
DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
handles.C = FitConicLS(handles.x,handles.y);
if get(handles.conic_check,'Value')
   DisplayEllipse(handles.C,'c')
end
alfa = Fit(handles.C,handles.x,handles.y);
set(handles.FC_edit,'String',sprintf('%6.3f',alfa))
guidata(hObject, handles);

% --- Executes on slider movement.
function N_slider_Callback(hObject, eventdata, handles)
% hObject    handle to N_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.N = round(get(hObject,'Value'));
set(handles.N_edit,'string',sprintf('%3d',handles.N))
[handles.x,handles.y] = RandomEllipsePoints(handles.N,handles.noise);
DisplayData(handles.x,handles.y)
E = MakeEllipse(2,2,0,0,0);
handles.E = E;
set(handles.a_slider,'Min',handles.E.b,'Value',handles.E.a)
set(handles.b_slider,'Max',handles.E.a,'Value',handles.E.b)
set(handles.h_slider,'Value',0)
set(handles.k_slider,'Value',0)
set(handles.tau_slider,'Value',0)
set(handles.a_edit,'String',sprintf('%7.3f',handles.E.a))
set(handles.b_edit,'String',sprintf('%7.3f',handles.E.b))
set(handles.h_edit,'String',sprintf('%7.3f',handles.E.h))
set(handles.k_edit,'String',sprintf('%7.3f',handles.E.k))
set(handles.tau_edit,'String',sprintf('%4d',handles.E.tau))

DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
handles.C = FitConicLS(handles.x,handles.y);
if get(handles.conic_check,'Value')
   DisplayEllipse(handles.C,'c')
end
alfa = Fit(handles.C,handles.x,handles.y);
set(handles.FC_edit,'String',sprintf('%6.3f',alfa))
guidata(hObject, handles);





% --- Executes during object creation, after setting all properties.
function N_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function noise_slider_Callback(hObject, eventdata, handles)
% hObject    handle to noise_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.noise = get(hObject,'Value');
set(handles.Noise_Edit,'string',sprintf('%4.2f',handles.noise))
[handles.x,handles.y] = RandomEllipsePoints(handles.N,handles.noise);
DisplayData(handles.x,handles.y)

E = MakeEllipse(2,2,0,0,0);
handles.E = E;
set(handles.a_slider,'Min',handles.E.b,'Value',handles.E.a)
set(handles.b_slider,'Max',handles.E.a,'Value',handles.E.b)
set(handles.h_slider,'Value',0)
set(handles.k_slider,'Value',0)
set(handles.tau_slider,'Value',0)
set(handles.a_edit,'String',sprintf('%7.3f',handles.E.a))
set(handles.b_edit,'String',sprintf('%7.3f',handles.E.b))
set(handles.h_edit,'String',sprintf('%7.3f',handles.E.h))
set(handles.k_edit,'String',sprintf('%7.3f',handles.E.k))
set(handles.tau_edit,'String',sprintf('%4d',handles.E.tau))

DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
if get(handles.conic_check,'Value')
    handles.C = FitConicLS(handles.x,handles.y);
    DisplayEllipse(handles.C,'c')
end
alfa = Fit(handles.C,handles.x,handles.y);
set(handles.FC_edit,'String',sprintf('%6.3f',alfa))
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function noise_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function N_edit_Callback(hObject, eventdata, handles)
% hObject    handle to N_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_edit as text
%        str2double(get(hObject,'String')) returns contents of N_edit as a double


% --- Executes during object creation, after setting all properties.
function N_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Noise_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Noise_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Noise_Edit as text
%        str2double(get(hObject,'String')) returns contents of Noise_Edit as a double


% --- Executes during object creation, after setting all properties.
function Noise_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noise_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function tau_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tau_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.E.tau = get(hObject,'Value');
set(handles.tau_edit,'String',sprintf('%7.3f',handles.E.tau))
handles.E = MakeEllipse(handles.E.a,handles.E.b,handles.E.h,handles.E.k,handles.E.tau);
DisplayData(handles.x,handles.y)
DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
if get(handles.conic_check,'Value')
    DisplayEllipse(handles.C,'c')
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function tau_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tau_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function k_slider_Callback(hObject, eventdata, handles)
% hObject    handle to k_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.E.k = get(hObject,'Value');
set(handles.k_edit,'String',sprintf('%7.3f',handles.E.k))
handles.E = MakeEllipse(handles.E.a,handles.E.b,handles.E.h,handles.E.k,handles.E.tau);
DisplayData(handles.x,handles.y)
DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
if get(handles.conic_check,'Value')
    DisplayEllipse(handles.C,'c')
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function k_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function h_slider_Callback(hObject, eventdata, handles)
% hObject    handle to h_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.E.h = get(hObject,'Value');
set(handles.h_edit,'String',sprintf('%7.3f',handles.E.h))
handles.E = MakeEllipse(handles.E.a,handles.E.b,handles.E.h,handles.E.k,handles.E.tau);
DisplayData(handles.x,handles.y)
DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
if get(handles.conic_check,'Value')
    DisplayEllipse(handles.C,'c')
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function h_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.E.b = get(hObject,'Value');
set(handles.b_edit,'String',sprintf('%5.3f',handles.E.b));
set(handles.a_slider,'Min',handles.E.b);
handles.E = MakeEllipse(handles.E.a,handles.E.b,handles.E.h,handles.E.k,handles.E.tau);
DisplayData(handles.x,handles.y)
DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
if get(handles.conic_check,'Value')
    DisplayEllipse(handles.C,'c')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function b_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function a_slider_Callback(hObject, eventdata, handles)
% hObject    handle to a_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.E.a = get(hObject,'Value');
set(handles.a_edit,'String',sprintf('%5.3f',handles.E.a))
set(handles.b_slider,'Max',handles.E.a);
handles.E = MakeEllipse(handles.E.a,handles.E.b,handles.E.h,handles.E.k,handles.E.tau);
DisplayData(handles.x,handles.y)
DisplayEllipse(handles.E,'w')
alfa = Fit(handles.E,handles.x,handles.y);
set(handles.FE_edit,'String',sprintf('%6.3f',alfa))
if get(handles.conic_check,'Value')
    DisplayEllipse(handles.C,'c')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function a_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function a_edit_Callback(hObject, eventdata, handles)
% hObject    handle to a_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_edit as text
%        str2double(get(hObject,'String')) returns contents of a_edit as a double


% --- Executes during object creation, after setting all properties.
function a_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b_edit as text
%        str2double(get(hObject,'String')) returns contents of b_edit as a double


% --- Executes during object creation, after setting all properties.
function b_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_edit_Callback(hObject, eventdata, handles)
% hObject    handle to h_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_edit as text
%        str2double(get(hObject,'String')) returns contents of h_edit as a double


% --- Executes during object creation, after setting all properties.
function h_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_edit_Callback(hObject, eventdata, handles)
% hObject    handle to k_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_edit as text
%        str2double(get(hObject,'String')) returns contents of k_edit as a double


% --- Executes during object creation, after setting all properties.
function k_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tau_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tau_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tau_edit as text
%        str2double(get(hObject,'String')) returns contents of tau_edit as a double


% --- Executes during object creation, after setting all properties.
function tau_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tau_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in conic_check.
function conic_check_Callback(hObject, eventdata, handles)
% hObject    handle to conic_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of conic_check
DisplayData(handles.x,handles.y)
DisplayEllipse(handles.E,'w')
if get(handles.conic_check,'Value')
    DisplayEllipse(handles.C,'c')
end

guidata(hObject, handles);



function FC_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FC_edit as text
%        str2double(get(hObject,'String')) returns contents of FC_edit as a double


% --- Executes during object creation, after setting all properties.
function FC_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FE_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FE_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FE_edit as text
%        str2double(get(hObject,'String')) returns contents of FE_edit as a double


% --- Executes during object creation, after setting all properties.
function FE_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FE_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
