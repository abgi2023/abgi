function check_output_dir()
    datasets = {'Pavia', 'PaviaU', 'AVIRIS', 'GFDM01', 'GFDM02', ...
        'GFDM03', 'GFDM04', 'GFDM05', 'GFDM06', 'GFDM07', 'GFDM08', ...
        'S2_01', 'S2_02', 'S2_03', 'S2_04'
    };
    
    blurs = {'gaussian', 'motion', 'defocus', 'real'};
    
    for di = 1:length(datasets)
        for bi = 1:length(blurs)
            dir_name = sprintf("data_output\\%s\\%s", datasets{di}, blurs{bi});
            if exist(dir_name) == 0
                mkdir(dir_name)
            end
        end
    end
end