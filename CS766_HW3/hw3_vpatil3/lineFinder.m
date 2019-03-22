function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)

peakValue = max(hough_img(:));
indexes = hough_img >= hough_threshold*peakValue;
count = sum(indexes(:));
theta_rho = zeros(count,2);
[inums, jnums] = size(indexes);
thetas = 0:(pi/180):pi;
iter = 1;
offSet = 801;

fh1 = figure();
imshow(orig_img);
hold on;

for i=1:inums
    for j=1:jnums
        if (indexes(i,j) >0)
            theta_rho(iter,:) = [thetas(j), i-offSet];
            iter = iter +1;
        end
    end
end

for i=1:size(theta_rho,1)
    y1 = (cos(theta_rho(i,1))/sin(theta_rho(i,1)))*1 -(theta_rho(i,2)/sin(theta_rho(i,1)));
    p=1;
    for j=3:2:size(orig_img,1)
        y2 = (cos(theta_rho(i,1))/sin(theta_rho(i,1)))*(j) -(theta_rho(i,2)/sin(theta_rho(i,1)));
        hold on; 
        line([y1,y2], [p,j],'LineWidth',1, 'Color', [0, 0, 1]);
        y1 = y2;
        p=j;
    end
end

line_detected_img = saveAnnotatedImg(fh1);

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
