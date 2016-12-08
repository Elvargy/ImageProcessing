% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
% This simply reads the image file for processing
I = imread('AssignmentInput.jpg');
figure;
imshow(I);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
% This uses the MATLAB function rgb2gray function to convert the image into
% greyscale
I = rgb2gray(I);
figure;
imshow(I); %This displays the image
title('Step-2: Conversion of input image to greyscale');

% Step-3: Noise removal
% The medfilt function in MATLAB by performing a median filter in order to
% get rid of noise
I = medfilt2(I);
figure;
imshow(I); %This displays the image
title('Step-3: Noise removal');

% Step-4: Image Enhancement
I = imadjust(I); %These functions allow for the image's details to be more easily seen
I = localcontrast(I);
figure;
imshow(I); %This displays the image
title('Step-4: Image Enhancement');

% Step-5: Image Segmentation
I = imbinarize(I, 'adaptive','Sensitivity',0.7); %This turns the image into binary by replacing all of the pixels with either 0's or 1's
I = imcomplement(I); %Since the output came back with a white backgrouns and black objects, this function flips 
figure;              %those pixel values around to acheieve the output
imshow(I); %This displays the image
title('Step-5: Image Seperation');

% Step-6: Morphological Processing
I = bwareaopen(I, 14); %This removes all of the extra white dots that aren't a part of the objects.
figure;                %This is done by removing any objects with a size less than the assinged number.
imshow(I); %This displays the image.
title('Step-6: Morphological Processing');

% Step-7: Starfish Recgonition
%EASY VERSION%
BW2 = bwareafilt (I,[950 1200]); %This extracts objects with an area within the inputted range
figure;                          %Seen as the Starfish have a similar area, it didn't take long to find the correct range.
imshow(BW2); %This displays the image
title('Step-7a: Starfish Recgonition - Easy Version');

%COMPLEX VERSION%
b = bwlabel(I); %This function seeks out connected pixels (objects) and assigns a numbered label to them
% s = regionprops(b, 'Area', 'Perimeter'); %This gathers the area and perimeter of the labaled objects

% area = [s.Area]; %These functions take the information about the area and perimeter from 's' and put it into a readable matrix
% perimeter = [s.Perimeter];
% 
% display(area); %These outputs aren't needed for the final output, however it helped whilst attempting the solution
% display(perimeter); %Due to being pointless for the output, 's', 'area', and 'perimeter' and these outputs are commented out.

metric = 4*pi*area/perimeter.^2; %This gives 'metric' the formular to calculate roundness which helps with the starfish detection.

idx = find(((950 <= area) & (area <= 1200)) & ((0.05 <= metric) & (metric <= 0.15))); %This finds objects that fit into the assinged parameters 

bw2 = ismember(b, idx); %This function retuns the results of the 'idx' variable when applied to the 'b' variable
bw2 = medfilt2(bw2); %This adds another median filter just to make the starfish less 'specky' resulting in a cleaner output
figure;
imshow(bw2); %This displays the image
title('Step-7b: Starfish Recgonition - Complex Version');


% FIRST ATTEMPT AT A COMPLEX DETECTION METHOD %
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