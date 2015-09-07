function detectObject(snapshot,bag,svmStruct,faceClassifier,personIndex,training) 
if ~isempty(snapshot)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process the caputed image (snapshot)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 test = snapshot;
 test = imresize(test,0.25);

 imwrite(test,'test.jpg');
 
 %getting the fetures of the snapshot
 fvtest = encode(bag, test);

 % Plot the histogram of visual word occurrences
% figure
% bar(fvtest)
% title('Visual word occurrences')
% xlabel('Visual word index')
% ylabel('Frequency of occurrence')

 result = 0;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% classify the image using SVM 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%classify test cases (3 classes)
    for k=1:3
        if(svmclassify(svmStruct(k),fvtest(1,:))) 
            break;
        end
    end
    result = k

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output the audio depending of the recognized class
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (result == 1)
    Recognize_Face(classifier,pIndex,training_set);
    [y,Fs] = audioread('sound/rawan.m4a');
    sound(y,Fs)
% elseif (result == 2)
%     Recognize_Face(faceClassifier,personIndex,training);
%     [y,Fs] = audioread('sound/touch.m4a');
%     sound(y,Fs)
% elseif (result == 3)
%     Recognize_Face(faceClassifier,personIndex,training);
%     [y,Fs] = audioread('sound/money.m4a');
%     sound(y,Fs)
end

end

 
 %cp =classperf(output)
%classperf(cp,g,test);cp.CorrectRate
 

% 
% categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Evaluate Classifier Performance
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% confMatrix = evaluate(categoryClassifier, trainingSets);
% 
% confMatrix = evaluate(categoryClassifier, validationSets);
% 
% % Compute average accuracy
% mean(diag(confMatrix));
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Try the Newly Trained Classifier on Test Images
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% img = imresize(imread(fullfile('lappy.jpg')),0.1);
% [labelIdx, scores] = predict(categoryClassifier, img);
% 
% % Display the string label
% categoryClassifier.Labels(labelIdx)
% 
% 
% 
% 
% 
% 
