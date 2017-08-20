function predict_label = your_kNN(feat,label_train)
% Output should be a fixed length vector [num of img, 1]. 
% Please do NOT change the interface.

%k is the number of nearest neighbor considered
k = 13;

model = load('model.mat');
histFeatures = model.histFeatures;
dis = zeros(size(histFeatures,1),1);

for i=1:size(feat,1)
    imgHist = feat(i,:);
    for j=1:size(histFeatures,1)
        dis(j) = sqrt(sum((histFeatures(j,:) - imgHist) .^ 2));
    end
    [disSorted,idx]=sort(dis);
    predict_label = label_train(idx(1));
    
end
