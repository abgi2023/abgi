function [J, Mask] = find_min_pixels(I, patch_size)

    [M, N, C] = size(I);
    Mp = ceil(M/patch_size);
    Np = ceil(N/patch_size);
    J = zeros(M, N, C);  
    Mask = zeros(M, N, C);
    
    for m = 1:Mp
        for n = 1:Np
            idx1 = [1,patch_size]+(m-1)*patch_size;
            idx2 = [1,patch_size]+(n-1)*patch_size;
            idx1_max = min(idx1(2),M);
            idx2_max = min(idx2(2),N);
            cur_patch_size = idx1_max - idx1(1) + 1;
            
            for c = 1:C
                patch = I(idx1(1):idx1_max, idx2(1):idx2_max, c);
    
                [val,idx] = min(patch(:));
                idx_x = mod(idx - 1, cur_patch_size);
                idx_y = floor((idx - 1) / cur_patch_size);
    
                J(idx1(1)+idx_x, idx2(1)+idx_y, c) = val;
                Mask(idx1(1)+idx_x, idx2(1)+idx_y, c) = 1;
            end
        end
    end

end
