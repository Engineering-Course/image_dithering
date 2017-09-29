%% Ordered dithering
function dithered_img = ordered_dithering(img, matrix_size)

if matrix_size == 4
    dither_matrix = [0 8 2 10; 12 4 14 6; 3 11 1 9; 15 7 13 5] * 16;
else
    matrix_size = 2;
    dither_matrix = [0 128 ;192 64];
end

[row, col] = size(img);
dithered_img = zeros([row, col]);

for x = 1:row
    for y = 1:col
        i = mod(x, matrix_size) + 1;
        j = mod(y, matrix_size) + 1;
        if img(x,y) > dither_matrix(i,j)
            dithered_img(x,y) = 1;
        end
    end
end  
end