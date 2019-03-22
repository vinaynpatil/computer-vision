function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)

rhos = -rho_num_bins:rho_num_bins;
thetas = (0:(pi/theta_num_bins):(theta_num_bins*pi/180));
rhoCount = numel(rhos);
thetaCount = numel(thetas);
Himg = zeros(rhoCount,thetaCount);
[inums, jnums] = size(img);

for i=1:inums
    for j=1:jnums
        if(img(i,j)>0)
            for t=1:thetaCount
                theta = thetas(t);
                r=i*cos(theta)-j*sin(theta);
                rho_index = round(r+rhoCount/2);
                Himg(rho_index,t) = Himg(rho_index,t)+1;
            end 
        end
    end
end

hough_img = (Himg./max(Himg(:)))*255;