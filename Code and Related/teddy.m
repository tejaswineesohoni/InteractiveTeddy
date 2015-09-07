% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calling the training scripts

if (~exist('trained'))
trainobject
end
trained=true;
if (~exist('trainedFace'))
train_FaceRec
end
trainedFace=true;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% intialize camera 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (~exist('camera'))
camera=webcam('FaceTime HD Camera');
end
preview(camera);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create window with the capture button
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = figure('Position',[500 500 150 80]);
pb = uicontrol(f,'Style','pushbutton','String','Capture',...
    'Callback','detectObject(snapshot(camera),bag,svmStruct,faceClassifier,personIndex,training)',...
                'Position',[30 20 100 30]);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% when the button is detected it will take a snapshot and and call the
% detectObject function 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% p = uipushtool(t,'TooltipString','Toolbar push button',...
%                  'ClickedCallback',...
%                  'detectObject(snapshot(camera),bag,svmStruct,faceClassifier,personIndex,training);');
% 
% % Set the button icon
% p.CData = icon;
%     



