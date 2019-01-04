function img_output = my_lee_filter(img,size)

img = double(img);
img_means = imfilter(img, fspecial('average', size), 'replicate');      %Kmean
img_sqr_mean = imfilter(img.^2, fspecial('average', size), 'replicate');      %Kuv^2
img_variance = img_sqr_mean - img_means.^2;     %variance of kernel

I = img(:);     %flatten
var_img = sum((I-mean(I)).^2)/numel(I);     %variance of whole image

img_weights = img_variance.^2 / (img_variance.^2 + var_img.^2);
img_output = img_means + img_weights *(img - img_means);    %Y = Kmean+W*(C-Kmean)

img_output=uint8(img_output); 