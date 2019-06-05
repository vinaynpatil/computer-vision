function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)

%Getting the full directory name
directory_name = fullfile(focal_stack_dir, 'frame*.jpg');
%Getting all files in the directory
directory_files = dir(directory_name);
%Computing the size of the images inside the directory
sample_image = strcat(focal_stack_dir,'/',directory_files(1).name);
image_size = size(imread(sample_image));
k = length(directory_files);
%Initializing the return values
rgb_stack = uint8(zeros(image_size(1),image_size(2),k*3));
gray_stack = uint8(zeros(image_size(1),image_size(2),k));

%Iterating through all the images
RGB_left = 1;
for i = 1:k
    image_name = strcat(focal_stack_dir,'/',directory_files(i).name);
    RGB_right = i*3;
    rgb_stack(:,:,RGB_left:RGB_right) = imread(image_name);
    gray_stack(:,:,i) = rgb2gray(imread(image_name));
    RGB_left = RGB_right + 1;
end