trainPortion = .7;
validPortion =.3;
load './variables/myFeaturesP1.mat';
tMyFeatures= myFeatures;
[trainIndices, ValidationIndices]= dividerand(size(tMyFeatures,2),trainPortion,validPortion,0);
myFeatures=tMyFeatures(trainIndices);
save './variables/myFeaturesTrainP1.mat' myFeatures;
myFeatures=tMyFeatures(ValidationIndices);
save './variables/myFeaturesValidationP1.mat' myFeatures;

load './variables/myFeaturesP2.mat';
tMyFeatures= myFeatures;
[trainIndices, ValidationIndices]= dividerand(size(tMyFeatures,2),trainPortion,validPortion,0);
myFeatures=tMyFeatures(trainIndices);
save './variables/myFeaturesTrainP2.mat' myFeatures;
myFeatures=tMyFeatures(ValidationIndices);
save './variables/myFeaturesValidationP2.mat' myFeatures;

load './variables/myFeaturesP3.mat';
tMyFeatures= myFeatures;
[trainIndices, ValidationIndices]= dividerand(size(tMyFeatures,2),trainPortion,validPortion,0);
myFeatures=tMyFeatures(trainIndices);
save './variables/myFeaturesTrainP3.mat' myFeatures;
myFeatures=tMyFeatures(ValidationIndices);
save './variables/myFeaturesValidationP3.mat' myFeatures;