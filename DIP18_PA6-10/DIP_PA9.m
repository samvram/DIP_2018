%% ASSIGNMENT 9

%% 2 Rupee coin digitization problem

coin = rgb2gray(imread('2rupee.jpg'));

coin_cs = uint8((coin-min(min(coin)))/(200-min(min(coin)))*255);

coin_he = histeq(coin);

figure;

subplot(1, 3, 1);
imshow(coin);
title('Original Image');

subplot(1, 3, 2);
imshow(coin_cs);
title('Contrast Stretched Image');

subplot(1,3,3);
imshow(coin_he);
title('Histogram Equalized Image');
%% Sharpening and showing the results

coin_sharp = imsharpen(coin, 'Amount', 1);
coin_sharp_cs = uint8((coin_sharp-min(min(coin_sharp)))/(max(max(coin_sharp))-min(min(coin_sharp)))*255);

figure;

subplot(1, 3, 1);
imshow(coin);
title('Original Image');

subplot(1,3,2);
imshow(coin_sharp);
title('Sharpened Coin image');

subplot(1,3,3);
imshow(coin_sharp_cs);
title('Sharpened Coin Contrast Stretched image');

%% Homomorphic Filtering

dim=rgb2gray(imread('homomorphic.jpg'));
cim=double(dim);
[r,c]=size(dim);
cim=cim+1;
% add 1 to pixels to remove 0 values which would result in undefined log values
% natural log
lim=log(cim);
%2D fft
fim=fft2(lim);
lowg=.6; %(lower gamma threshold, must be lowg < 1)
highg=1.4; %(higher gamma threshold, must be highg > 1)
% make sure the the values are symmetrically differenced
% function call
him=homomorph(fim,lowg,highg);
%inverse 2D fft
ifim=ifft2(him);
 
 
%exponent of result
eim=exp(ifim);
 
figure;

subplot(1,2,1);
imshow(dim);
title('Origional image');

subplot(1,2,2);
imshow(uint8(eim));
title('Homomorphic Filtering result');

%% Conclusion
%
% We can see that histogram equalization performs better than the other
% contrast-stretching method for the given problem. Unsharp masking and
% contrast-stretching also provide good results. Homomorphic filtering
% shows the effect of illumination and shows the inside of the room with
% very poor illumination, with great detail.