function Recognize_Face(classifier,pIndex,training_set)

% test images from the test set 
% Process one image and test 

currentimage = imread('test.jpg');
gray_scale = rgb2gray(currentimage);
temp = imresize(gray_scale,[112 92]);
imwrite(temp,'test.pgm');

%person = 1;
%search_image = read(test_set(person),1); 

search_image = imread('test.pgm'); 
search_features = extractHOGFeatures(search_image);                                             
l = predict(classifier, search_features); 

% Mapping back to the traing training set to find the identical class
b_val = strcmp(l, pIndex);
ind = find(b_val);

%DISPLAY MATCHED IMAGE 
% figure; 
% subplot(1,2,1); imshow(search_image); title('Rawan - test image'); 
% subplot(1,2,2); imshow(read(training_set(ind),1)); title('Matched Class of Image') 