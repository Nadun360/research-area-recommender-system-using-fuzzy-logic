function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 17-Sep-2021 11:34:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% initialise the skill level array
handles.selected_skill_levels = zeros(1, 8) * 10;
handles.indexes = 1 : 5;

% Load names of lecturers
handles.names = {'Dr. P.M.T.B. Sandirigama', 'Prof. R. G. Ragel', 'Mr. Ziyan Maraikar', 'Mr. D.S. Deegalla', 'Dr. Upul Jayasinghe'};

% Load research interest of each lecturers
handles.descriptions = {'Cryptography and Network Security: Cryptographic Authentication Protocols;; Intellectual Property Issues – both Engineering and non- Engineering Inventions.', 'Embedded Systems Design: Architectural support for Reliability and Security; Security issues on Embedded Processors; Side Channel Attacks; Application Specific Processor Design with Performance and Area Trade off', 'Cloud computing, Distributed systems, learning from data', 'Data Mining, Text Mining, Machine Learning and Big Data', 'IoT, Machine Learning, Computational Trust, Blockchain, Image Processing, Computer Networking, and Wireless Communication.'};

% Load the fuzzy logic
handles.fis = readfis('Fuzzy_Logic');

% set the initial gui interface
init_gui(handles);

% Reset skill levels from the GUI
reset_skill_levels(hObject, handles);

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Prepare the initial gui interface
function init_gui(handles)
set(handles.result_panel, 'Visible', 'off');


% --- Reset skill levels of students.
function reset_skill_levels(hObject, handles)
% reset the current skill values
handles.selected_skill_levels = zeros(1, 8) * 10;
handles.resultant_percentages = zeros(1, 5);
% clear the radio buttons
set(get(handles.sbg1,'SelectedObject'), 'Value', 0.0);    
set(get(handles.sbg2,'SelectedObject'), 'Value', 0.0);
set(get(handles.sbg3,'SelectedObject'), 'Value', 0.0);
set(get(handles.sbg4,'SelectedObject'), 'Value', 0.0);
set(get(handles.sbg5,'SelectedObject'), 'Value', 0.0);
set(get(handles.sbg6,'SelectedObject'), 'Value', 0.0);
set(get(handles.sbg7,'SelectedObject'), 'Value', 0.0);
set(get(handles.sbg8,'SelectedObject'), 'Value', 0.0);

% commit the changes
guidata(hObject, handles);


% Sort the result and get the accending order
function result = sort_results(hObject, handles)
copy = handles.resultant_percentages;

for i = 1 : length(copy)
    index = 1;
    for j = 2 : length(copy)
        if(copy(j) > copy(index))
            index = j;
        end
    end
    handles.indexes(i) = index;
    copy(index) = -1;
end
result = handles.indexes;
guidata(hObject, handles);


% --- Setting colors
function color = set_colors(hObject, handles, i)
if(handles.resultant_percentages(i) > 50)
    color = 'green';
else
    color = 'red';
end

guidata(hObject, handles);


% --- make the second interface.
function set_second_interface(hObject, handles)

set(handles.name1, 'String', handles.names(handles.indexes(1)))
set(handles.name2, 'String', handles.names(handles.indexes(2)))
set(handles.name3, 'String', handles.names(handles.indexes(3)))
set(handles.name4, 'String', handles.names(handles.indexes(4)))
set(handles.name5, 'String', handles.names(handles.indexes(5)))

set(handles.descr1, 'String', handles.descriptions(handles.indexes(1)))
set(handles.descr2, 'String', handles.descriptions(handles.indexes(2)))
set(handles.descr3, 'String', handles.descriptions(handles.indexes(3)))
set(handles.descr4, 'String', handles.descriptions(handles.indexes(4)))
set(handles.descr5, 'String', handles.descriptions(handles.indexes(5)))

set(handles.result1, 'ForegroundColor', set_colors(hObject, handles, handles.indexes(1)))
set(handles.result2, 'ForegroundColor', set_colors(hObject, handles, handles.indexes(2)))
set(handles.result3, 'ForegroundColor', set_colors(hObject, handles, handles.indexes(3)))
set(handles.result4, 'ForegroundColor', set_colors(hObject, handles, handles.indexes(4)))
set(handles.result5, 'ForegroundColor', set_colors(hObject, handles, handles.indexes(5)))

set(handles.result1, 'String', sprintf('%4.2f%%' ,handles.resultant_percentages(handles.indexes(1))))
set(handles.result2, 'String', sprintf('%4.2f%%' ,handles.resultant_percentages(handles.indexes(2))))
set(handles.result3, 'String', sprintf('%4.2f%%' ,handles.resultant_percentages(handles.indexes(3))))
set(handles.result4, 'String', sprintf('%4.2f%%' ,handles.resultant_percentages(handles.indexes(4))))
set(handles.result5, 'String', sprintf('%4.2f%%' ,handles.resultant_percentages(handles.indexes(5))))

axes(handles.axes1);
image1 = imread(sprintf('images/image%d.jpg', handles.indexes(1)));
image(image1);
axis off;
axis image;

axes(handles.axes2);
image2 = imread(sprintf('images/image%d.jpg', handles.indexes(2)));
image(image2);
axis off;
axis image;

axes(handles.axes3);
image3 = imread(sprintf('images/image%d.jpg', handles.indexes(3)));
image(image3);
axis off;
axis image;

axes(handles.axes4);
image4 = imread(sprintf('images/image%d.jpg', handles.indexes(4)));
image(image4);
axis off;
axis image;

axes(handles.axes5);
image5 = imread(sprintf('images/image%d.jpg', handles.indexes(5)));
image(image5);
axis off;
axis image;

guidata(hObject, handles);


% --- Executes when selected object is changed in sbg1.
function sbg1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.selected_skill_levels(1) = convert_val(get(get(handles.sbg1,'SelectedObject'), 'Tag'));
guidata(hObject, handles);

% --- Executes when selected object is changed in sbg2.
function sbg2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.selected_skill_levels(2) = convert_val(get(get(handles.sbg2,'SelectedObject'), 'Tag'));
guidata(hObject, handles);

% --- Executes when selected object is changed in sbg3.
function sbg3_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg3 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.selected_skill_levels(3) = convert_val(get(get(handles.sbg3,'SelectedObject'), 'Tag'));
guidata(hObject, handles);

% --- Executes when selected object is changed in sbg4.
function sbg4_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg4 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selected_skill_levels(4) = convert_val(get(get(handles.sbg4,'SelectedObject'), 'Tag'));
guidata(hObject, handles);

% --- Executes when selected object is changed in sbg5.
function sbg5_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg5 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selected_skill_levels(5) = convert_val(get(get(handles.sbg5,'SelectedObject'), 'Tag'));
guidata(hObject, handles);

% --- Executes when selected object is changed in sbg6.
function sbg6_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg6 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selected_skill_levels(6) = convert_val(get(get(handles.sbg6,'SelectedObject'), 'Tag'));
guidata(hObject, handles);

% --- Executes when selected object is changed in sbg7.
function sbg7_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg7 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selected_skill_levels(7) = convert_val(get(get(handles.sbg7,'SelectedObject'), 'Tag'));
guidata(hObject, handles);

% --- Executes when selected object is changed in sbg8.
function sbg8_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sbg8 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selected_skill_levels(8) = convert_val(get(get(handles.sbg8,'SelectedObject'), 'Tag'));
guidata(hObject, handles);


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reset_skill_levels(hObject, handles);


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.resultant_percentages = evalfis(handles.selected_skill_levels, handles.fis);

result = sort_results(hObject, handles);
handles.indexes = result;

set_second_interface(hObject, handles);

set(handles.skill_panel, 'Visible', 'Off')
set(handles.rarea_panel, 'Visible', 'Off')
set(handles.result_panel, 'Visible', 'on')

guidata(hObject, handles);


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.result_panel, 'Visible', 'off')
set(handles.skill_panel, 'Visible', 'on')
set(handles.rarea_panel, 'Visible', 'on')
