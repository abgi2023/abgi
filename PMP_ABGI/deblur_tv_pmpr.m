function S = deblur_tv_pmpr(Im, kernel, lambda, mu, opts, aux)

%Deblurring based on L0-Total variation and PMP thresholding
S = Im;
alphamax = 1e5;
[M,N,~] = size(Im);
otfFh = psf2otf([1, -1], [M,N]);
otfFv = psf2otf([1; -1],[M,N]);
otfKER = psf2otf(kernel,[M,N]);

denKER  = abs(otfKER).^2;
denGrad = abs(otfFh).^2 + abs(otfFv ).^2;
Fk_FI = conj(otfKER).*fft2(Im);
alpha = 2.0*mu;

K=3;
kappa=2;

% Gh = [diff(S,1,2), S(:,1) - S(:,end)]; % gh
% Gv = [diff(S,1,1); S(1,:) - S(end,:)]; % gv
ah = [diff(aux,1,2), aux(:,1) - aux(:,end)];
av = [diff(aux,1,1); aux(1,:) - aux(end,:)];
% ah = abs(ah) .* sign(Gh);
% av = abs(av) .* sign(Gv);
ahh = [ah(:,end) - ah(:, 1), -diff(ah,1,2)];
avv = [av(end,:) - av(1, :); -diff(av,1,1)];
xa_coeff = 1e-2;

while alpha<alphamax

    for k=1:K
        [Z, Md] = find_min_pixels_c(S, opts.r);
        % z = Z(Md>0);
        Z_mask = Md > 0;
        z = Z .* Z_mask;
        
        % updating Z
        if opts.s<opts.scales/2
            lambdat = min(max(lambda,mean(abs(z))),0.1); 
            % Z(abs(Z)<lambdat) = 0;
            absZ_mask = abs(Z) < lambdat;
            Z = Z .* (1 - absZ_mask);
        else
            Z = sign(Z).*max(Z-lambda,0);
        end

        S = S .* (1-Md) + Z .* Md;

       % g (Gradient) sub-problem
        Gh = [diff(S,1,2), S(:,1) - S(:,end)]; % gh
        Gv = [diff(S,1,1); S(1,:) - S(end,:)]; % gv
        t = ((Gh - ah).^2 + (Gv - av).^2) < mu/alpha;
        Gh = Gh .* (1 - t);
        Gv = Gv .* (1 - t);
        
       % I subproblem
        gh = [Gh(:,end) - Gh(:, 1), -diff(Gh,1,2)];
        gv = [Gv(end,:) - Gv(1, :); -diff(Gv,1,1)];
        g_fft = fft2((gh+gv+xa_coeff*(ahh+avv)) ./ (1 + xa_coeff));
        Fs = (Fk_FI + alpha*g_fft)./(denKER + alpha*denGrad);
        fs_ifft = ifft2(Fs);
        S = real(fs_ifft);
        S = min(max(S, 0), 1);
    end
    alpha = alpha*kappa;
end
%    figure(12); imshow(S,[]);title('S');
end

