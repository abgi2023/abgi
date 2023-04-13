function img = exp_load(dat_path, name)
    if strcmp(name, 'Pavia')
        load([dat_path, 'Pavia.mat']);
        img = pavia;
    elseif strcmp(name, 'PaviaU')
        load([dat_path, 'PaviaU.mat']);
        img = paviaU;
    elseif strcmp(name, 'Kernel')
        load([dat_path, 'kernel.mat']);
        img = ker;
    elseif strcmp(name, 'AVIRIS')
        img = read_tiff([dat_path, 'f201015t01p00r15.tif']);
    elseif strcmp(name, 'GFDM01')
        img = read_tiff([dat_path, 'DM01_PMS_006323_20210904_KR111_01_017_L1A_cropped_01.tif']);
    elseif strcmp(name, 'GFDM02')
        img = read_tiff([dat_path, 'DM01_PMS_006956_20211017_KR111_03_004_L1A_cropped_01.tif']);
    elseif strcmp(name, 'GFDM03')
        img = read_tiff([dat_path, 'DM01_PMS_008182_20220108_KR111_01_020_L1A_cropped_01.tif']);
    elseif strcmp(name, 'GFDM04')
        img = read_tiff([dat_path, 'DM01_PMS_008301_20220116_MY2K1_03_018_L1A_cropped_01.tif']);
    elseif strcmp(name, 'GFDM05')
        img = read_tiff([dat_path, 'DM01_PMS_008729_20220214_MY2K1_00_012_L1A_cropped_01.tif']);
    elseif strcmp(name, 'GFDM06')
        img = read_tiff([dat_path, 'DM01_PMS_008951_20220301_SY5J1_00_019_L1A_cropped_01.tif']);
    elseif strcmp(name, 'GFDM07')
        img = read_tiff([dat_path, 'DM01_PMS_009423_20220402_MY2J1_02_001_L1A_cropped_01.tif']);
    elseif strcmp(name, 'GFDM08')
        img = read_tiff([dat_path, 'DM01_PMS_009776_20220426_KR111_01_005_L1A_cropped_01.tif']);
    elseif strcmp(name, 'S2_01')
        img = read_tiff([dat_path, 'S2A_MSIL1C_20221223T040151_N0509_R004_T47RNK_20221223T054612_cropped.tif']);
    elseif strcmp(name, 'S2_02')
        img = read_tiff([dat_path, 'S2A_MSIL1C_20230104T044201_N0509_R033_T46SDH_20230104T053449_cropped.tif']);
    elseif strcmp(name, 'S2_03')
        img = read_tiff([dat_path, 'S2A_MSIL2A_20221208T013041_N0509_R074_T54SUE_20221208T041653_cropped.tif']);
    elseif strcmp(name, 'S2_04')
        img = read_tiff([dat_path, 'S2B_MSIL1C_20230103T024109_N0509_R089_T51RUQ_20230103T042628_cropped.tif']);
    else
        fprintf("Not a valid dataset name.\n")
        return
    end
end