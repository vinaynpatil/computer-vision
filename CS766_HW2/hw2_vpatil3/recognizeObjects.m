function output_img = recognizeObjects(orig_img, labeled_img, obj_db)

[temp_obj_db, temp_out_img] = compute2DProperties(orig_img, labeled_img);

fh1 = figure();
roundness_diff = 0.03;
bounded_area_diff = 600;
matched_temps = [];

temp_size = size(temp_obj_db,2)
obj_size = size(obj_db,2) 

for i=1:temp_size
    temp_roundness = temp_obj_db(6,i);
    temp_bounded_area = temp_obj_db(7,i);
    
    for j=1:obj_size
        obj_roundness = obj_db(6,j);
        obj_bounded_area = obj_db(7,j);
        
        if abs(temp_bounded_area - obj_bounded_area) > bounded_area_diff
             continue
        end
        
        if abs(temp_roundness - obj_roundness) > roundness_diff
             continue
        end
        
        matched_temps = [matched_temps; i];
        
    end
end

imshow(orig_img);

matched_size = size(matched_temps, 1);
length = 100;
for index = 1:matched_size
    q = matched_temps(index);
    
    hold on; 
    plot(temp_obj_db(3,q), temp_obj_db(2,q),  'h', 'MarkerFaceColor', [1 .6 .6]);
    
    orientation_radians = deg2rad(temp_obj_db(5,q));
    point_x1 = temp_obj_db(2,q);
    point_y1 = temp_obj_db(3,q);
    point_x2 = cos(orientation_radians)*length + point_x1;
    point_y2 = sin(orientation_radians)*length + point_y1;
    plot([point_y1 point_y2], [point_x1 point_x2],'r');

end
output_img = saveAnnotatedImg(fh1);
end


function annotated_img = saveAnnotatedImg(fh)
figure(fh); % Shift the focus back to the figure fh

% The figure needs to be undocked
set(fh, 'WindowStyle', 'normal');

% The following two lines just to make the figure true size to the
% displayed image. The reason will become clear later.
img = getimage(fh);
truesize(fh, [size(img, 1), size(img, 2)]);

% getframe does a screen capture of the figure window, as a result, the
% displayed figure has to be in true size. 
frame = getframe(fh);
frame = getframe(fh);
pause(0.5); 
% Because getframe tries to perform a screen capture. it somehow 
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround. 
annotated_img = frame.cdata;
end