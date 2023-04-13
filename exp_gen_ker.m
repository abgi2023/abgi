function ret = exp_gen_ker(type, ksize, size)
    ret = zeros(ksize);
    
    if strcmp(type, 'gaussian')
        ker = fspecial('gaussian', size, 5);
    elseif strcmp(type, 'motion')
        ker = fspecial('motion', floor(size*sqrt(2)), 45);
    elseif strcmp(type, 'defocus')
        ker = fspecial('disk', floor(size/2));
    else
        ker = zeros(ksize);
    end
    ksh = floor(ksize/2);
    sh = floor(length(ker)/2);
    ret(ksh-sh+1 : ksh+sh+1, ksh-sh+1 : ksh+sh+1) = ker;
end