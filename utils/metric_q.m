function ret = metric_q(img, N, sig_level)
    if ~exist('N', 'var')
        N = 8;
    end

    if ~exist('sig_level', 'var')
        sig_level = 0.001;
    end

    [m, n, c] = size(img);

    if isa(img, 'double')
        img = im2double(img);
    end

    dh = [0, 0, 0; -0.5, 0, 0.5; 0, 0, 0];
    dv = [0, -0.5, 0; 0, 0, 0; 0, 0.5, 0];

    pm = ceil(m / N);
    pn = ceil(n / N);

    img_dh = conv2(img, dh, 'same');
    img_dv = conv2(img, dv, 'same');

    spatch = zeros(pm * pn, c, 2);
    q = zeros(pm * pn, c);

    for i = 1:pm
        for j = 1:pn
            for k = 1:c
                mend = min([i * N, m]);
                nend = min([j * N, n]);
                pdh = img_dh((i - 1) * N + 1 : mend, (j - 1) * N + 1 : nend, k);
                pdv = img_dv((i - 1) * N + 1 : mend, (j - 1) * N + 1 : nend, k);
                pd = [pdh(:), pdv(:)];
                spatch((i - 1) * N + j, k, :) = svd(pd);
                q((i - 1) * N + j, k) = (spatch((i - 1) * N + j, k, 1) - spatch((i - 1) * N + j, k, 2)) / (spatch((i - 1) * N + j, k, 1) + spatch((i - 1) * N + j, k, 2));
            end
        end
    end

    delta = sig_level ^ (1 / (N ^ 2  - 1));
    tau = sqrt((1 - delta) / (1 + delta));
    valid = (q >= tau);
    q = q .* valid .* spatch(:, :, 1);

    ret = sum(q(:)) / (pm * pn * c);
end
                
