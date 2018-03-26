%% 1.1 rect.bmp
I = imread('rect.bmp');
F = fft2(double(I));
T = abs(fftshift(F));
figure(1)
subplot(1, 2, 1)
imshow(I)
title('rect.bmp')
subplot(1, 2, 2)
imshow(T, [0, 200000])
title('rect.bmp frequency domain')

%% 1.2 rect-45
I = imread('rect-45.bmp');
F = fft2(double(I));
T = abs(fftshift(F));
figure(2)
subplot(1, 2, 1)
imshow(I)
title('rect-45.bmp')
subplot(1, 2, 2)
imshow(T, [0, 200000])
title('rect-45.bmp in frequency domain')

%% 2.1 grid LPF
threshold = 1e+5;
I = imread('grid.bmp');
F = fftshift(fft2(double(I)));
F_complement = F;
F_complement(122 : 135, 122 : 135) = 0;
F = F - F_complement;
for m = 1 : size(F_complement, 1)
    for n = 1 : size(F_complement, 2)
        if(abs(F_complement(m, n)) > threshold)
            ratio = abs(F_complement(m, n)) / threshold;
            F_complement(m, n) = F_complement(m, n) / ratio;
        end
    end
end
F = F + F_complement;
T = abs(F);
figure(3)
subplot(1, 2, 1)
imshow(T, [0, 200000])
title('Frequency Domain')
F = ifft2(ifftshift(F));
subplot(1, 2, 2)
imshow(F, [])
title('Filtered Image')


%% 2.2 grid HPF
I = imread('grid.bmp');
F = fftshift(fft2(double(I)));
F(120 : 137, 120 : 137) = 0;
T = abs(F);
figure(4)
subplot(1, 2, 1)
imshow(T, [0, 200000])
title('Frequency Domain')
F = ifft2(ifftshift(F));
subplot(1, 2, 2)
imshow(F, [])
title('Filtered Image')

%% 3 lena
I = imread('lena.bmp');
F = fftshift(fft2(double(I)));
F(128 : 129, 120) = 25 * F(128 : 129, 120);
F(128 : 129, 137) = 25 * F(128 : 129, 137);
T = abs(F);
figure(5)
subplot(1, 2, 1)
imshow(T, [0, 200000])
title('Frequency Domain')
F = ifft2(ifftshift(F));
subplot(1, 2, 2)
imshow(F, [])
title('Processed Image')

%% 4 Homomorphism filtering cave.jpg
I = imread('cave.jpg');
c = 1;
D0 = 0.2;
D_square = zeros(size(I));
for m = 1 : size(D_square, 1)
    for n = 1 : size(D_square, 2)
        D_square(m, n) = (m - floor(size(D_square, 1) / 2)) ^ 2 + (n - floor(size(D_square, 2) / 2)) ^ 2;
    end
end
H = (0.3 - 0.1) * (1 - exp(-c * (D_square / (D0 ^ 2)))) + 0.1;
figure(6)
subplot(1, 2, 1)
imshow(I);
title('Original Image')
F = fftshift(fft2(log(double(I) + 0.01)));
F = F .* H;
F = ifft2(ifftshift(F));
F = exp(abs(F) - 0.01);
subplot(1, 2, 2)
imshow(F, [])
title('Filtered Image')