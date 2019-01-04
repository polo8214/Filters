function img_output = my_wiener_filter_mod(img,size)

img = double(img);
img = log(img+1);       %log transformation
img_means = imfilter(img, fspecial('average', size), 'replicate');
img_sqr_mean = imfilter(img.^2, fspecial('average', size), 'replicate');
img_variance = img_sqr_mean - img_means.^2;     %var^2 = Kuv^2 - Kmean^2

I = img(:);
var_img = sum((I-mean(I)).^2)/numel(I);

img_weights = img_variance.^2 / (img_variance.^2 + var_img.^2);
img_output = img_means + img_weights *(sqrt(img_sqr_mean) - img_means);

img_output = exp(1).^img_output;       %% inverse log transformation
img_output=uint8(img_output); 