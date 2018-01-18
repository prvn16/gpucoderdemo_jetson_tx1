
#include "cnn_exec.hpp"
CnnMain::CnnMain()
{
    this->numLayers = 25;
    this->cublasHandle = 0;
    this->cudnnHandle = 0;
    this->workSpace = 0;
    this->layers[0] = new MWInputLayer;
    this->layers[1] = new MWConvLayer;
    this->layers[2] = new MWReLULayer;
    this->layers[3] = new MWNormLayer;
    this->layers[4] = new MWMaxPoolingLayer;
    this->layers[5] = new MWConvLayer;
    this->layers[6] = new MWReLULayer;
    this->layers[7] = new MWNormLayer;
    this->layers[8] = new MWMaxPoolingLayer;
    this->layers[9] = new MWConvLayer;
    this->layers[10] = new MWReLULayer;
    this->layers[11] = new MWConvLayer;
    this->layers[12] = new MWReLULayer;
    this->layers[13] = new MWConvLayer;
    this->layers[14] = new MWReLULayer;
    this->layers[15] = new MWMaxPoolingLayer;
    this->layers[16] = new MWFCLayer;
    this->layers[17] = new MWReLULayer;
    this->layers[18] = new MWPassthroughLayer;
    this->layers[19] = new MWFCLayer;
    this->layers[20] = new MWReLULayer;
    this->layers[21] = new MWPassthroughLayer;
    this->layers[22] = new MWFCLayer;
    this->layers[23] = new MWSoftmaxLayer;
    this->layers[24] = new MWOutputLayer;
}
void CnnMain::setup()
{
    int32_T idx_handles;
    int32_T idx_ws;
    this->cublasHandle = new cublasHandle_t;
    cublasCreate(this->cublasHandle);
    this->cudnnHandle = new cudnnHandle_t;
    cudnnCreate(this->cudnnHandle);
    for (idx_handles = 0; idx_handles < 25; idx_handles++) {
        this->layers[idx_handles]->setCublasHandle(this->cublasHandle);
        this->layers[idx_handles]->setCudnnHandle(this->cudnnHandle);
    }
    this->layers[0]->createInputLayer(1, 227, 227, 3, 1);
    this->layers[0]->loadAvg(".\\codegen\\cnn_CnnMain_avg_3");
    this->layers[1]->createConvLayer(this->layers[0], 11, 11, 3, 96, 4, 4, 0, 0, 1);
    this->layers[1]->loadWeights(".\\codegen\\cnn_CnnMain_conv1_w_3");
    this->layers[1]->loadBias(".\\codegen\\cnn_CnnMain_conv1_b_3");
    this->layers[2]->createReLULayer(this->layers[1]);
    this->layers[3]->createNormLayer(this->layers[2], 5, 0.0001, 0.75, 1.0);
    this->layers[4]->createMaxPoolingLayer(this->layers[3], 3, 3, 2, 2, 0, 0);
    this->layers[5]->createConvLayer(this->layers[4], 5, 5, 48, 128, 1, 1, 2, 2, 2);
    this->layers[5]->loadWeights(".\\codegen\\cnn_CnnMain_conv2_w_3");
    this->layers[5]->loadBias(".\\codegen\\cnn_CnnMain_conv2_b_3");
    this->layers[6]->createReLULayer(this->layers[5]);
    this->layers[7]->createNormLayer(this->layers[6], 5, 0.0001, 0.75, 1.0);
    this->layers[8]->createMaxPoolingLayer(this->layers[7], 3, 3, 2, 2, 0, 0);
    this->layers[9]->createConvLayer(this->layers[8], 3, 3, 256, 384, 1, 1, 1, 1, 1);
    this->layers[9]->loadWeights(".\\codegen\\cnn_CnnMain_conv3_w_3");
    this->layers[9]->loadBias(".\\codegen\\cnn_CnnMain_conv3_b_3");
    this->layers[10]->createReLULayer(this->layers[9]);
    this->layers[11]->createConvLayer(this->layers[10], 3, 3, 192, 192, 1, 1, 1, 1, 2);
    this->layers[11]->loadWeights(".\\codegen\\cnn_CnnMain_conv4_w_3");
    this->layers[11]->loadBias(".\\codegen\\cnn_CnnMain_conv4_b_3");
    this->layers[12]->createReLULayer(this->layers[11]);
    this->layers[13]->createConvLayer(this->layers[12], 3, 3, 192, 128, 1, 1, 1, 1, 2);
    this->layers[13]->loadWeights(".\\codegen\\cnn_CnnMain_conv5_w_3");
    this->layers[13]->loadBias(".\\codegen\\cnn_CnnMain_conv5_b_3");
    this->layers[14]->createReLULayer(this->layers[13]);
    this->layers[15]->createMaxPoolingLayer(this->layers[14], 3, 3, 2, 2, 0, 0);
    this->layers[16]->createFCLayer(this->layers[15], 9216, 4096);
    this->layers[16]->loadWeights(".\\codegen\\cnn_CnnMain_fc6_w_3");
    this->layers[16]->loadBias(".\\codegen\\cnn_CnnMain_fc6_b_3");
    this->layers[17]->createReLULayer(this->layers[16]);
    this->layers[18]->createPassthroughLayer(this->layers[17]);
    this->layers[19]->createFCLayer(this->layers[18], 4096, 4096);
    this->layers[19]->loadWeights(".\\codegen\\cnn_CnnMain_fc7_w_3");
    this->layers[19]->loadBias(".\\codegen\\cnn_CnnMain_fc7_b_3");
    this->layers[20]->createReLULayer(this->layers[19]);
    this->layers[21]->createPassthroughLayer(this->layers[20]);
    this->layers[22]->createFCLayer(this->layers[21], 4096, 1000);
    this->layers[22]->loadWeights(".\\codegen\\cnn_CnnMain_fc8_w_3");
    this->layers[22]->loadBias(".\\codegen\\cnn_CnnMain_fc8_b_3");
    this->layers[23]->createSoftmaxLayer(this->layers[22]);
    this->layers[24]->createOutputLayer(this->layers[23]);
    this->layers[24]->createWorkSpace((&this->workSpace));
    for (idx_ws = 0; idx_ws < 25; idx_ws++) {
        this->layers[idx_ws]->setWorkSpace(this->workSpace);
    }
    this->inputData = this->layers[0]->getData();
    this->outputData = this->layers[24]->getData();
}
void CnnMain::predict()
{
    int32_T idx;
    for (idx = 0; idx < 25; idx++) {
        this->layers[idx]->predict();
    }
}
void CnnMain::cleanup()
{
    int32_T idx;
    for (idx = 0; idx < 25; idx++) {
        this->layers[idx]->cleanup();
    }
    if (this->workSpace) {
        cudaFree(this->workSpace);
    }
    if (this->cublasHandle) {
        cublasDestroy(*this->cublasHandle);
    }
    if (this->cudnnHandle) {
        cudnnDestroy(*this->cudnnHandle);
    }
}
CnnMain::~CnnMain()
{
    int32_T idx;
    this->cleanup();
    for (idx = 0; idx < 25; idx++) {
        delete this->layers[idx];    }
}
