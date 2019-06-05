function trackingTester(data_params, tracking_params)

mkdir (fullfile(data_params.out_dir));
img = imread(fullfile(data_params.data_dir,...
    data_params.genFname(data_params.frame_ids(1))));

rectangle = tracking_params.rect;
bin = tracking_params.bin_n;
window = [tracking_params.search_half_window_size, tracking_params.search_half_window_size];
pattern = img(rectangle(2) : rectangle(2)+rectangle(4)-1, rectangle(1) : rectangle(1)+rectangle(3)-1, :);
[X, cmap] = rgb2ind(pattern, bin);
histCount = histcounts(X(:), bin);

for i = 1:size(data_params.frame_ids, 2)
    img = imread(fullfile(data_params.data_dir,...
        data_params.genFname(data_params.frame_ids(i))));
    [r,c,~] = size(img);
    r1 = max(1,rectangle(2)-window(2));
    r2 = min(r,rectangle(2)+rectangle(4)+window(2))-1;
    c1 = max(1,rectangle(1)-window(1));
    c2 = min(c,rectangle(1)+rectangle(3)+window(1))-1;
    
    current = img(r1:r2, c1:c2,:);
    allChannels(:,:,1) = im2col(current(:,:,1), [rectangle(4), rectangle(3)]);
    allChannels(:,:,2) = im2col(current(:,:,2), [rectangle(4), rectangle(3)]);
    allChannels(:,:,3) = im2col(current(:,:,1), [rectangle(4), rectangle(3)]);
    
    for j = 1:size(allChannels, 2)
        U(:,j) = rgb2ind(allChannels(:,j,:),cmap);
        HC_U(:,j) = histcounts(U(:,j), bin);
    end
    
    match = normxcorr2(histCount', HC_U);
    [~, maxi] = find(match == max(match(:)));
    maxi = mean(maxi);
    
    component = size(current, 1)-rectangle(4)+1;
    first = floor(maxi / component)+1+c1;
    second = round(mod(maxi,component)+r1);
    rectangle(1) = first;
    rectangle(2) = second;
    
    result = drawBox(img, [first second rectangle(3) rectangle(4)], [0 0 255], 1);
    imshow(result);
    imwrite(result, fullfile(data_params.out_dir, data_params.genFname(data_params.frame_ids(i))));
end
end