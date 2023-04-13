function ret = make_blur_noise(img, ker, sigma)
    ksize = length(ker);
    img_blurred = padarray(img, [floor(ksize / 2), floor(ksize / 2)], 'symmetric');
    ret = conv2(img_blurred, ker, 'valid');

    gn = randn(size(img)) * sigma;
    ret = ret + gn;
    ret = min(max(ret, 0), 1);
end