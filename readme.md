# About
This repository is the implementation of the remote sensing image deblurring method in the paper: 
Z. Liao, W. Zhang, Q. Chu, H. Ding and Y. Hu, "Multispectral Remote Sensing Image Deblurring Using Auxiliary Band Gradient Information," in IEEE Transactions on Geoscience and Remote Sensing, vol. 61, pp. 1-18, 2023, Art no. 5403418, doi: 10.1109/TGRS.2023.3280647.

The implementation is mainly based on https://github.com/FWen/deblur-pmp in `PMP_ABGI`. Implementations of compared methods in the paper are also included (`DCP` and `ECP`). Datasets are included in `data`.

# Usage
1. Clone the repository by `git clone https://github.com/abgi2023/abgi.git`.
2. Run the demo `exp_sim.m` for simulated blur or `exp_real.m` for real-world blur. You can also modify the datasets or methods that you want in the source code, since all datasets and methods are included by default and it takes several hours to run.

# Cite Us
```
@article{liao2023multispectral,
  title={Multispectral Remote Sensing Image Deblurring Using Auxiliary Band Gradient Information},
  author={Liao, Zhuangtianyu and Zhang, Wenyi and Chu, Qingwei and Ding, Hao and Hu, Yuxin},
  journal={IEEE Transactions on Geoscience and Remote Sensing},
  year={2023},
  publisher={IEEE}
}
```
