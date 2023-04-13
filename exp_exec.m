function [ret, kernel, runtime] = exp_exec(img, method_name, aux, ksize)
    if ~exist('aux', 'var')
        aux = zeros(size(img));
    end

    opts.prescale = 1;
    opts.xk_iter = 5;
    opts.gamma_correct = 1.0;
    opts.k_thresh = 20;
    opts.kernel_size = ksize;
    lambda_dark = 4e-3;
    lambda_grad = 4e-3;
    lambda_tv = 1e-3;
    lambda_l0 = 5e-4;
    weight_ring = 1;
    saturation = 1;

    if strcmp(method_name, 'DCP')
        addpath(genpath('DCP'));
        tic;
        [kernel, ~] = blind_deconv(img, lambda_dark, lambda_grad, opts);
        if saturation == 0
            ret = ringing_artifacts_removal(img, kernel, lambda_tv, lambda_l0, weight_ring);
        else
            ret = whyte_deconv(img, kernel);
        end
        runtime = toc;
        rmpath(genpath('DCP'));
    elseif strcmp(method_name, 'ECP')
        addpath(genpath('ECP'));
        tic;
        [kernel, ~] = blind_deconv(img, lambda_dark, lambda_grad, opts);
        if saturation == 0
            ret = ringing_artifacts_removal(img, kernel, lambda_tv, lambda_l0, weight_ring);
        else
            ret = whyte_deconv(img, kernel);
        end
        runtime = toc;
        rmpath(genpath('ECP'));
    elseif strcmp(method_name, 'PMP')
        addpath(genpath('PMP_ABGI'));
        lambda_dark = 0.1;
        tic;
        [kernel, ~] = blind_deconv(img, lambda_dark, lambda_grad, opts);
        if saturation == 0
            ret = ringing_artifacts_removal(img, kernel, lambda_tv, lambda_l0, weight_ring);
        else
            ret = whyte_deconv(img, kernel);
        end
        runtime = toc;
        rmpath(genpath('PMP_ABGI'));
    elseif strcmp(method_name, 'ABGI')
        addpath(genpath('PMP_ABGI'));
        lambda_dark = 0.1;
        tic;
        [kernel, ~] = blind_deconv(img, lambda_dark, lambda_grad, opts, 'aux', aux);

        pad_size = floor(opts.kernel_size / 2);
        aux_padded = padarray(aux, [pad_size, pad_size], 'replicate', 'both');
        aux_blurred = conv2(aux_padded, kernel, 'valid');

        imgd = img - aux_blurred;
        if saturation == 0
            ret = ringing_artifacts_removal(imgd, kernel, lambda_tv, lambda_l0, weight_ring);
        else
            dmin = min(imgd(:));
            imgd = (imgd - dmin);
            imgd = whyte_deconv(imgd, kernel);
            ret = dmin + imgd;
        end
        ret = max(min(ret + aux, 1), 0);
        runtime = toc;
        
        rmpath(genpath('PMP_ABGI'));
    else
        ret = img;
        runtime = 0;
    end
end