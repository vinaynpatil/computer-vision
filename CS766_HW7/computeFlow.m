function result = computeFlow(img1, img2, win_radius, template_radius, grid_MN)

img1Original = im2double(img1);
img2 = im2double(img2);

img1 = padarray(img1,[template_radius template_radius]);
step = round(size(img1)./grid_MN);
[X,Y] = meshgrid(1:step(1,1):size(img1,1),1:step(1,2):size(img1,2));

x = zeros(size(X));
y = x;
u = x;
v = x;
for i = 1:size(X,1)
    for j = 1:size(X,2)
        x(i,j) = X(i,j);
        y(i,j) = Y(i,j);
    end
end


img2 = padarray(img2,[win_radius win_radius]);

count = 0;
offset = 1 + template_radius + win_radius;
scale = 0.5;
for i = 1:step(1,2):size(img1Original,2)
    for j = 1:step(1,1):size(img1Original,1)
        
        pattern = img1(j : j+2*template_radius, i : i+2*template_radius);
        window = img2(j:j+2*win_radius, i:i+2*win_radius);
        
        match = normxcorr2(pattern, window);
        
        [~,val] = max(match(:));
        [corry, corrx] = ind2sub(size(match),val);
        
        count = count+1;
        x(count) = i;
        y(count) = j;
        
        u(count) = corrx - offset;
        v(count) = corry - offset;
        
        u(count)=u(count)./sqrt(u(count).^2+v(count).^2);
        v(count)=v(count)./sqrt(u(count).^2+v(count).^2);
    end
end

fh1 = figure;
imshow(img1Original);
hold on
quiver(x,y,u,v,scale);
annotated_img = saveAnnotatedImg(fh1);
result = annotated_img;
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