#include "mex.h"

#define MIN(x,y) ((x)<(y)?(x):(y))

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

    if (nrhs != 2) {
        mexErrMsgTxt("Wrong number of input arguments. \n");
    }

    if (nlhs > 2) {
        mexErrMsgTxt("Too many output argumnents.\n");
    }

    size_t M = mxGetM(prhs[0]);
    size_t N = mxGetN(prhs[0]);
    unsigned int patch_size = mxGetScalar(prhs[1]);

    double* I = mxGetPr(prhs[0]);

    size_t Mp = M % patch_size == 0 ? M / patch_size : (M / patch_size + 1);
    size_t Np = N % patch_size == 0 ? N / patch_size : (N / patch_size + 1);

    plhs[0] = mxCreateDoubleMatrix(M, N, mxREAL);
    plhs[1] = mxCreateDoubleMatrix(M, N, mxREAL);

    double* J = mxGetPr(plhs[0]);
    double* Mask = mxGetPr(plhs[1]);

    size_t n, m, l, k;
    
    for (n = 0; n < Np; n++) {
        for (m = 0; m < Mp; m++) {
            size_t ns = n * patch_size;
            size_t ne = MIN((n + 1) * patch_size, N);
            size_t ms = m * patch_size;
            size_t me = MIN((m + 1) * patch_size, M);

            double min_val = I[ns * M + ms];
            size_t min_idx_n = ns;
            size_t min_idx_m = ms;

            for (l = ns; l < ne; l++) {
                for (k = ms; k < me; k++) {
                    if (I[l * M + k] < min_val) {
                        min_val = I[l * M + k];
                        min_idx_n = l;
                        min_idx_m = k;
                    }
                }
            }

            J[min_idx_n * M + min_idx_m] = min_val;
            Mask[min_idx_n * M + min_idx_m] = 1;
        }
    }
}