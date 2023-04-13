function save_tiff(path, fname, pic_data, tiff_info)
    new_pic = Tiff([path, fname], 'w');
    new_pic.write(pic_data)
    new_pic.close()
end