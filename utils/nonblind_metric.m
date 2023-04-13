function ret = nonblind_metric(img, ref)
    ret = zeros(1, 2);
    ret(1) = psnr(img, ref);
    ret(2) = ssim(img, ref);
end