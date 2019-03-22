function [db, out_img] = compute2DProperties(orig_img, labeled_img)
no_of_objects=max(labeled_img(:));
db = zeros(6,no_of_objects);
for i=1:no_of_objects
  [x,y] = find(labeled_img == i);
  
  x_co_ordinate = round(mean(x));
  y_co_ordinate = round(mean(y));
  
  db(1,i) = i;
  db(2,i) = x_co_ordinate;
  db(3,i) = y_co_ordinate;
  
  a = sum((x - x_co_ordinate).^2);
  b = 2*(sum((x - x_co_ordinate).*(y - y_co_ordinate)));
  c = sum((y - y_co_ordinate).^2);
  orientation = atan2(b, a - c)/2;
  orientation_degree = orientation*180/pi;
  
  minimum_moment = a*(sin(orientation)^2) - b*sin(orientation)*cos(orientation) + c*(cos(orientation)^2);
  
  db(4,i) = minimum_moment;
  db(5,i) = orientation_degree;
  
  orientation2 = orientation + pi/2;
  maximum_moment = a*(sin(orientation2)^2) - b*sin(orientation2)*cos(orientation2) + c*(cos(orientation2)^2);
    
  db(6,i) = minimum_moment/maximum_moment;
  
  high_x = max(x);
  low_x = min(x);
  high_y = max(y);
  low_y = min(y);
  
  bounded_area = (high_x - low_x)*(high_y - low_y);
  
  db(7,i) = bounded_area; 
  
  fh1 = figure();
  imshow(orig_img);
  length = 100;
  hold on; 
  plot(db(3,:), db(2,:),  'h', 'MarkerFaceColor', [1 .6 .6]);

  
  for q=1:no_of_objects
      orientation_radians = db(5,q)*pi/180;
      point_x1 = db(2,q);
      point_y1 = db(3,q);
      point_x2 = cos(orientation_radians)*length + point_x1;
      point_y2 = sin(orientation_radians)*length + point_y1;
      plot([point_y1 point_y2], [point_x1 point_x2],'r');
  end

  out_img = saveAnnotatedImg(fh1);  
end
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