function [ID, CP, HP, stardust, level, cir_center] = pokemon_stats (img, model)
% Please DO NOT change the interface
% INPUT: image; model(a struct that contains your classification model, detector, template, etc.)
% OUTPUT: ID(pokemon id, 1-201); level(the position(x,y) of the white dot in the semi circle); cir_center(the position(x,y) of the center of the semi circle)

[r,c] = size(img);
    
label_train = model.label_train;
stardust = 600;
CP = 200;
HP = 10;
ID = 100;
level = [1 1];
cir_center = [1 1];

    img = imresize(img, [1000 600]);
    img_cropped = img(100:500,100:500,:);

    feat = feature_extraction(img_cropped,model);
    ID = your_kNN(feat,label_train);
    [stardust, CP, HP] = detect_SD_CP_HP(img);
    level = [280*c/600 130*r/1000];
    cir_center = [310*c/600 340*r/1000];
    
end