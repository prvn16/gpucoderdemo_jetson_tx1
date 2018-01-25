//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: fog_rectification.cu
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 25-Jan-2018 08:58:04
//

// Include Files
#include "rt_nonfinite.h"
#include "fog_rectification.h"

// Variable Definitions
__constant__ real_T const_b[9];

// Function Declarations
static __global__ void fog_rectification_kernel1(const uint8_T *input, real_T
  *b_input);
static __global__ void fog_rectification_kernel10(real_T *restoreOut, uint8_T
  *b_restoreOut);
static __global__ void fog_rectification_kernel11(const real_T *b, uint8_T
  *restoreOut, uint8_T *im_gray);
static __global__ void fog_rectification_kernel12(real_T *localBins3, real_T
  *localBins2, real_T *localBins1, real_T *cdf);
static __global__ void fog_rectification_kernel13(real_T *localBins3, real_T
  *localBins2, real_T *localBins1, real_T *cdf);
static __global__ void fog_rectification_kernel14(int32_T *y_size, int32_T
  *b_y_size, int32_T *ii_size, int32_T *T_size);
static __global__ void fog_rectification_kernel15(int32_T i, real_T *T_data);
static __global__ void fog_rectification_kernel16(uint8_T *restoreOut);
static __global__ void fog_rectification_kernel17(real_T *T_data, uint8_T
  *restoreOut, uint8_T *out);
static __global__ void fog_rectification_kernel18(real_T *T_data, uint8_T
  *restoreOut, uint8_T *out);
static __global__ void fog_rectification_kernel19(real_T *T_data, uint8_T
  *restoreOut, uint8_T *out);
static __global__ void fog_rectification_kernel2(real_T *input, real_T
  *darkChannel);
static __global__ void fog_rectification_kernel3(real_T *darkChannel, real_T
  *diff_im);
static __global__ void fog_rectification_kernel4(real_T *expanded);
static __global__ void fog_rectification_kernel5(real_T *diff_im, real_T
  *expanded);
static __global__ void fog_rectification_kernel6(real_T *expanded, real_T
  *diff_im);
static __global__ void fog_rectification_kernel7(real_T *diff_im, real_T *y);
static __global__ void fog_rectification_kernel8(real_T *y, real_T *diff_im,
  real_T *darkChannel);
static __global__ void fog_rectification_kernel9(real_T *darkChannel, real_T
  *diff_im, real_T *input, real_T *restoreOut);
static __device__ real_T rt_roundd_snf(real_T u);

// Function Definitions

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                const uint8_T *input
//                real_T *b_input
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel1(const
  uint8_T *input, real_T *b_input)
{
  int32_T j;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 921600)) {
    //  restoreOut is used to store the output of restoration
    //  Changing the precision level of input image to double
    b_input[j] = (real_T)input[j] / 255.0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *restoreOut
//                uint8_T *b_restoreOut
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel10
  (real_T *restoreOut, uint8_T *b_restoreOut)
{
  real_T cv;
  int32_T j;
  uint8_T u0;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 921600)) {
    cv = rt_roundd_snf(255.0 * restoreOut[j]);
    if (cv < 256.0) {
      if (cv >= 0.0) {
        u0 = (uint8_T)cv;
      } else {
        u0 = 0;
      }
    } else if (cv >= 256.0) {
      u0 = MAX_uint8_T;
    } else {
      u0 = 0;
    }

    b_restoreOut[j] = u0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                const real_T *b
//                uint8_T *restoreOut
//                uint8_T *im_gray
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel11(
  const real_T *b, uint8_T *restoreOut, uint8_T *im_gray)
{
  uint8_T a[3];
  int32_T j;
  real_T cv;
  int32_T n;
  uint8_T u0;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 307200)) {
    // %%%%%% streching performs the histogram streching of the image %%%%%%%
    // %%%%%%%% im is the input color image and p is cdf limit
    // %%%%% out is the contrast streched image and cdf is the cumulative prob
    // %%%%% density function and T is the streching function
    //  rgbtograyconversion
    a[0] = restoreOut[j];
    a[1] = restoreOut[j + 307200];
    a[2] = restoreOut[j + 614400];
    cv = 0.0;
    for (n = 0; n < 3; n++) {
      cv += (real_T)a[n] * b[n];
    }

    cv = rt_roundd_snf(cv);
    if (cv < 256.0) {
      u0 = (uint8_T)cv;
    } else {
      u0 = MAX_uint8_T;
    }

    im_gray[j] = u0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *localBins3
//                real_T *localBins2
//                real_T *localBins1
//                real_T *cdf
// Return Type  : void
//
static __global__ __launch_bounds__(256, 1) void fog_rectification_kernel12
  (real_T *localBins3, real_T *localBins2, real_T *localBins1, real_T *cdf)
{
  int32_T j;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 256)) {
    //  histogram calculation
    cdf[j] = 0.0;
    localBins1[j] = 0.0;
    localBins2[j] = 0.0;
    localBins3[j] = 0.0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *localBins3
//                real_T *localBins2
//                real_T *localBins1
//                real_T *cdf
// Return Type  : void
//
static __global__ __launch_bounds__(256, 1) void fog_rectification_kernel13
  (real_T *localBins3, real_T *localBins2, real_T *localBins1, real_T *cdf)
{
  int32_T j;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 256)) {
    //  cumulative Sum calculation
    cdf[j] = ((cdf[j] + localBins1[j]) + localBins2[j]) + localBins3[j];
    cdf[j] /= 307200.0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                int32_T *y_size
//                int32_T *b_y_size
//                int32_T *ii_size
//                int32_T *T_size
// Return Type  : void
//
static __global__ __launch_bounds__(32, 1) void fog_rectification_kernel14
  (int32_T *y_size, int32_T *b_y_size, int32_T *ii_size, int32_T *T_size)
{
  ;
  ;
  if (!(int32_T)((int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x *
            blockIdx.y) + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
          threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x) +
        threadIdx.x) >= 1)) {
    T_size[0] = 1;
    T_size[1] = ((ii_size[0] + b_y_size[1]) + y_size[1]) + 1;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                int32_T i
//                real_T *T_data
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel15
  (int32_T i, real_T *T_data)
{
  int32_T n;
  ;
  ;
  n = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if ((!(int32_T)(n >= 768)) && ((int32_T)(1 + n <= i))) {
    T_data[n] = floor(T_data[n]);
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                uint8_T *restoreOut
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel16
  (uint8_T *restoreOut)
{
  int32_T j;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if ((!(int32_T)(j >= 921600)) && ((int32_T)((int32_T)restoreOut[j] == 0))) {
    //  Replacing the value from look up table
    restoreOut[j] = 1;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *T_data
//                uint8_T *restoreOut
//                uint8_T *out
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel17
  (real_T *T_data, uint8_T *restoreOut, uint8_T *out)
{
  uint32_T threadId;
  real_T cv;
  int32_T j;
  int32_T i0;
  uint8_T u0;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  i0 = (int32_T)(threadId / 480U);
  j = (int32_T)(threadId - (uint32_T)i0 * 480U);
  if ((!(int32_T)(j >= 480)) && (!(int32_T)(i0 >= 640))) {
    cv = rt_roundd_snf(T_data[(int32_T)restoreOut[j + 480 * i0] - 1]);
    if (cv < 256.0) {
      if (cv >= 0.0) {
        u0 = (uint8_T)cv;
      } else {
        u0 = 0;
      }
    } else if (cv >= 256.0) {
      u0 = MAX_uint8_T;
    } else {
      u0 = 0;
    }

    out[j + 480 * i0] = u0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *T_data
//                uint8_T *restoreOut
//                uint8_T *out
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel18
  (real_T *T_data, uint8_T *restoreOut, uint8_T *out)
{
  uint32_T threadId;
  real_T cv;
  int32_T j;
  int32_T i0;
  uint8_T u0;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  i0 = (int32_T)(threadId / 480U);
  j = (int32_T)(threadId - (uint32_T)i0 * 480U);
  if ((!(int32_T)(j >= 480)) && (!(int32_T)(i0 >= 640))) {
    cv = rt_roundd_snf(T_data[(int32_T)restoreOut[307200 + (j + 480 * i0)] - 1]);
    if (cv < 256.0) {
      if (cv >= 0.0) {
        u0 = (uint8_T)cv;
      } else {
        u0 = 0;
      }
    } else if (cv >= 256.0) {
      u0 = MAX_uint8_T;
    } else {
      u0 = 0;
    }

    out[307200 + (j + 480 * i0)] = u0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *T_data
//                uint8_T *restoreOut
//                uint8_T *out
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel19
  (real_T *T_data, uint8_T *restoreOut, uint8_T *out)
{
  uint32_T threadId;
  real_T cv;
  int32_T j;
  int32_T i0;
  uint8_T u0;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  i0 = (int32_T)(threadId / 480U);
  j = (int32_T)(threadId - (uint32_T)i0 * 480U);
  if ((!(int32_T)(j >= 480)) && (!(int32_T)(i0 >= 640))) {
    cv = rt_roundd_snf(T_data[(int32_T)restoreOut[614400 + (j + 480 * i0)] - 1]);
    if (cv < 256.0) {
      if (cv >= 0.0) {
        u0 = (uint8_T)cv;
      } else {
        u0 = 0;
      }
    } else if (cv >= 256.0) {
      u0 = MAX_uint8_T;
    } else {
      u0 = 0;
    }

    out[614400 + (j + 480 * i0)] = u0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *input
//                real_T *darkChannel
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel2
  (real_T *input, real_T *darkChannel)
{
  real_T cv;
  int32_T j;
  int32_T n;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 307200)) {
    //  Dark channel Estimation from input
    cv = input[j];
    for (n = j + 307201; n <= j + 614401; n += 307200) {
      if (input[n - 1] < cv) {
        cv = input[n - 1];
      }
    }

    darkChannel[j] = cv;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *darkChannel
//                real_T *diff_im
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel3
  (real_T *darkChannel, real_T *diff_im)
{
  int32_T j;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 307200)) {
    //  diff_im is used as input and output variable for anisotropic diffusion
    diff_im[j] = 0.9 * darkChannel[j];
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *expanded
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel4
  (real_T *expanded)
{
  int32_T j;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 309444)) {
    expanded[j] = 0.0;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *diff_im
//                real_T *expanded
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel5
  (real_T *diff_im, real_T *expanded)
{
  uint32_T threadId;
  int32_T j;
  int32_T i0;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  i0 = (int32_T)(threadId / 480U);
  j = (int32_T)(threadId - (uint32_T)i0 * 480U);
  if ((!(int32_T)(j >= 480)) && (!(int32_T)(i0 >= 640))) {
    expanded[(j + 482 * (1 + i0)) + 1] = diff_im[j + 480 * i0];
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *expanded
//                real_T *diff_im
// Return Type  : void
//
static __global__ __launch_bounds__(1024, 1) void fog_rectification_kernel6
  (real_T *expanded, real_T *diff_im)
{
  real_T cv;
  int32_T n;
  int32_T j;
  int32_T threadIdY;
  int32_T threadIdX;
  __shared__ real_T expanded_shared[1156];
  int32_T baseR;
  int32_T srow;
  int32_T strideRow;
  int32_T scol;
  int32_T strideCol;
  int32_T y_idx;
  int32_T baseC;
  int32_T x_idx;
  ;
  ;
  threadIdY = (int32_T)(blockDim.y * blockIdx.y + threadIdx.y);
  threadIdX = (int32_T)(blockDim.x * blockIdx.x + threadIdx.x);
  baseR = threadIdX;
  srow = (int32_T)threadIdx.x;
  strideRow = (int32_T)blockDim.x;
  scol = (int32_T)threadIdx.y;
  strideCol = (int32_T)blockDim.y;
  for (y_idx = srow; y_idx <= 33; y_idx += strideRow) {
    baseC = threadIdY;
    for (x_idx = scol; x_idx <= 33; x_idx += strideCol) {
      if (((int32_T)(((int32_T)(baseR >= 0)) && ((int32_T)(baseR < 482)))) &&
          ((int32_T)(((int32_T)(baseC >= 0)) && ((int32_T)(baseC < 642))))) {
        expanded_shared[y_idx + 34 * x_idx] = (real_T)expanded[482 * baseC +
          baseR];
      } else {
        expanded_shared[y_idx + 34 * x_idx] = 0.0;
      }

      baseC += strideCol;
    }

    baseR += strideRow;
  }

  __syncthreads();
  if ((!(int32_T)(threadIdX >= 480)) && (!(int32_T)(threadIdY >= 640))) {
    cv = 0.0;
    for (n = 0; n < 3; n++) {
      for (j = 0; j < 3; j++) {
        cv += expanded_shared[((int32_T)threadIdx.x + ((j + threadIdX) -
          threadIdX)) + 34 * ((int32_T)threadIdx.y + ((n + threadIdY) -
          threadIdY))] * const_b[(3 * (2 - n) - j) + 2];
      }
    }

    diff_im[threadIdX + 480 * threadIdY] = cv;
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *diff_im
//                real_T *y
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel7
  (real_T *diff_im, real_T *y)
{
  int32_T j;
  ;
  ;
  j = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(j >= 307200)) {
    //  Reduction with min
    y[j] = diff_im[j];
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *y
//                real_T *diff_im
//                real_T *darkChannel
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel8
  (real_T *y, real_T *diff_im, real_T *darkChannel)
{
  real_T u1;
  int32_T n;
  ;
  ;
  n = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(int32_T)(n >= 307200)) {
    //  Parallel element-wise math to compute
    //   Restoration with inverse Koschmieder's law
    u1 = y[n];
    if (darkChannel[n] < y[n]) {
      u1 = darkChannel[n];
    }

    diff_im[n] = u1;
    diff_im[n] *= 0.6;
    darkChannel[n] = 1.0 / (1.0 - diff_im[n]);
  }
}

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real_T *darkChannel
//                real_T *diff_im
//                real_T *input
//                real_T *restoreOut
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void fog_rectification_kernel9
  (real_T *darkChannel, real_T *diff_im, real_T *input, real_T *restoreOut)
{
  uint32_T threadId;
  int32_T j;
  int32_T i0;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  i0 = (int32_T)(threadId / 480U);
  j = (int32_T)(threadId - (uint32_T)i0 * 480U);
  if ((!(int32_T)(j >= 480)) && (!(int32_T)(i0 >= 640))) {
    restoreOut[j + 480 * i0] = (input[j + 480 * i0] - diff_im[j + 480 * i0]) *
      darkChannel[j + 480 * i0];
    restoreOut[307200 + (j + 480 * i0)] = (input[307200 + (j + 480 * i0)] -
      diff_im[j + 480 * i0]) * darkChannel[j + 480 * i0];
    restoreOut[614400 + (j + 480 * i0)] = (input[614400 + (j + 480 * i0)] -
      diff_im[j + 480 * i0]) * darkChannel[j + 480 * i0];
  }
}

//
// Arguments    : real_T u
// Return Type  : real_T
//
static __device__ real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

//
// Copyright 2017 The MathWorks, Inc.
// Arguments    : const uint8_T input[921600]
//                uint8_T out[921600]
// Return Type  : void
//
void fog_rectification(const uint8_T input[921600], uint8_T out[921600])
{
  int32_T idx;
  int32_T i0;
  int32_T i;
  static const real_T b[9] = { 0.0625, 0.125, 0.0625, 0.125, 0.25, 0.125, 0.0625,
    0.125, 0.0625 };

  static uint8_T im_gray[307200];
  static const real_T b_b[3] = { 0.29893602129377539, 0.58704307445112125,
    0.11402090425510336 };

  real_T cdf[256];
  real_T localBins1[256];
  real_T localBins2[256];
  real_T localBins3[256];
  int32_T ii_size[1];
  int32_T varargin_1;
  int32_T b_ii_size[1];
  real_T y;
  real_T b_y;
  real_T y_data[255];
  int32_T y_size[2];
  int32_T ndbl;
  int16_T i1;
  int16_T i2;
  real_T c_y;
  int32_T absb;
  int32_T u0;
  uint32_T u1;
  int32_T b_y_size[2];
  real_T d_y;
  real_T e_y;
  int32_T T_size[2];
  real_T T_data[771];
  uint8_T *gpu_input;
  real_T *b_gpu_input;
  real_T *gpu_darkChannel;
  real_T *gpu_diff_im;
  real_T *gpu_expanded;
  real_T *gpu_y;
  real_T *gpu_restoreOut;
  uint8_T *b_gpu_restoreOut;
  real_T *gpu_b;
  uint8_T *gpu_im_gray;
  real_T *gpu_localBins3;
  real_T *gpu_localBins2;
  real_T *gpu_localBins1;
  real_T *gpu_cdf;
  int32_T *gpu_y_size;
  int32_T *b_gpu_y_size;
  int32_T *gpu_ii_size;
  int32_T *gpu_T_size;
  real_T *gpu_T_data;
  uint8_T *gpu_out;
  boolean_T im_gray_dirtyOnGpu;
  boolean_T localBins3_dirtyOnGpu;
  boolean_T localBins2_dirtyOnGpu;
  boolean_T localBins1_dirtyOnGpu;
  boolean_T cdf_dirtyOnGpu;
  boolean_T T_size_dirtyOnGpu;
  boolean_T localBins3_dirtyOnCpu;
  boolean_T localBins2_dirtyOnCpu;
  boolean_T localBins1_dirtyOnCpu;
  boolean_T cdf_dirtyOnCpu;
  boolean_T T_data_dirtyOnCpu;
  boolean_T exitg1;
  cudaMalloc(&gpu_out, 921600ULL);
  cudaMalloc(&gpu_T_data, 771U * sizeof(real_T));
  cudaMalloc(&gpu_T_size, 8ULL);
  cudaMalloc(&gpu_y_size, 8ULL);
  cudaMalloc(&b_gpu_y_size, 8ULL);
  cudaMalloc(&gpu_ii_size, 4ULL);
  cudaMalloc(&gpu_localBins1, 2048ULL);
  cudaMalloc(&gpu_localBins2, 2048ULL);
  cudaMalloc(&gpu_localBins3, 2048ULL);
  cudaMalloc(&gpu_cdf, 2048ULL);
  cudaMalloc(&gpu_im_gray, 307200ULL);
  cudaMalloc(&gpu_b, 24ULL);
  cudaMalloc(&b_gpu_restoreOut, 921600ULL);
  cudaMalloc(&gpu_restoreOut, 7372800ULL);
  cudaMalloc(&gpu_y, 2457600ULL);
  cudaMalloc(&gpu_diff_im, 2457600ULL);
  cudaMalloc(&gpu_expanded, 2475552ULL);
  cudaMalloc(&gpu_darkChannel, 2457600ULL);
  cudaMalloc(&b_gpu_input, 7372800ULL);
  cudaMalloc(&gpu_input, 921600ULL);
  T_data_dirtyOnCpu = false;
  cdf_dirtyOnCpu = false;
  localBins1_dirtyOnCpu = false;
  localBins2_dirtyOnCpu = false;
  localBins3_dirtyOnCpu = false;

  //  restoreOut is used to store the output of restoration
  //  Changing the precision level of input image to double
  cudaMemcpy((void *)gpu_input, (void *)&input[0], 921600ULL,
             cudaMemcpyHostToDevice);
  fog_rectification_kernel1<<<dim3(1800U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_input, b_gpu_input);

  //  Dark channel Estimation from input
  fog_rectification_kernel2<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (b_gpu_input, gpu_darkChannel);

  //  diff_im is used as input and output variable for anisotropic diffusion
  fog_rectification_kernel3<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_darkChannel, gpu_diff_im);

  //  2D convolution mask for Anisotropic diffusion
  //  Refine dark channel using Anisotropic diffusion.
  for (idx = 0; idx < 3; idx++) {
    fog_rectification_kernel4<<<dim3(605U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (gpu_expanded);
    fog_rectification_kernel5<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (gpu_diff_im, gpu_expanded);
    cudaMemcpyToSymbol(const_b, b, 72ULL, 0ULL, cudaMemcpyHostToDevice);
    fog_rectification_kernel6<<<dim3(15U, 20U, 1U), dim3(32U, 32U, 1U)>>>
      (gpu_expanded, gpu_diff_im);
  }

  //  Reduction with min
  fog_rectification_kernel7<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_diff_im, gpu_y);

  //  Parallel element-wise math to compute
  //   Restoration with inverse Koschmieder's law
  fog_rectification_kernel8<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>(gpu_y,
    gpu_diff_im, gpu_darkChannel);
  fog_rectification_kernel9<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_darkChannel, gpu_diff_im, b_gpu_input, gpu_restoreOut);
  fog_rectification_kernel10<<<dim3(1800U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_restoreOut, b_gpu_restoreOut);

  // %%%%%% streching performs the histogram streching of the image %%%%%%%
  // %%%%%%%% im is the input color image and p is cdf limit
  // %%%%% out is the contrast streched image and cdf is the cumulative prob
  // %%%%% density function and T is the streching function
  //  rgbtograyconversion
  cudaMemcpy((void *)gpu_b, (void *)&b_b[0], 24ULL, cudaMemcpyHostToDevice);
  fog_rectification_kernel11<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>(gpu_b,
    b_gpu_restoreOut, gpu_im_gray);
  im_gray_dirtyOnGpu = true;

  //  histogram calculation
  fog_rectification_kernel12<<<dim3(1U, 1U, 1U), dim3(256U, 1U, 1U)>>>
    (gpu_localBins3, gpu_localBins2, gpu_localBins1, gpu_cdf);
  cdf_dirtyOnGpu = true;
  localBins1_dirtyOnGpu = true;
  localBins2_dirtyOnGpu = true;
  localBins3_dirtyOnGpu = true;
  for (i = 1; i + 3 <= 307200; i += 4) {
    if (im_gray_dirtyOnGpu) {
      cudaMemcpy((void *)&im_gray[0], (void *)gpu_im_gray, 307200ULL,
                 cudaMemcpyDeviceToHost);
      im_gray_dirtyOnGpu = false;
    }

    if (localBins1_dirtyOnGpu) {
      cudaMemcpy((void *)&localBins1[0], (void *)gpu_localBins1, 2048ULL,
                 cudaMemcpyDeviceToHost);
      localBins1_dirtyOnGpu = false;
    }

    localBins1[im_gray[i - 1]]++;
    localBins1_dirtyOnCpu = true;
    if (localBins2_dirtyOnGpu) {
      cudaMemcpy((void *)&localBins2[0], (void *)gpu_localBins2, 2048ULL,
                 cudaMemcpyDeviceToHost);
      localBins2_dirtyOnGpu = false;
    }

    localBins2[im_gray[i]]++;
    localBins2_dirtyOnCpu = true;
    if (localBins3_dirtyOnGpu) {
      cudaMemcpy((void *)&localBins3[0], (void *)gpu_localBins3, 2048ULL,
                 cudaMemcpyDeviceToHost);
      localBins3_dirtyOnGpu = false;
    }

    localBins3[im_gray[i + 1]]++;
    localBins3_dirtyOnCpu = true;
    if (cdf_dirtyOnGpu) {
      cudaMemcpy((void *)&cdf[0], (void *)gpu_cdf, 2048ULL,
                 cudaMemcpyDeviceToHost);
      cdf_dirtyOnGpu = false;
    }

    cdf[im_gray[i + 2]]++;
    cdf_dirtyOnCpu = true;
  }

  for (idx = 0; idx < 307200; idx++) {
    if (1 + idx >= i) {
      if (im_gray_dirtyOnGpu) {
        cudaMemcpy((void *)&im_gray[0], (void *)gpu_im_gray, 307200ULL,
                   cudaMemcpyDeviceToHost);
        im_gray_dirtyOnGpu = false;
      }

      if (cdf_dirtyOnGpu) {
        cudaMemcpy((void *)&cdf[0], (void *)gpu_cdf, 2048ULL,
                   cudaMemcpyDeviceToHost);
        cdf_dirtyOnGpu = false;
      }

      cdf[im_gray[idx]]++;
      cdf_dirtyOnCpu = true;
    }
  }

  //  cumulative Sum calculation
  if (localBins3_dirtyOnCpu) {
    cudaMemcpy((void *)gpu_localBins3, (void *)&localBins3[0], 2048ULL,
               cudaMemcpyHostToDevice);
  }

  if (localBins2_dirtyOnCpu) {
    cudaMemcpy((void *)gpu_localBins2, (void *)&localBins2[0], 2048ULL,
               cudaMemcpyHostToDevice);
  }

  if (localBins1_dirtyOnCpu) {
    cudaMemcpy((void *)gpu_localBins1, (void *)&localBins1[0], 2048ULL,
               cudaMemcpyHostToDevice);
  }

  if (cdf_dirtyOnCpu) {
    cudaMemcpy((void *)gpu_cdf, (void *)&cdf[0], 2048ULL, cudaMemcpyHostToDevice);
  }

  fog_rectification_kernel13<<<dim3(1U, 1U, 1U), dim3(256U, 1U, 1U)>>>
    (gpu_localBins3, gpu_localBins2, gpu_localBins1, gpu_cdf);
  cdf_dirtyOnGpu = true;
  for (i = 0; i < 255; i++) {
    if (cdf_dirtyOnGpu) {
      cudaMemcpy((void *)&cdf[0], (void *)gpu_cdf, 2048ULL,
                 cudaMemcpyDeviceToHost);
      cdf_dirtyOnGpu = false;
    }

    cdf[1 + i] += cdf[i];
  }

  //  finding less than particular probability
  idx = 0;
  ii_size[0] = 256;
  i = 1;
  exitg1 = false;
  while ((!exitg1) && (i < 257)) {
    if (cdf_dirtyOnGpu) {
      cudaMemcpy((void *)&cdf[0], (void *)gpu_cdf, 2048ULL,
                 cudaMemcpyDeviceToHost);
      cdf_dirtyOnGpu = false;
    }

    if (cdf[i - 1] <= 0.05) {
      idx++;
      if (idx >= 256) {
        exitg1 = true;
      } else {
        i++;
      }
    } else {
      i++;
    }
  }

  if (1 > idx) {
    varargin_1 = 0;
    ii_size[0] = 0;
  } else {
    varargin_1 = idx;
    ii_size[0] = idx;
  }

  idx = 0;
  i = 1;
  exitg1 = false;
  while ((!exitg1) && (i < 257)) {
    if (cdf_dirtyOnGpu) {
      cudaMemcpy((void *)&cdf[0], (void *)gpu_cdf, 2048ULL,
                 cudaMemcpyDeviceToHost);
      cdf_dirtyOnGpu = false;
    }

    if (cdf[i - 1] >= 0.95) {
      idx++;
      if (idx >= 256) {
        exitg1 = true;
      } else {
        i++;
      }
    } else {
      i++;
    }
  }

  if (1 > idx) {
    i0 = 0;
    b_ii_size[0] = 0;
  } else {
    i0 = idx;
    b_ii_size[0] = idx;
  }

  y = 25.0 / (real_T)ii_size[0];
  b_y = 204.0 / (255.0 - (real_T)(b_ii_size[0] + ii_size[0]));
  if (255 - i0 < varargin_1 + 1) {
    y_size[0] = 1;
    y_size[1] = 0;
  } else if (ii_size[0] + 1 == varargin_1 + 1) {
    i1 = (int16_T)(varargin_1 + 1);
    i2 = (int16_T)(255 - i0);
    y_size[0] = 1;
    y_size[1] = (int16_T)((int16_T)(255 - b_ii_size[0]) - (int16_T)(ii_size[0] +
      1)) + 1;
    for (i = 0; i <= (int32_T)(int16_T)(i2 - i1); i++) {
      y_data[i] = (int16_T)((int16_T)(varargin_1 + 1) + i);
    }
  } else {
    ndbl = (int32_T)std::floor((254.0 - (real_T)(b_ii_size[0] + ii_size[0])) +
      0.5);
    i = varargin_1 + ndbl;
    idx = (i + i0) - 254;
    absb = (int32_T)std::abs(255.0 - (real_T)i0);
    u0 = varargin_1 + 1;
    if (u0 > absb) {
      absb = u0;
    }

    if (std::abs((real_T)idx) < 4.4408920985006262E-16 * (real_T)absb) {
      ndbl++;
      u0 = 255 - i0;
    } else if (idx > 0) {
      u0 = varargin_1 + ndbl;
    } else {
      ndbl++;
      u0 = i + 1;
    }

    if (ndbl >= 0) {
      idx = ndbl;
    } else {
      idx = 0;
    }

    y_size[0] = 1;
    y_size[1] = idx;
    if (idx > 0) {
      y_data[0] = (real_T)varargin_1 + 1.0;
      if (idx > 1) {
        y_data[idx - 1] = u0;
        absb = (idx - 1) / 2;
        for (i = 0; i < 126; i++) {
          if (1 + i <= absb - 1) {
            y_data[1 + i] = ((real_T)(varargin_1 + i) + 1.0) + 1.0;
            y_data[(idx - i) - 2] = (u0 - i) - 1;
          }
        }

        if (absb << 1 == idx - 1) {
          y_data[absb] = ((real_T)(varargin_1 + u0) + 1.0) / 2.0;
        } else {
          y_data[absb] = (real_T)(varargin_1 + absb) + 1.0;
          y_data[absb + 1] = u0 - absb;
        }
      }
    }
  }

  c_y = 26.0 / (255.0 - (255.0 - (real_T)b_ii_size[0]));
  if (255 < 256 - b_ii_size[0]) {
    b_y_size[0] = 1;
    b_y_size[1] = 0;
  } else {
    u1 = (uint32_T)((255.0 - (real_T)b_ii_size[0]) + 1.0);
    b_y_size[0] = 1;
    b_y_size[1] = (int32_T)(255.0 - ((255.0 - (real_T)i0) + 1.0)) + 1;
    for (i = 0; i <= (int32_T)(255.0 - (real_T)u1); i++) {
      if (cdf_dirtyOnGpu) {
        cudaMemcpy((void *)&cdf[0], (void *)gpu_cdf, 2048ULL,
                   cudaMemcpyDeviceToHost);
        cdf_dirtyOnGpu = false;
      }

      cdf[i] = ((255.0 - (real_T)i0) + 1.0) + (real_T)i;
    }
  }

  d_y = 204.0 / (255.0 - (real_T)(i0 + varargin_1)) * (real_T)varargin_1;
  e_y = 26.0 / (255.0 - (255.0 - (real_T)i0)) * (255.0 - (real_T)b_ii_size[0]);
  cudaMemcpy((void *)gpu_y_size, (void *)&b_y_size[0], 8ULL,
             cudaMemcpyHostToDevice);
  cudaMemcpy((void *)b_gpu_y_size, (void *)&y_size[0], 8ULL,
             cudaMemcpyHostToDevice);
  cudaMemcpy((void *)gpu_ii_size, (void *)&ii_size[0], 4ULL,
             cudaMemcpyHostToDevice);
  fog_rectification_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_y_size,
    b_gpu_y_size, gpu_ii_size, gpu_T_size);
  T_size_dirtyOnGpu = true;
  for (i0 = 0; i0 <= varargin_1; i0++) {
    if (T_size_dirtyOnGpu) {
      cudaMemcpy((void *)&T_size[0], (void *)gpu_T_size, 8ULL,
                 cudaMemcpyDeviceToHost);
      T_size_dirtyOnGpu = false;
    }

    T_data[i0] = y * (real_T)i0;
    T_data_dirtyOnCpu = true;
  }

  i = y_size[1];
  for (i0 = 0; i0 < i; i0++) {
    if (T_size_dirtyOnGpu) {
      cudaMemcpy((void *)&T_size[0], (void *)gpu_T_size, 8ULL,
                 cudaMemcpyDeviceToHost);
      T_size_dirtyOnGpu = false;
    }

    T_data[(i0 + varargin_1) + 1] = (b_y * y_data[i0] - d_y) + 25.0;
    T_data_dirtyOnCpu = true;
  }

  i = b_y_size[1];
  for (i0 = 0; i0 < i; i0++) {
    if (T_size_dirtyOnGpu) {
      cudaMemcpy((void *)&T_size[0], (void *)gpu_T_size, 8ULL,
                 cudaMemcpyDeviceToHost);
      T_size_dirtyOnGpu = false;
    }

    if (cdf_dirtyOnGpu) {
      cudaMemcpy((void *)&cdf[0], (void *)gpu_cdf, 2048ULL,
                 cudaMemcpyDeviceToHost);
      cdf_dirtyOnGpu = false;
    }

    T_data[((i0 + varargin_1) + y_size[1]) + 1] = (c_y * cdf[i0] - e_y) + 229.0;
    T_data_dirtyOnCpu = true;
  }

  if (T_size_dirtyOnGpu) {
    cudaMemcpy((void *)&T_size[0], (void *)gpu_T_size, 8ULL,
               cudaMemcpyDeviceToHost);
  }

  i = T_size[1];
  if (T_data_dirtyOnCpu) {
    cudaMemcpy((void *)gpu_T_data, (void *)&T_data[0], T_size[0] * T_size[1] *
               sizeof(real_T), cudaMemcpyHostToDevice);
  }

  fog_rectification_kernel15<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(i,
    gpu_T_data);

  //  Replacing the value from look up table
  fog_rectification_kernel16<<<dim3(1800U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (b_gpu_restoreOut);
  fog_rectification_kernel17<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_T_data, b_gpu_restoreOut, gpu_out);
  fog_rectification_kernel18<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_T_data, b_gpu_restoreOut, gpu_out);
  fog_rectification_kernel19<<<dim3(600U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_T_data, b_gpu_restoreOut, gpu_out);
  cudaMemcpy((void *)&out[0], (void *)gpu_out, 921600ULL, cudaMemcpyDeviceToHost);
  cudaFree(gpu_input);
  cudaFree(b_gpu_input);
  cudaFree(gpu_darkChannel);
  cudaFree(gpu_expanded);
  cudaFree(gpu_diff_im);
  cudaFree(gpu_y);
  cudaFree(gpu_restoreOut);
  cudaFree(b_gpu_restoreOut);
  cudaFree(gpu_b);
  cudaFree(gpu_im_gray);
  cudaFree(gpu_cdf);
  cudaFree(gpu_localBins3);
  cudaFree(gpu_localBins2);
  cudaFree(gpu_localBins1);
  cudaFree(gpu_ii_size);
  cudaFree(b_gpu_y_size);
  cudaFree(gpu_y_size);
  cudaFree(gpu_T_size);
  cudaFree(gpu_T_data);
  cudaFree(gpu_out);
}

//
// File trailer for fog_rectification.cu
//
// [EOF]
//
