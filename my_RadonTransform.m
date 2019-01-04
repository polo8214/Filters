function R = my_RadonTransform(img, theta)
tic
% to prevent the distortion of rotation, padding the image first
[x, y] = size(img);
cross = sqrt(x^2 + y^2);
a = ceil(cross/2 - x/2) + 2;
b = ceil(cross/2 - y/2) + 2;
pad_img = padarray(img,[a b],0,'both');

%Loop to rotate image and add up values for the projections
n = length(theta);
R = zeros(size(pad_img,2), n);
for i = 1:n
   rotimg = imrotate(pad_img, theta(i), 'nearest', 'crop');
   R(:,i) = (sum(rotimg))';
end
toc