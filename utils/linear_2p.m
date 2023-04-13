function ret = linear_2p(img)
    ret = zeros(size(img));
    c = size(img, 3);
    for i=1:c
        cur_img = img(:, :, i);
        [lb, ub] = get_2p(cur_img);
        cur_img = min(max(cur_img, lb), ub);
        cur_img = (cur_img - min(cur_img(:))) ./ (max(cur_img(:)) - min(cur_img(:)));
        ret(:, :, i) = cur_img;
    end
end


function [lb, ub] = get_2p(img)
    img_arr = img(:);
    n = length(img_arr);
    img_arr = sort(img_arr);
    lb = img_arr(ceil(n * 0.02));
    ub = img_arr(ceil(n * 0.98));
end