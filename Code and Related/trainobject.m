%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load Image Sets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imgSets = [ imageSet(fullfile('dataset', 'Faces_easy')), ...
            imageSet(fullfile('dataset', 'laptop')), ...
            imageSet(fullfile('dataset', 'dollar_bill'))];
{ imgSets.Description } 
[imgSets.Count] 




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the feature of each image set 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 bag = bagOfFeatures(imgSets);
 
 
 
 features =[]; %contains the feature 
 output=[]; %contains the class number
 
 %loopin through each image in each set
 for j=1:3
     for i = 1:imgSets(j).Count
        img = read(imgSets(j), i);
        %appending the features
        features = [features;encode(bag, img)];
        %appending the class as an output
        output = [output;j];
     end    
 end





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multiclass SVM - One verses All 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


classes=unique(output);
[r,c] = size(features);
for k=1:3
    oneVall=[];
    %the current class will be 1 and the others will be 0
 for j=1:size(output)
    if(output(j)==classes(k))
      oneVall = [oneVall;1]; 
    else
      oneVall = [oneVall;0];  
    end
    if (size(oneVall) == size(output))
    svmStruct(k) = svmtrain(features,oneVall);
    end
 end
end



 
