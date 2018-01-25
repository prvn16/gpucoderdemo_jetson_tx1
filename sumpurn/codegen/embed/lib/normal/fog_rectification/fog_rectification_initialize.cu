//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: fog_rectification_initialize.cu
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 25-Jan-2018 08:58:04
//

// Include Files
#include "rt_nonfinite.h"
#include "fog_rectification.h"
#include "fog_rectification_initialize.h"

// Function Definitions

//
// Arguments    : void
// Return Type  : void
//
void fog_rectification_initialize()
{
  rt_InitInfAndNaN(8U);
}

//
// File trailer for fog_rectification_initialize.cu
//
// [EOF]
//
