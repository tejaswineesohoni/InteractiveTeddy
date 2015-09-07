% Get list of all BMP files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
cd /Users/surabhiravishankar/Documents/MATLAB/ML_Proj/att_faces/s2;
imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);    % Number of files found
for i=1:nfiles
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   gray_scale = rgb2gray(currentimage);
   temp = imresize(gray_scale,[112 92]);
   figure 
   size(temp)
   imwrite(temp,[num2str(i),'.pgm']);
   imshow(temp)
end