### About
This repository is the implementation of the remote sensing image deblurring method in the paper: 
Zhuangtianyu Liao, Wenyi Zhang, Yuxin Hu, Qingwei Chu and Hao Ding, "Multispectral Remote Sensing Image Deblurring Using Auxiliary Band Gradient Information".

The implementation is mainly based on https://github.com/FWen/deblur-pmp in `PMP_ABGI`. Implementations of compared methods in the paper are also included (`DCP` and `ECP`). Datasets are included in `data`.

### Usage
1. Clone the repository by `git clone https://github.com/abgi2023/abgi.git`.
2. Run the demo `exp_sim.m` for simulated blur or `exp_real.m` for real-world blur. You can also modify the datasets or methods that you want in the source code, since all datasets and methods are included by default and it takes several hours to run.