Challenge1b 
-----------
For the thetha I used pi, so that I get broad set of angles between 0 and pi in the increments of (pi/thetabins)

I used rho bins as 800. I calculated this as follows, the max value for r (in positive direction) would be to the corner of the image (from the origin). 
Which I solved using Pythagorean theorem - ceil(sqrt(sum(size(img).^2))) and ended up with a range of -800:+800

For voting in Accumulator, for each negative rho value for a theta I voted for its postive equivalent which I was easily able to retrieve back while 
drawing the lines in the next part

The set of these above values seemed to work the best, which I varified empirically.

Challenge1c
-----------
I used standard threshold method for the Hough, i.e. I considered the top 50%, 40% and 23% for the 3 hough images respectively. I came up with these numbers 
empirically by trying various thresholds.

Challenge1d
-----------
The main challenge here was to determine where each line should start and where should it end, to get this imformation I made use of the edge image. Initially 
for each theta and rho pairs I determined the start point that match the edge image, which was done by finding a point from which there are max consecutive 
non zeros (To mitigate false positives) and in a similar fashion determined the end by recognizing the continuous sequence of zeros. And considering these as the 
start and end points drew a line through the intermediate points. And repeated this procedure for each rho and theta pairs.