clc;
clear;
close all;

new = imread('1.jpg'); 
new = imresize(new,[512 512]);

new = rgb2gray(new);
figure(1)
imshow(new)
title('Original image')

theta = 0:179;
theta2 = 0:3:179;

R = my_RadonTransform(new,theta);
xp = linspace(-364, 365, 730);
xp = xp';
R = rot90(R,2);

figure(2)
imshow(R,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit')
xlabel('\theta (degrees)')
ylabel('x''')
title(' 0:1:179')
colormap(gca,hot), colorbar

%filtering in frequency domain
num_theta = length(theta);
N1 = length(xp);
freqs=linspace(-1, 1, N1).';
rampFilter = abs( freqs );
rampFilter = repmat(rampFilter, [1 num_theta]);
L = (rampFilter<=0.5);
rampFilter = L.*rampFilter;

ft_R = fftshift(fft(R,[],1),1);
filt_P = ft_R .* rampFilter;
filt_P = ifftshift(filt_P,1);
ift_R = real(ifft(filt_P,[],1));

%filtering in spatial domain




I1 = my_InverseRadon(ift_R,theta);
I1 = rot90(I1,1);
I1 = fliplr(I1);
I2 = my_InverseRadon(R,theta);
I2 = rot90(I2,1);
I2 = fliplr(I2);
I1 = imcrop(I1,[113,113,624-113,624-113]);
I2 = imcrop(I2,[113,113,624-113,624-113]);

figure(3)
subplot(1,2,1)
imshow(I1,[])
title('My Filtered Backprojection')
subplot(1,2,2)
imshow(I2,[])
title('Unfiltered Backprojection')

