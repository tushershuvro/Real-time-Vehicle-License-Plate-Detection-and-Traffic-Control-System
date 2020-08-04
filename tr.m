function varargout = tr(varargin)
% TR MATLAB code for tr.fig
%      TR, by itself, creates a new TR or raises the existing
%      singleton*.
%
%      H = TR returns the handle to a new TR or the handle to
%      the existing singleton*.
%
%      TR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TR.M with the given input arguments.
%
%      TR('Property','Value',...) creates a new TR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tr_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tr

% Last Modified by GUIDE v2.5 11-Feb-2020 23:52:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tr_OpeningFcn, ...
                   'gui_OutputFcn',  @tr_OutputFcn, ...
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


% --- Executes just before tr is made visible.
function tr_OpeningFcn(hObject, eventdata, handles, varargin)
global vid;
global d;
d.MyData=[];



% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tr (see VARARGIN)

% Choose default command line output for t
handles.output = hObject;

vid= videoinput('winvideo', 2);
handles.vid = vid;
axes(handles.axes1);
hImage=image(zeros(200,288,3),'parent',handles.axes1);
preview(vid,hImage);

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes tr wait for user response (see UIRESUME)
% uiwait(handles.main);


% --- Outputs from this function are returned to the command line.
function varargout = tr_OutputFcn(hObject, eventdata, handles) 



% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global b a ;

a = arduino('COM3', 'Uno', 'Libraries', 'Servo');
% b = servo(a, 'D4' );
%  clear b;
% % %s = servo(a, 'D5', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6)
% % %s = servo(a,'D5','MaxPulseDuration',2.4e-3,'MinPulseDuration',1e-3)
 b = servo(a,'D4','MaxPulseDuration',2e-3,'MinPulseDuration',1e-3) % best gor servo g960
 

% --- Executes when user attempts to close main.
function main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pullup.

function pullup_Callback(hObject, eventdata, handles)
global  b ;

for angle = 0:0.2:1 %write 0 degree
    writePosition(b, angle);
    current_pos = readPosition(b);
    current_pos = current_pos*180;
%     fprintf('Current motor position is %d degrees\n', current_pos);
end
clear b 
% hObject    handle to pullup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pulldown.
function pulldown_Callback(hObject, eventdata, handles)
global  b ;
for angle = 1:-0.2:0 %write 180 degree
    writePosition(b, angle);
    current_pos = readPosition(b);
    current_pos = current_pos*180;
%     fprintf('Current motor position is %d degrees\n', current_pos);

   
end

clear b 




% hObject    handle to pulldown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in snapshot.
function snapshot_Callback(hObject, eventdata, handles)
global s ;
s=getsnapshot(handles.vid);
axes(handles.axes2);
imshow(s,'parent',handles.axes2);

% hObject    handle to snapshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
cla(handles.axes2,'reset');


% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveimg.
function saveimg_Callback(hObject, eventdata, handles)
global s;
%imwrite(s,'C:\Users\Tusher shuvro\Desktop\project\daile car pass\new.jpg','jpg');
[filename, foldername] = uiputfile('*.jpg');
complete_name = fullfile(foldername, filename);
imwrite(s, complete_name);

% hObject    handle to saveimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function results_Callback(hObject, eventdata, handles)


% hObject    handle to results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of results as text
%        str2double(get(hObject,'String')) returns contents of results as a double


% --- Executes during object creation, after setting all properties.
function results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in licenceextract.
function licenceextract_Callback(hObject, eventdata, handles)

global s ;
s=getsnapshot(handles.vid);
axes(handles.axes2);
imshow(s,'parent',handles.axes2);

% prompt={'Enter the number of charcters to read:'};
%     dlg_title = 'Number of Characters';
%     num_lines = 1;
%     def = {''};
%     answer = inputdlg(prompt,dlg_title,num_lines,def);
%     no = str2num(answer{1});
%NUMBERPLATEEXTRACTION extracts the characters from the input number plate image.
%select image from folder 
% 
% [filename,filepath]=uigetfile({'*.jpg'},'Select and image');
% f = imread(strcat(filepath, filename));


%f=imread('C:\Users\Tusher shuvro\Desktop\project\nmplate image\carplate2.jpg'); % Reading the number plate image.

% Resizing the image keeping aspect ratio same.
 f=imresize(s,[400 NaN]);
 g=rgb2gray(f); % Converting the RGB (color) image to gray (intensity).
 g=medfilt2(g,[3 3]); % Median filtering to remove noise.
 se=strel('disk',1); % Structural element (disk of radius 1) for morphological processing.
 gi=imdilate(g,se); % Dilating the gray image with the structural element.
 ge=imerode(g,se); % Eroding the gray image with structural element.
 
 gdiff=imsubtract(gi,ge); % Morphological Gradient for edges enhancement.
 gdiff=mat2gray(gdiff); % Converting the class to double.
 gdiff=conv2(gdiff,[1 1;1 1]); % Convolution of the double image for brightening the edges.
 gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1); % Intensity scaling between the range 0 to 1.
 B=logical(gdiff); % Conversion of the class from double to binary.
 [a1 b1]=size(B);

% % Eliminating the possible horizontal lines from the output image of regiongrow
% % that could be edges of license plate.
 er=imerode(B,strel('line',50,0));
 out1=imsubtract(B,er);
% % Filling all the regions of the image.
 F=imfill(out1,'holes');
% % Thinning the image to ensure character isolation.
 H=bwmorph(F,'thin',1);
 H=imerode(H,strel('line',3,90));

% % Selecting all the regions that are of pixel area more than 100.
%  final =bwareaopen(H,300);
 
I=bwareaopen(H,floor((a1/15)*(b1/15)));
I(1:floor(.9*a1),1:2)=1;
I(a1:-1:(a1-20),b1:-1:(b1-2))=1;

js=imresize(I,[100 NaN]);
axes(handles.axes3)
imshow(js,'parent',handles.axes3);
%show message what tupes of char yo need  extrat
% prompt={'Enter the number of charcters to read:'};
%     dlg_title = 'Number of Characters';
%     num_lines = 1;
%     def = {''};
%     answer = inputdlg(prompt,dlg_title,num_lines,def);
%     no=str2num(answer{1}); %#ok<ST2NM>
 no=(6);
 no=(7);
%% seperating each character of the filtered image
Iprops=regionprops(I,'BoundingBox','Image');% drawing boundary box around each connected component in the image



NR=cat(1,Iprops.BoundingBox);% string of all boundary boxes, the properties in the string are x coordinate,y coordinate, x width, y width

r=controlling(NR,no);

if ~isempty(r) 
    I={Iprops.Image};
    noPlate=[]; 
    for v=1:length(r)
        N=I{1,r(v)}; % trying to locate the connected component from teh binary image corresponding to each bounding boxes
        letter=readLetter(N); 
        while letter=='O' || letter=='0' 
            if v<=3                      
                letter='O';              
            else                         
                letter='0';              
            end                          
            break;                       
        end
        while letter == 'Z' || letter == '2'
            if v<=3
                letter = 'Z';
            else
                letter ='2';
            end
            break;
        end
        noPlate =[noPlate letter]; 
        fid = fopen('noPlate.txt', 'wt'); % This portion of code writes the number plate
        fprintf(fid,'%s\n',noPlate);      % to the text file, if executed a notepad file with the
        fclose(fid);                      % name noPlate.txt will be open with the number plate written.
    end
    set(handles.display,'string',noPlate);
    set(handles.displaya,'string',noPlate);
else
    msgbox('Unable to extract the characters from the number plate.');
    msgbox('The characters on the number plate might not be clear or touching with each other or boundries.\n');
end


function carwoner_Callback(hObject, eventdata, handles)
% hObject    handle to carwoner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of carwoner as text
%        str2double(get(hObject,'String')) returns contents of carwoner as a double


% --- Executes during object creation, after setting all properties.
function carwoner_CreateFcn(hObject, eventdata, handles)
% hObject    handle to carwoner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function carname_Callback(hObject, eventdata, handles)
% hObject    handle to carname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of carname as text
%        str2double(get(hObject,'String')) returns contents of carname as a double


% --- Executes during object creation, after setting all properties.
function carname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to carname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function carmodel_Callback(hObject, eventdata, handles)
% hObject    handle to carmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of carmodel as text
%        str2double(get(hObject,'String')) returns contents of carmodel as a double


% --- Executes during object creation, after setting all properties.
function carmodel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to carmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveinfo.
function saveinfo_Callback(hObject, eventdata, handles)
%h=findobj('tag','table')
global d;
carwonerData =get(handles.carwoner,'string');
carnameData =get(handles.carname,'string');
carmodelData =get(handles.carmodel,'string');
carlicenceData=get(handles.displaya,'string');
d.MyData =[d.MyData;[{carwonerData},{carnameData},{carmodelData},{carlicenceData}]];
%set(handles.uitable,'Data',d.MyData);

xlswrite('C:\Users\tusher shuvro\Desktop\project 1222020\database\curent data',d.MyData);

 


% hObject    handle to saveinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
cla(handles.axes3,'reset');

set([handles.carwoner,handles.carname,handles.carmodel,handles.displaya,handles.display],'String', ''); % Clear edit field control with tag "edit1"
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function displaya_Callback(hObject, eventdata, handles)
% hObject    handle to displaya (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of displaya as text
%        str2double(get(hObject,'String')) returns contents of displaya as a double


% --- Executes during object creation, after setting all properties.
function displaya_CreateFcn(hObject, eventdata, handles)
% hObject    handle to displaya (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function display_Callback(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of display as text
%        str2double(get(hObject,'String')) returns contents of display as a double


% --- Executes during object creation, after setting all properties.
function display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in green.
function green_Callback(hObject, eventdata, handles)
global a;
writeDigitalPin(a,'D13',0);
writeDigitalPin(a,'D12',1);
clear a;
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
global a;
writeDigitalPin(a,'D13',1);
writeDigitalPin(a,'D12',0);
clear a;

% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bangla.
function bangla_Callback(hObject, eventdata, handles)
% 
% global s ;
% s=getsnapshot(handles.vid);
% axes(handles.axes2);
% imshow(s,'parent',handles.axes2);
[filename,filepath]=uigetfile({'*.*';'*.jpg';'*.bmp'},'Select and image');
f = imread(strcat(filepath, filename));
%########################################
% f=imresize(f,[400 NaN]);
imgray = rgb2gray(f);
% imgray=medfilt2(imgray);
imbin = im2bw(imgray); %#ok<IM2BW>
im = edge(imgray, 'prewitt'); 

%Below steps are to find location of number plate
Iprops=regionprops(im,'BoundingBox','Area', 'Image');

area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
      boundingBox=Iprops(i).BoundingBox;
   end
end    

im = imcrop(imbin, boundingBox);%crop the number plate area
im = bwareaopen(~im, 200); %remove some object if it width is too long or too small than 500

Z=imresize(im,[100 NaN]);
axes(handles.axes3);
imshow(Z,'parent',handles.axes3);

Iprops=regionprops(im,'BoundingBox','Area', 'Image'); %read letter
hold on
for n=1:size(Iprops,1)
    rectangle('position',Iprops(n).BoundingBox,'EdgeColor','b');
end
hold off

NR=cat(1,Iprops.BoundingBox);% string of all boundary boxes, the properties in the string are x coordinate,y coordinate, x width, y width

%############
%  prompt={'Enter the number of charcters to read:'};
% 
%         dlg_title = 'Number of Characters';
% 
%        num_lines = 1;
%         def = {'0'};
% 
%     answer = inputdlg(prompt,dlg_title,num_lines,def);
% 
%     no = str2num(answer{1});

no=(9);
r=controllingb(NR,no);
if ~isempty(r) 
    I={Iprops.Image};
    noPlate=[]; 
    for v=1:length(r)
        N=I{1,r(v)}; % trying to locate the connected component from teh binary image corresponding to each bounding boxes
        letter=readLetterb(N); 
        while letter=='O' || letter=='0' 
            if v<=3                      
                letter='O';              
            else                         
                letter='0';              
            end                          
            break;                       
        end
%         while letter == 'H' || letter == '2'
%             if v<=3
%                 letter = 'H';
%             else
%                 letter ='2';
%             end
%             break;
%         end
        noPlate=[noPlate letter]; 
        fid = fopen('noPlate.txt', 'wt'); % This portion of code writes the number plate
        fprintf(fid,'%s\n',noPlate);      % to the text file, if executed a notepad file with the
        fclose(fid);                      % name noPlate.txt will be open with the number plate written.
    end
     
    set(handles.display,'string',noPlate);
    set(handles.displaya,'string',noPlate);
 
else
    msgbox('Unable to extract the characters from the number plate.');
    msgbox('The characters on the number plate might not be clear or touching with each other or boundries.\n');
end









% hObject    handle to bangla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
