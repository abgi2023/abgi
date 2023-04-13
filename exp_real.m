% This is the demo for real world blur.
clear; clc; close all;

addpath(genpath('utils'));

datasets = {'GFDM01', 'GFDM02', 'GFDM03', 'GFDM04',...
    'GFDM05', 'GFDM06', 'GFDM07', 'GFDM08'};

bl_idx  = 7;
aux_idx = 4;

methods = {'DCP', 'ECP', 'PMP', 'ABGI'};

%% Preparation
DAT_PATH = 'data\';
OUTPUT_PATH = 'data_output\';
check_output_dir();
bl = 'real';
ksize = 35; % Full size of the kernel
metrics = zeros([length(datasets), length(methods), 6]);

fid = fopen([OUTPUT_PATH, 'metrics.csv'], 'a');

%% Main procedure of the deblurring
for di = 1:length(datasets)
    % Read and pre-process the input image
    img = exp_load(DAT_PATH, datasets{di});
    img_bl  = linear_2p(img(:, :, bl_idx));
    img_aux = linear_2p(img(:, :, aux_idx));

    imwrite(img_bl, [OUTPUT_PATH, sprintf('%s\\%s\\%s_real_gt.png', datasets{di}, bl, datasets{di})]);
    imwrite(img_aux, [OUTPUT_PATH, sprintf('%s\\%s\\%s_real_aux.png', datasets{di}, bl, datasets{di})]);

    for mi = 1:length(methods)
        fprintf('Processing %s using %s\n', datasets{di}, methods{mi});
        % Deblur
        [img_out, ker_out, t] = exp_exec(img_bl, methods{mi}, img_aux, ksize);
        img_out = double(img_out);
        % Calculate the metrics
        metrics(di, mi, 3:5) = blind_metric(img_out);
        % Image and metrics output
        fprintf('%s processing finished using %s, time: %f\n', datasets{di}, methods{mi}, t);
        imwrite(img_out, [OUTPUT_PATH, sprintf('%s\\%s\\%s_%s_real.png', datasets{di}, bl, datasets{di}, methods{mi})]);
        ker_out = ker_out ./ max(ker_out(:));
        imwrite(ker_out, [OUTPUT_PATH, sprintf('%s\\%s\\%s_%s_real_ker.png', datasets{di}, bl, datasets{di}, methods{mi})]);
        write_metric(fid, datasets{di}, methods{mi}, 'real', metrics(di, mi, :));
    end
end

fclose(fid);