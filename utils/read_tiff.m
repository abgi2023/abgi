function pic_data = read_tiff(path, bit_depth)
    pic = Tiff(path, 'r');
    pic_data = read(pic);
    pic_data = double(pic_data);
    pic.close()
end
