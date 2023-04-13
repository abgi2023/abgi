% This is the demo for simulated blur (including gaussian, motion and
% defocus blur).

clear; clc; close all;

addpath(genpath('utils'));

datasets = {'Pavia', 'PaviaU', 'AVIRIS', 'GFDM01', 'GFDM02', ...
    'GFDM03', 'GFDM04', 'GFDM05', 'GFDM06', 'GFDM07', 'GFDM08', ...
    'S2_01', 'S2_02', 'S2_03', 'S2_04'
};

gt_idx  = [20, 20, 20, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
aux_idx = [50, 50, 50, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3];

methods = {'DCP', 'ECP', 'PMP', 'ABGI'};

%% Preparation
DAT_PATH = 'data\';
OUTPUT_PATH = 'data_output\';
check_output_dir();
ks = 35; % Full size of the kernel
s = 15;  % Valid size (i.e. concentrated non-zero part) of the kernel
sigma = 0.005;
rng(0);

% Three blur types are available: gaussian, motion, defocus
bl = 'gaussian';
metrics = zeros([length(datasets), length(methods), 6]);
ker = exp_gen_ker(bl, ks, s);

fid = fopen([OUTPUT_PATH, 'metrics.csv'], 'a');

%% Main procedure of the deblurring
for di = 1:length(datasets)
    % Read and pre-process the input image
    img = exp_load(DAT_PATH, datasets{di});
    img_gt  = linear_2p(img(:, :, gt_idx(di)));
    img_aux = linear_2p(img(:, :, aux_idx(di)));
    img_bl  = make_blur_noise(img_gt, ker, sigma);

    imwrite(img_gt, [OUTPUT_PATH, sprintf('%s\\%s\\%s_gt.png', datasets{di}, bl, datasets{di})]);
    imwrite(img_aux, [OUTPUT_PATH, sprintf('%s\\%s\\%s_aux.png', datasets{di}, bl, datasets{di})]);
    imwrite(img_bl, [OUTPUT_PATH, sprintf('%s\\%s\\%s_bl.png', datasets{di}, bl, datasets{di})]);

    for mi = 1:length(methods)
        fprintf('Processing %s using %s\n', datasets{di}, methods{mi});
        % Deblur
        [img_out, ker_out, t] = exp_exec(img_bl, methods{mi}, img_aux, ks);
        img_out = double(img_out);
        % Calculate the metrics
        metrics(di, mi, 1:2) = nonblind_metric(img_out, img_gt);
        metrics(di, mi, 3:5) = blind_metric(img_out);
        metrics(di, mi, 6) = immse(ker, ker_out) * 1e6;
        % Image and metrics output
        fprintf('%s processing finished using %s, time: %f\n', datasets{di}, methods{mi}, t);
        imwrite(img_out, [OUTPUT_PATH, sprintf('%s\\%s\\%s_%s.png', datasets{di}, bl, datasets{di}, methods{mi})]);
        ker_out = ker_out ./ max(ker_out(:));
        imwrite(ker_out, [OUTPUT_PATH, sprintf('%s\\%s\\%s_%s_ker.png', datasets{di}, bl, datasets{di}, methods{mi})]);
        write_metric(fid, datasets{di}, methods{mi}, bl, metrics(di, mi, :));
    end
end

fclose(fid);
