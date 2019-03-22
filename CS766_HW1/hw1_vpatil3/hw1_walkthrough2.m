% -------------------------------------------------------------------------
% Part 2 - Create a Vincent van Gogh collage
% -------------------------------------------------------------------------

% Load the image "Vincent_van_Gogh.png" into memory
% img = imread(???);
img = imread('Vincent_van_Gogh.png');
% Note the image is of the type uint8, 
% and the maximum pixel value of the image is 255.
class(img)
max(img(:))

% uint8 is memory efficient. Since we will perform some arithmetic operations
% on the image, uint8 needs to be used with caution. Let's cast the image
% to double.
img = im2double(img);

class(img)
max(img(:))


% Display the image
figure, imshow(img,'InitialMagnification', 'fit');

% Separate the image into three color channels and store each channel into
% a new image

red_channel = img(:, :, 1); figure, imshow(red_channel, 'InitialMagnification', 'fit');
red_image = zeros(size(img)); red_image(:, :, 1) = red_channel; figure, imshow(red_image, 'InitialMagnification', 'fit');

%
% Similarly extract green_channel and blue_channel and create green_image
% and blue_image

%green_image = ???;
%blue_image = ???;

green_channel = img(:, :, 2); figure, imshow(green_channel, 'InitialMagnification', 'fit');
green_image = zeros(size(img)); green_image(:, :, 2) = green_channel; figure, imshow(green_image, 'InitialMagnification', 'fit');

blue_channel = img(:, :, 3); figure, imshow(blue_channel, 'InitialMagnification', 'fit');
blue_image = zeros(size(img)); blue_image(:, :, 3) = blue_channel; figure, imshow(blue_image, 'InitialMagnification', 'fit');

% Create a 1 x 4 image collage in the following arrangement
% 
% original image | red channel | green channel  | blue channel
collage_1x2 = [img, red_image, green_image, blue_image]; 
imshow(collage_1x2, 'InitialMagnification', 'fit');

% Create a 2 x 2 image collage in the following arrangement
% 
% original image | red channel
% green channel  | blue channel

%collage_2x2 = ???
% imshow(collage_2x2);

collage_2x2 = [img, red_image; green_image, blue_image]; 
imshow(collage_2x2, 'InitialMagnification', 'fit');

% Save the collage as collage.png
% imwrite(???, ???);

imwrite(collage_2x2, 'collage.png');

