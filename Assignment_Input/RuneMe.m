% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
I = imread('AssignmentInput.jpg');
figure;
imshow(I);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
I = rgb2gray(I);
figure;
imshow(I);
title('Step-2: Conversion of input image to greyscale');

% Step-3: Noise removal
I = medfilt2(I);
figure;
imshow(I);
title('Step-3: Noise removal');

% Step-4: Image Enhancement
I = imadjust(I);
I = localcontrast(I);
figure;
imshow(I);
title('Step-4: Image Enhancement');

% Step-5: Image Seperation
I = imbinarize(I, 'adaptive','Sensitivity',0.7);
I = imcomplement(I);
figure;
imshow(I);
title('Step-5: Image Seperation');

% Step-6: Morphological Processing
I = bwareaopen(I, 14);
figure;
imshow(I);
title('Step-6: Morphological Processing');

% Step-7: Starfish Recgonition
%EASY VERSION%
BW2 = bwareafilt (I,[950 1200]);
figure;
imshow(BW2);
title('Step-7a: Starfish Recgonition - Easy Version');

%COMPLEX VERSION%
b = bwlabel(I);
s = regionprops(b, 'Area', 'Perimeter');

area = [s.Area];
perimeter = [s.Perimeter];
metric = 4*pi*area/perimeter.^2;

% display(area);

idx = find(((950 <= area) & (area <= 1200)) & ((0.05 <= metric) & (metric <= 0.15)));

bw2 = ismember(b, idx);
figure;
imshow(bw2);
title('Step-7b: Starfish Recgonition - Complex Version');


% ATTEMPT AT ANOTHER DETECTION METHOD %
% [label, num] = bwlabel(I, 8);
% region = regionprops(I,'Area', 'Perimeter');
% metric = [];
% 
% 
% for k = 1:length(label)
%   
%   metric = [metric;[4*pi*region(k).Area/region(k).Perimeter^2]];
%     
% end
% 
% finder = find(metric < 0.26);
% result = ismember(label, finder);
% 
% figure;
% imshow(result);
% title('Step-7: Starfish Recgonition');