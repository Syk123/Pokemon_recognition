function [SD_val, CP_val, HP_val] = detect_SD_CP_HP(img)

%I = imread('train/004_CP12_HP10_SD2436_4378_2.png');
I = rgb2gray(img);
[h,s,v] = rgb2hsv(img);
I = imresize(I,[1000 600]);
SD_val = 200;
CP_val = 10;
HP_val = 10;

x = load('templates.mat');

SD_template = x.SD_template;
C_SD = normxcorr2(SD_template, I);

C_SD(1:750,:)=0;
[ypeak, xpeak] = find(C_SD==max(C_SD(:)));
yoffSet = ypeak-size(SD_template,1);
xoffSet = xpeak-size(SD_template,2);

SD_value = I(yoffSet:ypeak, xpeak+8:xpeak+85);
SD_value = imgaussfilt(SD_value, 0.5);
imshow(SD_value);

SD_val = recognize_digits(SD_value,0);



CP_template = x.CP_template;
%imshow(CP_template);


C_CP_temp = normxcorr2(CP_template, I);
C_CP = zeros(size(C_CP_temp));
C_CP(40:180,130:445) = C_CP_temp(40:180,130:445);

[ypeak, xpeak] = find(C_CP==max(C_CP(:)));
yoffSet = ypeak-size(CP_template,1);
xoffSet = xpeak-size(CP_template,2);
CP_value = I(yoffSet-20:ypeak+5, xpeak+5:xpeak+130);
CP_value = imgaussfilt(CP_value, 1);
CP_value = imresize(CP_value,0.5);
%imshow(CP_value);
CP_val = recognize_digits(CP_value,0.9);

HP_template = x.HP_template;
HP_first_template = x.HP_first_template;
C_HP_temp = normxcorr2(HP_template,I);
C_HP = zeros(size(C_HP_temp));
C_HP(410:590,120:490) = C_HP_temp(410:590,120:490);
C_first_HP_temp = normxcorr2(HP_first_template,I);
C_first_HP = zeros(size(C_first_HP_temp));
C_first_HP(410:590,120:490) = C_first_HP_temp(410:590,120:490);

if max(C_HP(:))>max(C_first_HP(:))
    [ypeak, xpeak] = find(C_HP==max(C_HP(:)));
    yoffSet = ypeak-size(HP_template,1);
    xoffSet = xpeak-size(HP_template,2);
    HP_value = I(yoffSet:ypeak, xpeak-45:xpeak-29);
else
    [ypeak, xpeak] = find(C_first_HP==max(C_first_HP(:)));
    yoffSet = ypeak-size(HP_first_template,1);
    xoffSet = xpeak-size(HP_first_template,2);
    HP_value = I(yoffSet:ypeak, xpeak:xpeak+30);
end
HP_value = imgaussfilt(HP_value,1);
%imshow(HP_value);
HP_val = recognize_digits(HP_value,0.7);

% save('templates.mat','HP_first_template','-append');
%  
%  save('templates.mat','CP_template','-append');
% 
