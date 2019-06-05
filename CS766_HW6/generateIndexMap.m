function index_map = generateIndexMap(gray_stack, w_size)

focus = zeros(size(gray_stack));
%Laplacian and Average filters
laplacian_filter = fspecial('laplacian');
average_filter = fspecial('average',2*w_size); 

for image = 1:size(gray_stack,3)
    after_laplacian = imfilter(gray_stack(:,:,image),laplacian_filter);
    after_average = imfilter(after_laplacian, average_filter);
    focus(:,:,image) = after_average;
end

%Finding the layer with the maximal focus measure for each scene point
[~, index_map] = max(focus, [], 3);