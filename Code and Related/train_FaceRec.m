% Reading the face database 
face_db = imageSet('att_faces','recursive'); 

% Display all the faces - set of 10. 
% figure;
% montage(face_db(1).ImageLocation); 

find_person_number = 1; 
face_gallery = read(face_db(find_person_number),1); 
imshow(face_gallery);

% Partitioniing the database into training and testing 
% Dividing the training and testing data as 80% and 20% 

[training_set,test_set] = partition(face_db, [0.8,0.2]); 
p = 1; 

%Hog features for one person in the trainig set. 

[hog, hog_rep] = ... 
    extractHOGFeatures(read(training_set(p),1));

% figure; 
% Find the hog features and display it 
% subplot(2,1,1); 
% imshow(read(training_set(p),1)); title('Input Face'); 
% subplot(2,1,2); 
% plot(hog_rep); 
% title('Hog Features'); 

trained_features = zeros(size(training_set,2)*training_set(1).Count,4680); 

% Extract the hog features for the training set 
count = 1; 
for i = 1:size(training_set,2)
    for j = 1:training_set(i).Count 
        trained_features(count,:) = extractHOGFeatures(read(training_set(i),2)); 
        labels{count} = training_set(i).Description; 
        count = count+1; 
    end
pIndex{i} = training_set(i).Description;     
end

% Creating a classifier using fitcecoc
classifier = fitcecoc(trained_features,labels); 
