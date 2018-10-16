%% ASSIGNMENT 10

%% Beginning of Assignment 10

book = rgb2gray(imread('book.jpg'));
book = double(book);
psf = fspecial('disk',4);
psf_f = fft2(psf,size(book,1),size(book,2));

book_blurred = real(ifft2(psf_f.*fft2(book)));

figure;

subplot(1,2,1);
imshow(uint8(book));
title('Original Book Image');

subplot(1,2,2);
imshow(uint8(book_blurred));
title('Blurred Book Image');

%% Inverse Filtering


book_inv = real(ifft2(fft2(book_blurred)./psf_f));

figure;

subplot(1,2,1);
imshow(uint8(book_blurred));
title('Blurred Image');

subplot(1,2,2);
imshow(uint8(book_inv));
title('Inverse Filtering result');

%% Wiener Filtering

book_wiener = wiener2(book_blurred,[4,4]);

figure;

subplot(1,2,1);
imshow(uint8(book_blurred));
title('Blurred Image');

subplot(1,2,2);
imshow(uint8(book_wiener));
title('Wiener Filtering result');

%% Constrained Matrix Inversion

book_cmi = real(ifft2((abs(psf_f) > 0.1).*fft2(book_blurred)./psf_f));

figure;
subplot(1,2,1);
imshow(uint8(book_blurred));
title('Blurred Image');

subplot(1,2,2);
imshow(uint8(book_cmi));
title('Constrained Matrix Inversion result');


%% Conclusion

% We know inverse filtering works only when the degradation is homogeneous
% and we observe the same as well. Since we degrade all the pixels with the
% same psf, we are able to recover it using inverse filtering. However if a
% minute amount of Gaussian Noise were to be added, this method would
% fail. What remains is Wiener filtering which adapts well to the case of
% noise as well as homogeneous degradation. We can also see the effect of
% Constrained Matrix Inversion, which is able to restore the image to some
% extent.