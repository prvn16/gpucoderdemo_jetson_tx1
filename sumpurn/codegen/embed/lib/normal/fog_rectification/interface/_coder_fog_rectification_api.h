/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_fog_rectification_api.h
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 25-Jan-2018 08:58:04
 */

#ifndef _CODER_FOG_RECTIFICATION_API_H
#define _CODER_FOG_RECTIFICATION_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_fog_rectification_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void fog_rectification(uint8_T input[921600], uint8_T out[921600]);
extern void fog_rectification_api(const mxArray * const prhs[1], const mxArray
  *plhs[1]);
extern void fog_rectification_atexit(void);
extern void fog_rectification_initialize(void);
extern void fog_rectification_terminate(void);
extern void fog_rectification_xil_terminate(void);

#endif

/*
 * File trailer for _coder_fog_rectification_api.h
 *
 * [EOF]
 */
