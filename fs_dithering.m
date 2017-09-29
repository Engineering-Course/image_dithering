%% Floyd-Steinberg image dithering 
function dithered_img = fs_dithering(img)

[row, col] = size(img);
error_matrix = zeros([row, col]);
dithered_img = zeros([row, col]);

for y = 1:col
    for x = 1:row
        if (img(x,y) + error_matrix(x,y) < 128)
            dithered_img(x,y) = 0;
        else
            dithered_img(x,y) = 255;
        end
        diff = img(x,y) + error_matrix(x,y) - dithered_img(x,y);
        
        if y < col
            error_matrix(x,y+1) = error_matrix(x,y+1) + diff * 7 / 16;
        end
        if x < row
            error_matrix(x+1,y) = error_matrix(x+1,y) + diff * 5 / 16;
            if y > 1
                error_matrix(x+1,y-1) = error_matrix(x+1,y-1) + diff * 3 / 16;
            end
            if y < col
                error_matrix(x+1,y+1) = error_matrix(x+1,y+1) + diff * 1 / 16;
            end
        end
    end
end
end
