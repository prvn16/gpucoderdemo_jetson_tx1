#include "rtwtypes.h"
#include "stdio.h"
#include "string.h"
#include "cnn_api.hpp"

class CnnMain
{
  public:
    int32_T batchSize;
    int32_T numLayers;
    real32_T *inputData;
    real32_T *outputData;
    MWCNNLayer *layers[25];
  private:
    cublasHandle_t *cublasHandle;
    cudnnHandle_t *cudnnHandle;
    uint32_T workSpaceSize;
    real32_T *workSpace;
  public:
    CnnMain();
    void setup();
    void predict();
    void cleanup();
    ~CnnMain();
};
