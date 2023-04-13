function img_out = zoom_in_rect(img, ltp, rbp, scaling, linewidth, gap, rgb)

    if size(img, 3) == 1
        img_out(:, :, 1) = img;
        img_out(:, :, 2) = img;
        img_out(:, :, 3) = img;
    else
        img_out = img;
    end

    [m, n, ~] = size(img);

    if (~exist('scaling', 'var'))
        scaling = 1.0;
    end

    if (~exist('linewidth', 'var') || linewidth <= 0)
        linewidth = 1;
    end

    if (~exist('gap', 'var'))
        gap = 1;
    end

    if (~exist('rgb', 'var'))
        rgb = [1, 0, 0];
    end

    if (mod(linewidth, 2) == 0)
        fprintf("Warning: linewidth should be odd positive integer. \n");
        linewidth = linewidth - 1;
    end

    %% Zoom in the region selected by rect

    zoom_in = img_out(ltp(1) : rbp(1), ltp(2) : rbp(2), :);
    if (scaling ~= 1.0)
        zoom_in = imresize(zoom_in, scaling, 'bilinear');
    end

    %% Display zoomed region
% 
%     zoom_in_lt = [m - gap - size(zoom_in, 1), n - gap - size(zoom_in, 2)];
%     zoom_in_rb = [m - gap, n - gap];
%     img_out(zoom_in_lt(1) + 1 : zoom_in_lt(1) + size(zoom_in, 1), zoom_in_lt(2) + 1 : zoom_in_lt(2) + size(zoom_in, 2), :) = zoom_in;

    zoom_in_lt = [m - gap - size(zoom_in, 1), gap + 1];
    zoom_in_rb = [m - gap, gap + size(zoom_in, 2) + 1];
    img_out(zoom_in_lt(1) + 1 : zoom_in_lt(1) + size(zoom_in, 1), zoom_in_lt(2) + 1 : zoom_in_lt(2) + size(zoom_in, 2), :) = zoom_in;

    %% Draw rectangle on the original image
    
    img_out = draw_rect(img_out, ltp, rbp, linewidth, rgb);

    %% Draw rectangle on zoomed region

    img_out = draw_rect(img_out, zoom_in_lt, zoom_in_rb, linewidth, rgb);
end

function img = draw_rect(img, ltp, rbp, linewidth, rgb)
    [m, n, ~] = size(img);
    l = ltp(1);
    t = ltp(2);
    r = rbp(1);
    b = rbp(2);
    lw_half = floor(linewidth / 2);

    ln_l_s = max(l - lw_half, 1);
    ln_l_e = min(l + lw_half, m);
    ln_r_s = max(r - lw_half, 1);
    ln_r_e = min(r + lw_half, m);
    ln_t_s = max(t - lw_half, 1);
    ln_t_e = min(t + lw_half, n);
    ln_b_s = max(b - lw_half, 1);
    ln_b_e = min(b + lw_half, n);

    img(ln_l_s : ln_l_e, t : b, :) = reshape(kron(rgb, ones(ln_l_e - ln_l_s + 1, b - t + 1)), [ln_l_e - ln_l_s + 1, b - t + 1, 3]);
    img(ln_r_s : ln_r_e, t : b, :) = reshape(kron(rgb, ones(ln_r_e - ln_r_s + 1, b - t + 1)), [ln_r_e - ln_r_s + 1, b - t + 1, 3]);
    img(l : r, ln_t_s : ln_t_e, :) = reshape(kron(rgb, ones(r - l + 1, ln_t_e - ln_t_s + 1)), [r - l + 1, ln_t_e - ln_t_s + 1, 3]);
    img(l : r, ln_b_s : ln_b_e, :) = reshape(kron(rgb, ones(r - l + 1, ln_b_e - ln_b_s + 1)), [r - l + 1, ln_b_e - ln_b_s + 1, 3]);
end

