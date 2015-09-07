% % Process images 
% cd /Users/surabhiravishankar/Documents/MATLAB/ML_Proj/att_faces/s0;
% imagefiles = dir('*.jpg');      
% nfiles = length(imagefiles);    % Number of files found
% for i=1:nfiles
%    currentfilename = imagefiles(i).name;
%    currentimage = imread(currentfilename);
%    gray_scale = rgb2gray(currentimage);
%    temp = imresize(gray_scale,[112 92]);
%    figure 
%    imshow(temp)
% end
% load images from the att face database 

faceDatabase = imageSet('/Users/surabhiravishankar/Documents/MATLAB/ML_Proj/att_faces','recursive'); 
figure;
montage(faceDatabase(1).ImageLocation); 
title('Single Face')

personToQuery = 1; 
galleryImage = read(faceDatabase(personToQuery),1); 

%imshow(galleryImage);

%Dividing the training and testing data 
% for i = 1:size(faceDatabase,2)
%     [training, test] = partition(faceDatabase, [0.8,0.2]); 
% end

% Partitioniing the database into training and testing 
% 
% Dividing the training and testing data 

[training, test] = partition(faceDatabase, [0.8,0.2]); 
person = 1; 

%Hog features for one person in the trainig set. 

[hofFeatures, visualization] = ... 
    extractHOGFeatures(read(training(person),1));
figure; 

%Find the hog features and display it 
subplot(2,1,1); 
imshow(read(training(person),1)); title('Input Face'); 
subplot(2,1,2); 
plot(visualization); 
title('Hog Features'); 

% Extract the hog features for the training set 
trainingFeatures = zeros(size(training,2)*training(1).Count,4680); 

featureCount = 1; 
for i = 1:size(training,2)
    for j = 1:training(i).Count 
        trainingFreatures(featureCount,:) = extractHOGFeatures(read(training(i),2)); 
        trainingLabel{featureCount} = training(i).Description; 
        featureCount = featureCount+1; 
    end
personIndex{i} = training(i).Description;     
end
    

% Creating a 40 class classifier using fitcecoc

faceClassifier = fitcecoc(trainingFeatures,trainingLabel); 

% test images from the test set 
% Process one image and test 

currentimage = imread('test.jpg');
gray_scale = rgb2gray(currentimage);
temp = imresize(gray_scale,[112 92]);
imwrite(temp,'test.pgm');
figure; 
imshow(temp);title('temp')

%person = 1;
queryImage = read(test(person),1); 
% queryImage = imread('test.pgm'); 
queryFeatures = extractHOGFeatures(queryImage);                                             
personLabel = predict(faceClassifier, queryFeatures); 
% Mapping back to teh training set to find the identitiy 
booleanIndex = strcmp(personLabel, personIndex); 
integerIndex = find(booleanIndex); 
figure; 
subplot(1,2,1); imshow(queryImage); title('test query face'); 
subplot(1,2,2); imshow(read(training(integerIndex),1)); title('matched class') 


%Testing the classifier for more than one person 
%figure;
% figureNum = 1; 
% for person = 1:5
%     for j = 1:test(person).Count
%         queryImage = read(test(person),j);
%         queryFeatures = extractHOGFeatures(queryImage); 
%         personLabel = predict(faceClassifier,queryFeatures); 
%         % Mapping back to the database 
%         booleanIndex = strcmp(personLabel, personIndex); 
%         integerIndex = find(booleanIndex); 
%         figure;
%         subplot(2,2,figureNum); imshow(imresize(queryImage,3)); title('test query face'); 
%         subplot(2,2,figureNum+1); imshow(imresize(read(training(person),j),3)); title('matched class');   
%     end
% end


