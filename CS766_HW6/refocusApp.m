function refocusApp(rgb_stack, depth_map)

%Showing the first image
RGB_left = 1;
RGB_right = 3;
imshow(rgb_stack(:, :, RGB_left:RGB_right));

%Getting the selected point
point = ceil(ginput(1));
point_x = point(2);
point_y = point(1);

while 1 <= point_x &&  1 <= point_y && point_x <= size(rgb_stack,1) && point_y <= size(rgb_stack,2)
    level = depth_map(point_x, point_y);
    RGB_left = 1 + (level-1)*3;
    RGB_right = level*3;
    %Showing the new image based on selection
    imshow(rgb_stack(:,:,RGB_left:RGB_right));
    
    %Getting new points
    point = ceil(ginput(1));
    point_x = point(2);
    point_y = point(1);
end