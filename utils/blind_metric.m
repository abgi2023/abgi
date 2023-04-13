function ret = blind_metric(img)
    ret = zeros(1, 3);
    ret(1) = brisque(img);
    ret(2) = niqe(img);
    ret(3) = piqe(img);
end