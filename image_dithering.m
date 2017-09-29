%% image dithering algorithm
function image_dithering()
clear;
close all;
fclose all;

%%
% image dir setting
img_dir = 'lena_gray.bmp'; %'lena.bmp'
output_dir = 'results';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end
% read image and judge color
img = imread(img_dir);
[~, ~, channel] = size(img);
img_color = channel == 3;

if ~img_color
    fprintf('Processing image dithering on gray image...');
    dithered_img1 = ordered_dithering(img, 2);
    dithered_img2 = ordered_dithering(img, 4);
    dithered_img3 = fs_dithering(img);
    
    subplot(2,2,1); imshow(img); title('Original image');
    subplot(2,2,2); imshow(dithered_img1); title('Dithered image with 2*2 dither matrix');
    subplot(2,2,3); imshow(dithered_img2); title('Dithered image with 4*4 dither matrix');
    subplot(2,2,4); imshow(dithered_img3); title('Dithered image with Floyd-Steinberg algorithm');
    
    imwrite(dithered_img1, fullfile(output_dir, 'ordered_dithered_2_lena_gray.bmp'));
    imwrite(dithered_img2, fullfile(output_dir, 'ordered_dithered_4_lena_gray.bmp'));
    imwrite(dithered_img3, fullfile(output_dir, 'FS_dithered_lena_gray.bmp'));
else
    red = img(:,:,1);
    green = img(:,:,2);
    blue = img(:,:,3);
    
    dithered_red1 = ordered_dithering(red, 4);
    dithered_green1 = ordered_dithering(green, 4);
    dithered_blue1 = ordered_dithering(blue, 4);
    dithered_img1 = cat(3, dithered_red1, dithered_green1, dithered_blue1);
    
    dithered_red3 = fs_dithering(red);
    dithered_green3 = fs_dithering(green);
    dithered_blue3 = fs_dithering(blue);
    dithered_img3 = cat(3, dithered_red3, dithered_green3, dithered_blue3);
    
    dithered_red2 = ordered_dithering(red, 4);
    dithered_green2 = ordered_dithering(green, 4);
    dithered_blue2 = ordered_dithering(blue, 4);
    dithered_img2 = cat(3, dithered_red2, dithered_green2, dithered_blue2);
    
    subplot(2,2,1); imshow(img); title('Original image');
    subplot(2,2,2); imshow(dithered_img1); title('Dithered image with 2*2 dither matrix');
    subplot(2,2,3); imshow(dithered_img2); title('Dithered image with 4*4 dither matrix');
    subplot(2,2,4); imshow(dithered_img3); title('Dithered image with Floyd-Steinberg algorithm');
    
    imwrite(dithered_img1, fullfile(output_dir, 'ordered_dithered_2_lena_color.bmp'));
    imwrite(dithered_img2, fullfile(output_dir, 'ordered_dithered_4_lena_4.bmp'));
    imwrite(dithered_img3, fullfile(output_dir, 'FS_dithered_lena_color.bmp'));
    
end
    
