#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdexcept>
#include <string>
#include <cassert>
#include "cnn_api.hpp"
#ifdef RANDOM
#include <curand.h>
 curandGenerator_t VCbcPxtPsBLTrHYdEvqn; void 
curand_call_line_file(curandStatus_t lteHjcLsItGbVPMQtGDB, const int 
eFaDPmxDdzHlRYSAoMmX, const char *RqCYCrGsNvzKYrRMXbsI) { if (lteHjcLsItGbVPMQtGDB != 
CURAND_STATUS_SUCCESS) { printf("%d, line: %d, file: %s\n", lteHjcLsItGbVPMQtGDB, 
eFaDPmxDdzHlRYSAoMmX, RqCYCrGsNvzKYrRMXbsI); exit(EXIT_FAILURE); } }
#endif
 void call_cuda_free(float* mem) { cudaError_t lteHjcLsItGbVPMQtGDB = 
cudaFree(mem); if (lteHjcLsItGbVPMQtGDB != cudaErrorCudartUnloading) { 
CUDA_CALL(lteHjcLsItGbVPMQtGDB); } } void cuda_call_line_file(cudaError_t 
lteHjcLsItGbVPMQtGDB, const int eFaDPmxDdzHlRYSAoMmX, const char *RqCYCrGsNvzKYrRMXbsI) { if 
(lteHjcLsItGbVPMQtGDB != cudaSuccess) { printf("%s, line: %d, file: %s\n", 
cudaGetErrorString(lteHjcLsItGbVPMQtGDB), eFaDPmxDdzHlRYSAoMmX, RqCYCrGsNvzKYrRMXbsI); 
exit(EXIT_FAILURE); } } void cudnn_call_line_file(cudnnStatus_t 
lteHjcLsItGbVPMQtGDB, const int eFaDPmxDdzHlRYSAoMmX, const char *RqCYCrGsNvzKYrRMXbsI) { if 
(lteHjcLsItGbVPMQtGDB != CUDNN_STATUS_SUCCESS) { 
printf("%s, line: %d, file: %s\n", cudnnGetErrorString(lteHjcLsItGbVPMQtGDB), 
eFaDPmxDdzHlRYSAoMmX, RqCYCrGsNvzKYrRMXbsI); exit(EXIT_FAILURE); } } const char* 
cublasGetErrorString(cublasStatus_t lteHjcLsItGbVPMQtGDB) { 
switch(lteHjcLsItGbVPMQtGDB) { case CUBLAS_STATUS_SUCCESS: return 
"CUBLAS_STATUS_SUCCESS"; case CUBLAS_STATUS_NOT_INITIALIZED: return 
"CUBLAS_STATUS_NOT_INITIALIZED"; case CUBLAS_STATUS_ALLOC_FAILED: return 
"CUBLAS_STATUS_ALLOC_FAILED"; case CUBLAS_STATUS_INVALID_VALUE: return 
"CUBLAS_STATUS_INVALID_VALUE";  case CUBLAS_STATUS_ARCH_MISMATCH: return 
"CUBLAS_STATUS_ARCH_MISMATCH";  case CUBLAS_STATUS_MAPPING_ERROR: return 
"CUBLAS_STATUS_MAPPING_ERROR"; case CUBLAS_STATUS_EXECUTION_FAILED: return 
"CUBLAS_STATUS_EXECUTION_FAILED";  case CUBLAS_STATUS_INTERNAL_ERROR: return 
"CUBLAS_STATUS_INTERNAL_ERROR";  case CUBLAS_STATUS_NOT_SUPPORTED: return 
"CUBLAS_STATUS_NOT_SUPPORTED";  case CUBLAS_STATUS_LICENSE_ERROR: return 
"CUBLAS_STATUS_LICENSE_ERROR";  } return "unknown error"; } void 
cublas_call_line_file(cublasStatus_t lteHjcLsItGbVPMQtGDB, const int 
eFaDPmxDdzHlRYSAoMmX, const char *RqCYCrGsNvzKYrRMXbsI) { if (lteHjcLsItGbVPMQtGDB != 
CUBLAS_STATUS_SUCCESS) { printf("%s, line: %d, file: %s\n", 
cublasGetErrorString(lteHjcLsItGbVPMQtGDB), eFaDPmxDdzHlRYSAoMmX, RqCYCrGsNvzKYrRMXbsI); 
exit(EXIT_FAILURE); } } MWCNNLayer::MWCNNLayer() : sRECVoNNtDdcBOWgDyar(NULL), 
AIXLuRgdeiqpaCehGSYD(1), BRSPqxNffoBYKqpSVHne(0), IbSWJNMuIiKbocfQKqXb(0), 
DqxLTLaJwwgQqmrtCDuu(0), ECTnqgWHyHCHCLBZlffd(0), 
xHViLEwTujGGrPZZgmbF(NULL), vxtNGOWYjhKeBBSzuIMB(NULL), xkUNToJIgvoLoUQuzKRF(NULL), 
OumvfgWXDdmsQaciHMHx(NULL), OwenhowBxTAXHXmJpIKd(NULL), 
QVgVGfoCXYiYXzPhvVPX(0.0), QMgBqCuvjnbWHWiVPEwn(1.0), PtkeOkuClHzhOfpmBevf(-1.0), 
bMAyVFGSPDjmUbziYLAy(0)  { 
CUDNN_CALL(cudnnCreateTensorDescriptor(getGroupDescriptor())); } 
MWCNNLayer::~MWCNNLayer() { 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getGroupDescriptor())); } FILE* 
MWCNNLayer::openBinaryFile(const char* fileName) { FILE* fp = fopen(fileName, 
"rb"); if (!fp) {
#if defined(_WIN32) || defined(_WIN64)
 char delim[] = "\\";
#else
 char delim[] = "/";
#endif
 std::string fileS(fileName); size_t pos = 0; while((pos = fileS.find(delim)) 
!= std::string::npos) { if (pos == (fileS.size() - 1)) { fileS = ""; break; } 
fileS = fileS.substr(pos+1); } if (!fileS.empty()) { fp = fopen(fileS.c_str(), 
"rb");  } if (!fp) { printf("Error! Unable to open file %s\n", fileS.c_str()); 
throw std::runtime_error("Error opening file!!\n"); } } return fp; } 
std::runtime_error MWCNNLayer::getFileOpenError(const char* filename) { const 
std::string message = std::string("Error! Unable to open file ") + 
std::string(filename); return std::runtime_error(message); } void 
MWCNNLayer::createInputLayer(int, int, int, int, bool) { return; } void 
MWCNNLayer::createReLULayer(MWCNNLayer*) { return; } void 
MWCNNLayer::createLeakyReLULayer(MWCNNLayer*, double) { return; } void 
MWCNNLayer::createBatchNormalizationLayer(MWCNNLayer*, double) { return; } void 
MWCNNLayer::createSoftmaxLayer(MWCNNLayer*) { return; } void 
MWCNNLayer::createOutputLayer(MWCNNLayer*) { return; } void 
MWCNNLayer::createFCLayer(MWCNNLayer*, int, int) { return; } void 
MWCNNLayer::createNormLayer(MWCNNLayer*, unsigned, double, double, double) { 
return; } void MWCNNLayer::createAvgPoolingLayer(MWCNNLayer*, int, int, int, 
int, int, int) { return; } void MWCNNLayer::createMaxPoolingLayer(MWCNNLayer*, 
int, int, int, int, int, int) { return; } void 
MWCNNLayer::createConvLayer(MWCNNLayer*, int, int, int, int, int, int, int, 
int, int) { return; } void MWCNNLayer::loadAvg(const char*) { return; } void 
MWCNNLayer::createPassthroughLayer(MWCNNLayer*) { return; } void 
MWCNNLayer::loadWeights(const char*) { return; } void 
MWCNNLayer::loadBias(const char*) { return; } void MWCNNLayer::setName(const 
char* n) { fOpFYwKNwIfWjnPzNuob = n; return; } void 
MWCNNLayer::createWorkSpace(float** wtNPjzxHKNoJIigzXrEl) { 
CUDA_CALL(cudaMalloc((void**)wtNPjzxHKNoJIigzXrEl, 
juRPduBvIGpwaZiftkzr)); return; } void MWCNNLayer::setBatchSize(int bs) 
{ AIXLuRgdeiqpaCehGSYD = bs; return; } int MWCNNLayer::getBatchSize() { return 
AIXLuRgdeiqpaCehGSYD; } void MWCNNLayer::setHeight(int ht) { BRSPqxNffoBYKqpSVHne 
= ht; return; } int MWCNNLayer::getHeight() { return BRSPqxNffoBYKqpSVHne; } void 
MWCNNLayer::setWidth(int wd) { IbSWJNMuIiKbocfQKqXb = wd; return; } int 
MWCNNLayer::getWidth() { return IbSWJNMuIiKbocfQKqXb; } void 
MWCNNLayer::setNumInputFeatures(int nif) { DqxLTLaJwwgQqmrtCDuu = nif; 
return; } int MWCNNLayer::getNumInputFeatures() { return 
DqxLTLaJwwgQqmrtCDuu; } void MWCNNLayer::setNumOutputFeatures(int nof) { 
ECTnqgWHyHCHCLBZlffd = nof; return; } int 
MWCNNLayer::getNumOutputFeatures() { return ECTnqgWHyHCHCLBZlffd; } 
void MWCNNLayer::setData(float* out) { xHViLEwTujGGrPZZgmbF = out; return; } float* 
MWCNNLayer::getData() { return xHViLEwTujGGrPZZgmbF; } float** MWCNNLayer::getDataPtr() 
{ return &xHViLEwTujGGrPZZgmbF; } void 
MWCNNLayer::setOutputDescriptor(cudnnTensorDescriptor_t od) { 
iPqBiFnIJMxelVhQBZex = od; return; } cudnnTensorDescriptor_t* 
MWCNNLayer::getOutputDescriptor() { return &iPqBiFnIJMxelVhQBZex; } void 
MWCNNLayer::setWorkSpaceSize(size_t wss) { juRPduBvIGpwaZiftkzr = wss; 
return; } size_t* MWCNNLayer::getWorkSpaceSize() { return 
&juRPduBvIGpwaZiftkzr; } void MWCNNLayer::setWorkSpace(float* ws) { 
vxtNGOWYjhKeBBSzuIMB = ws; return; } float* MWCNNLayer::getWorkSpace() { return 
vxtNGOWYjhKeBBSzuIMB; } void MWCNNLayer::setOutput2(float* out2) { 
xkUNToJIgvoLoUQuzKRF = out2; return; } float* MWCNNLayer::getOutput2() { return 
xkUNToJIgvoLoUQuzKRF; } void MWCNNLayer::setGroupDescriptor(cudnnTensorDescriptor_t 
gd) { XCLDbxHBtWRStETWIkId = gd; return; } cudnnTensorDescriptor_t* 
MWCNNLayer::getGroupDescriptor() { return &XCLDbxHBtWRStETWIkId; } void 
MWCNNLayer::setCublasHandle(cublasHandle_t* cub) { OumvfgWXDdmsQaciHMHx = 
cub; return; } cublasHandle_t* MWCNNLayer::getCublasHandle() { return 
OumvfgWXDdmsQaciHMHx; } void MWCNNLayer::setCudnnHandle(cudnnHandle_t* 
cud) { OwenhowBxTAXHXmJpIKd = cud; return; } cudnnHandle_t* 
MWCNNLayer::getCudnnHandle() { return OwenhowBxTAXHXmJpIKd; } float* 
MWCNNLayer::getZeroPtr() { return &QVgVGfoCXYiYXzPhvVPX; } float* 
MWCNNLayer::getOnePtr() { return &QMgBqCuvjnbWHWiVPEwn; } float* 
MWCNNLayer::getNegOnePtr() { return &PtkeOkuClHzhOfpmBevf; } float 
MWCNNLayer::getIsGrouped() { return bMAyVFGSPDjmUbziYLAy; } void 
MWCNNLayer::setIsGrouped(float ig) { bMAyVFGSPDjmUbziYLAy = ig; return; } 
MWCNNLayer* MWCNNLayer::getTop() { return sRECVoNNtDdcBOWgDyar; } void 
MWCNNLayer::setTop(MWCNNLayer* top) { assert(top != NULL); 
assert(sRECVoNNtDdcBOWgDyar== NULL);  sRECVoNNtDdcBOWgDyar = top; } 
MWInputLayer::MWInputLayer() : JgLfgHrHMEMmMYTettJF(NULL) { 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); 
CUDNN_CALL(cudnnCreateTensorDescriptor(&KCudOrFMfgCzUPMcdePX)); } 
MWInputLayer::~MWInputLayer() { } void MWInputLayer::createInputLayer(int 
eqOmMKQRpqBqRQCnJmxt, int XVcMnvCXvZpKICKIjgZi, int ugnnrhsgTeWucrMPCJUc, int NldNILHvuQqQPSAHXxdT, bool 
veFyKKHbdqBIvQLYBqfF) { setBatchSize(eqOmMKQRpqBqRQCnJmxt); 
setNumOutputFeatures(NldNILHvuQqQPSAHXxdT); setHeight(XVcMnvCXvZpKICKIjgZi); 
setWidth(ugnnrhsgTeWucrMPCJUc); bUVPfnrJhLfHzOLUUrKk = veFyKKHbdqBIvQLYBqfF; 
setWorkSpaceSize(0); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, getBatchSize(), getNumOutputFeatures(), 
getHeight(), getWidth())); CUDA_CALL(cudaMalloc((void**)getDataPtr(), 
sizeof(float)*getBatchSize()*getNumOutputFeatures()*getHeight()*getWidth())); 
if( bUVPfnrJhLfHzOLUUrKk ) { 
CUDNN_CALL(cudnnSetTensor4dDescriptor(KCudOrFMfgCzUPMcdePX, CUDNN_TENSOR_NCHW, 
CUDNN_DATA_FLOAT, 1, getNumOutputFeatures(), getHeight(), getWidth())); 
CUDA_CALL(cudaMalloc((void**)&JgLfgHrHMEMmMYTettJF, 
sizeof(float)*getNumOutputFeatures()*getHeight()*getWidth())); }
#ifdef RANDOM
 curandGenerateUniform(VCbcPxtPsBLTrHYdEvqn,getData(), getBatchSize()*getNumOutputFeatures()*getHeight()*getWidth());
#endif
 return; } void MWInputLayer::loadAvg(const char* SDWKEQTZaTFZByPlzUDR) { FILE* 
UKtMXCCqdjeyaVHabkxg = openBinaryFile(SDWKEQTZaTFZByPlzUDR); assert(UKtMXCCqdjeyaVHabkxg); int 
fhikqqlnUKCjleVKDqiG = getHeight()*getWidth()*getNumOutputFeatures();  float* 
NDjzAZSYJuWymuKDNZYB = (float*)malloc(sizeof(float)*fhikqqlnUKCjleVKDqiG); 
fread(NDjzAZSYJuWymuKDNZYB, sizeof(float), fhikqqlnUKCjleVKDqiG, UKtMXCCqdjeyaVHabkxg); 
CUDA_CALL(cudaMemcpy(JgLfgHrHMEMmMYTettJF, NDjzAZSYJuWymuKDNZYB, 
sizeof(float)*fhikqqlnUKCjleVKDqiG, cudaMemcpyHostToDevice)); 
free(NDjzAZSYJuWymuKDNZYB); fclose(UKtMXCCqdjeyaVHabkxg); return; } void 
MWInputLayer::predict() { if ( bUVPfnrJhLfHzOLUUrKk ) 
CUDNN_CALL(cudnnAddTensor(*getCudnnHandle(), getNegOnePtr(), 
KCudOrFMfgCzUPMcdePX, JgLfgHrHMEMmMYTettJF, getOnePtr(), *getOutputDescriptor(), 
getData())); return; } void MWInputLayer::cleanup() { 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); if 
(getData()) { call_cuda_free(getData()); } if ( bUVPfnrJhLfHzOLUUrKk ) { 
CUDNN_CALL(cudnnDestroyTensorDescriptor(KCudOrFMfgCzUPMcdePX)); if (JgLfgHrHMEMmMYTettJF) 
{ call_cuda_free(JgLfgHrHMEMmMYTettJF); } } return; } MWConvLayer::MWConvLayer() : 
ugnnrhsgTeWucrMPCJUc(NULL) , KHClOltUSuqFVVErSxVb(NULL) , vFNECEAeLZsYsUxvlgqL(NULL)  { 
CUDNN_CALL(cudnnCreateConvolutionDescriptor(&OKaRVOctKLlnIyGmjRNW)); 
CUDNN_CALL(cudnnCreateFilterDescriptor(&UEESbUvbMihFnquvuFij)); 
CUDNN_CALL(cudnnCreateTensorDescriptor(&MCrRCXUsCsGPMgQbvMOt)); 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); } 
MWConvLayer::~MWConvLayer() { } void MWConvLayer::createConvLayer(MWCNNLayer* 
jaqKGCwoANNDMHgAsehk, int jhFUWlztBndwjbXwYNaJ, int kNsviQGMPdXzNMRixGWR, int NldNILHvuQqQPSAHXxdT, 
int dJcdBfQQLhIAYHPxwQeg, int HtQBsWTCGEkpylRklilw, int IAlDgIFcchbwRGBSfVfA, int 
GFienSVKLlDQuZeqAdLC, int GeeOVBfQrpMacIFBLKOo, int UdmcwaUkepxfZrpdpcAN) { int 
olKGEIcsxmLSoMhRhEtP, nlIRrOJaFuVaywxOqOyb, npGnQZLrEfVTQnEbwqij, omxlPZbBePZdWaJOBUUG; 
setTop(jaqKGCwoANNDMHgAsehk); setBatchSize(getTop()->getBatchSize()); 
AzTsxYcYjIEJsGQbeYHm = jhFUWlztBndwjbXwYNaJ; BLjrjqvCcCommiXWQLjs = kNsviQGMPdXzNMRixGWR; 
setNumInputFeatures(NldNILHvuQqQPSAHXxdT*UdmcwaUkepxfZrpdpcAN); 
setNumOutputFeatures(dJcdBfQQLhIAYHPxwQeg*UdmcwaUkepxfZrpdpcAN); DSsxcjIrUgZCKZovyNQf = UdmcwaUkepxfZrpdpcAN;
#if (CUDNN_MAJOR <= 5)
 { CUDNN_CALL(cudnnSetConvolution2dDescriptor(OKaRVOctKLlnIyGmjRNW, 
GFienSVKLlDQuZeqAdLC, GeeOVBfQrpMacIFBLKOo, HtQBsWTCGEkpylRklilw, 
IAlDgIFcchbwRGBSfVfA, 1, 1, CUDNN_CROSS_CORRELATION));  }
#else
 { CUDNN_CALL(cudnnSetConvolution2dDescriptor(OKaRVOctKLlnIyGmjRNW, 
GFienSVKLlDQuZeqAdLC, GeeOVBfQrpMacIFBLKOo, HtQBsWTCGEkpylRklilw, 
IAlDgIFcchbwRGBSfVfA, 1, 1, CUDNN_CROSS_CORRELATION, CUDNN_DATA_FLOAT));  }
#endif
 if( DSsxcjIrUgZCKZovyNQf == 1 ) { 
CUDNN_CALL(cudnnSetFilter4dDescriptor(UEESbUvbMihFnquvuFij, CUDNN_DATA_FLOAT, 
CUDNN_TENSOR_NCHW, getNumOutputFeatures(), getNumInputFeatures(), 
AzTsxYcYjIEJsGQbeYHm, BLjrjqvCcCommiXWQLjs)); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(MCrRCXUsCsGPMgQbvMOt, CUDNN_TENSOR_NCHW, 
CUDNN_DATA_FLOAT, 1, getNumOutputFeatures(), 1, 1)); 
CUDNN_CALL(cudnnGetConvolution2dForwardOutputDim(OKaRVOctKLlnIyGmjRNW, 
*getTop()->getOutputDescriptor(), UEESbUvbMihFnquvuFij, &olKGEIcsxmLSoMhRhEtP, 
&nlIRrOJaFuVaywxOqOyb, &npGnQZLrEfVTQnEbwqij, &omxlPZbBePZdWaJOBUUG)); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, olKGEIcsxmLSoMhRhEtP, nlIRrOJaFuVaywxOqOyb, 
npGnQZLrEfVTQnEbwqij, omxlPZbBePZdWaJOBUUG)); 
CUDNN_CALL(cudnnGetConvolutionForwardAlgorithm(*getCudnnHandle(), 
*getTop()->getOutputDescriptor(), UEESbUvbMihFnquvuFij, OKaRVOctKLlnIyGmjRNW, 
*getOutputDescriptor(), CUDNN_CONVOLUTION_FWD_PREFER_FASTEST, 0, 
&NnAKUXChhnRnQmWsknGy)); 
CUDNN_CALL(cudnnGetConvolutionForwardWorkspaceSize(*getCudnnHandle(), 
*getTop()->getOutputDescriptor(), UEESbUvbMihFnquvuFij, OKaRVOctKLlnIyGmjRNW, 
*getOutputDescriptor(), NnAKUXChhnRnQmWsknGy, getWorkSpaceSize())); } else { if( 
getTop()->getIsGrouped() == 0 ) { 
CUDNN_CALL(cudnnSetTensor4dDescriptorEx(*getTop()->getGroupDescriptor(), 
CUDNN_DATA_FLOAT, getTop()->getBatchSize(), 
getTop()->getNumOutputFeatures()/DSsxcjIrUgZCKZovyNQf, getTop()->getHeight(), 
getTop()->getWidth(), 
getTop()->getNumOutputFeatures()*getTop()->getHeight()*getTop()->getWidth(), 
getTop()->getHeight()*getTop()->getWidth(), getTop()->getWidth(), 1)); 
getTop()->setOutput2(getTop()->getData() + 
getTop()->getNumOutputFeatures()/DSsxcjIrUgZCKZovyNQf * getTop()->getHeight() * 
getTop()->getWidth()); getTop()->setIsGrouped(1); } 
CUDNN_CALL(cudnnSetFilter4dDescriptor(UEESbUvbMihFnquvuFij, CUDNN_DATA_FLOAT, 
CUDNN_TENSOR_NCHW, getNumOutputFeatures()/DSsxcjIrUgZCKZovyNQf, 
getNumInputFeatures()/DSsxcjIrUgZCKZovyNQf, AzTsxYcYjIEJsGQbeYHm, 
BLjrjqvCcCommiXWQLjs)); 
CUDNN_CALL(cudnnGetConvolution2dForwardOutputDim(OKaRVOctKLlnIyGmjRNW, 
*getTop()->getGroupDescriptor(), UEESbUvbMihFnquvuFij, &olKGEIcsxmLSoMhRhEtP, 
&nlIRrOJaFuVaywxOqOyb, &npGnQZLrEfVTQnEbwqij, &omxlPZbBePZdWaJOBUUG)); 
CUDNN_CALL(cudnnSetTensor4dDescriptorEx(*getGroupDescriptor(), 
CUDNN_DATA_FLOAT, olKGEIcsxmLSoMhRhEtP, nlIRrOJaFuVaywxOqOyb, npGnQZLrEfVTQnEbwqij, 
omxlPZbBePZdWaJOBUUG, 
nlIRrOJaFuVaywxOqOyb*DSsxcjIrUgZCKZovyNQf*npGnQZLrEfVTQnEbwqij*omxlPZbBePZdWaJOBUUG, 
npGnQZLrEfVTQnEbwqij*omxlPZbBePZdWaJOBUUG, omxlPZbBePZdWaJOBUUG, 1)); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, olKGEIcsxmLSoMhRhEtP, 
nlIRrOJaFuVaywxOqOyb*DSsxcjIrUgZCKZovyNQf, npGnQZLrEfVTQnEbwqij, omxlPZbBePZdWaJOBUUG)); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(MCrRCXUsCsGPMgQbvMOt, CUDNN_TENSOR_NCHW, 
CUDNN_DATA_FLOAT, 1, nlIRrOJaFuVaywxOqOyb*DSsxcjIrUgZCKZovyNQf, 1, 1)); 
CUDNN_CALL(cudnnGetConvolutionForwardAlgorithm(*getCudnnHandle(), 
*getTop()->getGroupDescriptor(), UEESbUvbMihFnquvuFij, OKaRVOctKLlnIyGmjRNW, 
*getGroupDescriptor(), CUDNN_CONVOLUTION_FWD_PREFER_FASTEST, 0, 
&NnAKUXChhnRnQmWsknGy)); 
CUDNN_CALL(cudnnGetConvolutionForwardWorkspaceSize(*getCudnnHandle(), 
*getTop()->getGroupDescriptor(), UEESbUvbMihFnquvuFij, OKaRVOctKLlnIyGmjRNW, 
*getGroupDescriptor(), NnAKUXChhnRnQmWsknGy, getWorkSpaceSize())); } 
setHeight(npGnQZLrEfVTQnEbwqij); setWidth(omxlPZbBePZdWaJOBUUG); if( 
*getWorkSpaceSize() < *getTop()->getWorkSpaceSize() ) { 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); } 
CUDA_CALL(cudaMalloc((void**)getDataPtr(), 
sizeof(float)*getBatchSize()*getNumOutputFeatures()*getHeight()*getWidth())); 
CUDA_CALL(cudaMalloc((void**)&ugnnrhsgTeWucrMPCJUc, 
sizeof(float)*getNumInputFeatures()/DSsxcjIrUgZCKZovyNQf*getNumOutputFeatures()*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs)); 
CUDA_CALL(cudaMalloc((void**)&KHClOltUSuqFVVErSxVb, sizeof(float)*getNumOutputFeatures()));
#ifdef RANDOM
 curandGenerateNormal(VCbcPxtPsBLTrHYdEvqn, ugnnrhsgTeWucrMPCJUc, 
getNumInputFeatures()/DSsxcjIrUgZCKZovyNQf*getNumOutputFeatures()*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs, 
0, 0.1); curandGenerateNormal(VCbcPxtPsBLTrHYdEvqn, KHClOltUSuqFVVErSxVb, 
getNumOutputFeatures(), -0.5, 1);
#endif
 if( DSsxcjIrUgZCKZovyNQf == 2 ) { vFNECEAeLZsYsUxvlgqL = ugnnrhsgTeWucrMPCJUc + 
getNumOutputFeatures()/DSsxcjIrUgZCKZovyNQf * 
getNumInputFeatures()/DSsxcjIrUgZCKZovyNQf * AzTsxYcYjIEJsGQbeYHm * 
BLjrjqvCcCommiXWQLjs; setOutput2(getData() + getNumOutputFeatures() / 2 * 
getHeight() * getWidth()); setIsGrouped(1); } return; } void 
MWConvLayer::predict() { if( DSsxcjIrUgZCKZovyNQf == 1 ) { 
CUDNN_CALL(cudnnConvolutionForward(*getCudnnHandle(), getOnePtr(), 
*getTop()->getOutputDescriptor(), getTop()->getData(), UEESbUvbMihFnquvuFij, 
ugnnrhsgTeWucrMPCJUc, OKaRVOctKLlnIyGmjRNW, NnAKUXChhnRnQmWsknGy, getWorkSpace(), 
*getWorkSpaceSize(), getZeroPtr(), *getOutputDescriptor(),getData())); 
CUDNN_CALL(cudnnAddTensor(*getCudnnHandle(), getOnePtr(), 
MCrRCXUsCsGPMgQbvMOt,KHClOltUSuqFVVErSxVb, getOnePtr(), 
*getOutputDescriptor(),getData())); } else { 
CUDNN_CALL(cudnnConvolutionForward(*getCudnnHandle(), getOnePtr(), 
*(getTop()->getGroupDescriptor()), getTop()->getData(), UEESbUvbMihFnquvuFij, 
ugnnrhsgTeWucrMPCJUc, OKaRVOctKLlnIyGmjRNW, NnAKUXChhnRnQmWsknGy, getWorkSpace(), 
*getWorkSpaceSize(), getZeroPtr(), *getGroupDescriptor(), getData())); 
CUDNN_CALL(cudnnConvolutionForward(*getCudnnHandle(), getOnePtr(), 
*(getTop()->getGroupDescriptor()), getTop()->getOutput2(), 
UEESbUvbMihFnquvuFij, vFNECEAeLZsYsUxvlgqL, OKaRVOctKLlnIyGmjRNW, NnAKUXChhnRnQmWsknGy, 
getWorkSpace(), *getWorkSpaceSize(), getZeroPtr(), *getGroupDescriptor(), 
getOutput2())); CUDNN_CALL(cudnnAddTensor(*getCudnnHandle(), getOnePtr(), 
MCrRCXUsCsGPMgQbvMOt,KHClOltUSuqFVVErSxVb, getOnePtr(), 
*getOutputDescriptor(),getData())); } return; } void MWConvLayer::cleanup() { 
CUDNN_CALL(cudnnDestroyConvolutionDescriptor(OKaRVOctKLlnIyGmjRNW)); 
CUDNN_CALL(cudnnDestroyFilterDescriptor(UEESbUvbMihFnquvuFij)); if 
(ugnnrhsgTeWucrMPCJUc) { call_cuda_free(ugnnrhsgTeWucrMPCJUc); } 
CUDNN_CALL(cudnnDestroyTensorDescriptor(MCrRCXUsCsGPMgQbvMOt)); if 
(KHClOltUSuqFVVErSxVb) { call_cuda_free(KHClOltUSuqFVVErSxVb); } 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); if 
(getData()) { call_cuda_free(getData()); } return; } void 
MWConvLayer::loadWeights(const char* SDWKEQTZaTFZByPlzUDR) { FILE* UKtMXCCqdjeyaVHabkxg 
= openBinaryFile(SDWKEQTZaTFZByPlzUDR); assert(UKtMXCCqdjeyaVHabkxg); int 
fhikqqlnUKCjleVKDqiG = 
getNumInputFeatures()/DSsxcjIrUgZCKZovyNQf*getNumOutputFeatures()*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs; 
 float* NDjzAZSYJuWymuKDNZYB = (float*)malloc(sizeof(float)*fhikqqlnUKCjleVKDqiG); 
fread(NDjzAZSYJuWymuKDNZYB, sizeof(float), fhikqqlnUKCjleVKDqiG, UKtMXCCqdjeyaVHabkxg); if( 
AzTsxYcYjIEJsGQbeYHm != 1 && BLjrjqvCcCommiXWQLjs != 1 ) { float* 
NMMfJylfQjiIUAKhXCJb = 
(float*)malloc(sizeof(float)*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs); 
for(int k=0; k<fhikqqlnUKCjleVKDqiG/AzTsxYcYjIEJsGQbeYHm/BLjrjqvCcCommiXWQLjs; 
k++) { for(int i=0; i<AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs; i++) 
NMMfJylfQjiIUAKhXCJb[i]=NDjzAZSYJuWymuKDNZYB[k*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs+i]; 
for(int j=0; j<AzTsxYcYjIEJsGQbeYHm; j++) for(int i=0; 
i<BLjrjqvCcCommiXWQLjs; i++) 
NDjzAZSYJuWymuKDNZYB[k*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs+j*BLjrjqvCcCommiXWQLjs+i]=NMMfJylfQjiIUAKhXCJb[j+i*AzTsxYcYjIEJsGQbeYHm]; 
} free(NMMfJylfQjiIUAKhXCJb); } CUDA_CALL(cudaMemcpy(ugnnrhsgTeWucrMPCJUc, 
NDjzAZSYJuWymuKDNZYB, sizeof(float)*fhikqqlnUKCjleVKDqiG, cudaMemcpyHostToDevice));
#if 0
 printf("%s loaded. Size = %d. %f\n", SDWKEQTZaTFZByPlzUDR, fhikqqlnUKCjleVKDqiG, NDjzAZSYJuWymuKDNZYB[0]);
#endif
 free(NDjzAZSYJuWymuKDNZYB); fclose(UKtMXCCqdjeyaVHabkxg); return; } void 
MWConvLayer::loadBias(const char* SDWKEQTZaTFZByPlzUDR) { FILE* UKtMXCCqdjeyaVHabkxg = 
openBinaryFile(SDWKEQTZaTFZByPlzUDR);  assert(UKtMXCCqdjeyaVHabkxg); int fhikqqlnUKCjleVKDqiG 
= getNumOutputFeatures();  float* NDjzAZSYJuWymuKDNZYB = 
(float*)malloc(sizeof(float)*fhikqqlnUKCjleVKDqiG); fread(NDjzAZSYJuWymuKDNZYB, 
sizeof(float), fhikqqlnUKCjleVKDqiG, UKtMXCCqdjeyaVHabkxg); 
CUDA_CALL(cudaMemcpy(KHClOltUSuqFVVErSxVb, NDjzAZSYJuWymuKDNZYB, 
sizeof(float)*fhikqqlnUKCjleVKDqiG, cudaMemcpyHostToDevice)); 
free(NDjzAZSYJuWymuKDNZYB); fclose(UKtMXCCqdjeyaVHabkxg); return; } 
MWReLULayer::MWReLULayer() { 
CUDNN_CALL(cudnnCreateActivationDescriptor(&jscBrjkVJyVfMMDjFpgl)); 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); } 
MWReLULayer::~MWReLULayer() { } void MWReLULayer::createReLULayer(MWCNNLayer* 
jaqKGCwoANNDMHgAsehk) { setTop(jaqKGCwoANNDMHgAsehk); 
setBatchSize(getTop()->getBatchSize()); setHeight(getTop()->getHeight()); 
setWidth(getTop()->getWidth()); 
setNumInputFeatures(getTop()->getNumOutputFeatures()); 
setNumOutputFeatures(getNumInputFeatures()); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); 
CUDNN_CALL(cudnnSetActivationDescriptor(jscBrjkVJyVfMMDjFpgl, 
CUDNN_ACTIVATION_RELU, CUDNN_NOT_PROPAGATE_NAN, 0)); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, getBatchSize(), getNumOutputFeatures(), 
getHeight(), getWidth())); setData(getTop()->getData()); return; } void 
MWReLULayer::predict() { CUDNN_CALL(cudnnActivationForward(*getCudnnHandle(), 
jscBrjkVJyVfMMDjFpgl, getOnePtr(), *getTop()->getOutputDescriptor(), 
getTop()->getData(), getZeroPtr(), *getOutputDescriptor(),getData())); return; 
} void MWReLULayer::cleanup() { 
CUDNN_CALL(cudnnDestroyActivationDescriptor(jscBrjkVJyVfMMDjFpgl)); 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); return; } 
MWNormLayer::MWNormLayer() { 
CUDNN_CALL(cudnnCreateLRNDescriptor(&fYaOQTeunPwVjnhhTECh)); 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); } 
MWNormLayer::~MWNormLayer() { } void MWNormLayer::createNormLayer(MWCNNLayer* 
jaqKGCwoANNDMHgAsehk, unsigned IwKnaBoXVubIRYcxEJLH, double 
AHqhysOOIgbDpWZoPUFT, double ATEikvMQPqBefhJzjzhc, double CZNYmBcNFSZWvaCklqeM) { 
setTop(jaqKGCwoANNDMHgAsehk); setBatchSize(getTop()->getBatchSize()); 
setHeight(getTop()->getHeight()); setWidth(getTop()->getWidth()); 
setNumInputFeatures(getTop()->getNumOutputFeatures()); 
setNumOutputFeatures(getNumInputFeatures()); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); 
CUDNN_CALL(cudnnSetLRNDescriptor(fYaOQTeunPwVjnhhTECh, 
IwKnaBoXVubIRYcxEJLH, AHqhysOOIgbDpWZoPUFT, ATEikvMQPqBefhJzjzhc, 
CZNYmBcNFSZWvaCklqeM)); CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, getBatchSize(), getNumOutputFeatures(), 
getHeight(), getWidth())); CUDA_CALL(cudaMalloc((void**)getDataPtr(), 
sizeof(float)*getBatchSize()*getNumOutputFeatures()*getHeight()*getWidth())); 
return; } void MWNormLayer::predict() { 
CUDNN_CALL(cudnnLRNCrossChannelForward(*getCudnnHandle(), fYaOQTeunPwVjnhhTECh, 
CUDNN_LRN_CROSS_CHANNEL_DIM1, getOnePtr(), *getTop()->getOutputDescriptor(), 
getTop()->getData(), getZeroPtr(), *getOutputDescriptor(),getData())); return; 
} void MWNormLayer::cleanup() { 
CUDNN_CALL(cudnnDestroyLRNDescriptor(fYaOQTeunPwVjnhhTECh)); 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); if 
(getData()) { call_cuda_free(getData()); } return; } 
MWAvgPoolingLayer::MWAvgPoolingLayer() { 
CUDNN_CALL(cudnnCreatePoolingDescriptor(&jLyhrFjMmVnNjoeDJCwH)); 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); } 
MWAvgPoolingLayer::~MWAvgPoolingLayer() { } void 
MWAvgPoolingLayer::createAvgPoolingLayer(MWCNNLayer* jaqKGCwoANNDMHgAsehk, 
int GsZlHFuhbvjLtRMDjXnW, int HJHXkKmgFxxIOsIvRRnF, int HtQBsWTCGEkpylRklilw, int 
IAlDgIFcchbwRGBSfVfA, int GFienSVKLlDQuZeqAdLC, int GeeOVBfQrpMacIFBLKOo) { int 
eqOmMKQRpqBqRQCnJmxt, NldNILHvuQqQPSAHXxdT, XVcMnvCXvZpKICKIjgZi, ugnnrhsgTeWucrMPCJUc; 
setTop(jaqKGCwoANNDMHgAsehk); setBatchSize(getTop()->getBatchSize()); 
setNumInputFeatures(getTop()->getNumOutputFeatures()); 
setNumOutputFeatures(getNumInputFeatures()); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); 
CUDNN_CALL(cudnnSetPooling2dDescriptor(jLyhrFjMmVnNjoeDJCwH, 
CUDNN_POOLING_AVERAGE_COUNT_INCLUDE_PADDING, CUDNN_NOT_PROPAGATE_NAN, 
GsZlHFuhbvjLtRMDjXnW, HJHXkKmgFxxIOsIvRRnF, GFienSVKLlDQuZeqAdLC, GeeOVBfQrpMacIFBLKOo, 
HtQBsWTCGEkpylRklilw, IAlDgIFcchbwRGBSfVfA)); 
CUDNN_CALL(cudnnGetPooling2dForwardOutputDim(jLyhrFjMmVnNjoeDJCwH, 
*getTop()->getOutputDescriptor(), &eqOmMKQRpqBqRQCnJmxt ,&NldNILHvuQqQPSAHXxdT, &XVcMnvCXvZpKICKIjgZi, 
&ugnnrhsgTeWucrMPCJUc)); CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, eqOmMKQRpqBqRQCnJmxt, NldNILHvuQqQPSAHXxdT, XVcMnvCXvZpKICKIjgZi, 
ugnnrhsgTeWucrMPCJUc)); CUDA_CALL(cudaMalloc((void**)getDataPtr(), 
sizeof(float)*eqOmMKQRpqBqRQCnJmxt*NldNILHvuQqQPSAHXxdT*XVcMnvCXvZpKICKIjgZi*ugnnrhsgTeWucrMPCJUc)); 
setHeight(XVcMnvCXvZpKICKIjgZi); setWidth(ugnnrhsgTeWucrMPCJUc); return; } void 
MWAvgPoolingLayer::predict() { 
CUDNN_CALL(cudnnPoolingForward(*getCudnnHandle(), jLyhrFjMmVnNjoeDJCwH, 
getOnePtr(), *getTop()->getOutputDescriptor(), getTop()->getData(), 
getZeroPtr(), *getOutputDescriptor(),getData())); return; } void 
MWAvgPoolingLayer::cleanup() {  
CUDNN_CALL(cudnnDestroyPoolingDescriptor(jLyhrFjMmVnNjoeDJCwH)); 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); if(getData()) 
{ call_cuda_free(getData()); } return; } MWMaxPoolingLayer::MWMaxPoolingLayer() 
{ CUDNN_CALL(cudnnCreatePoolingDescriptor(&jLyhrFjMmVnNjoeDJCwH)); 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); } 
MWMaxPoolingLayer::~MWMaxPoolingLayer() { } void 
MWMaxPoolingLayer::createMaxPoolingLayer(MWCNNLayer* jaqKGCwoANNDMHgAsehk, 
int GsZlHFuhbvjLtRMDjXnW, int HJHXkKmgFxxIOsIvRRnF, int HtQBsWTCGEkpylRklilw, int 
IAlDgIFcchbwRGBSfVfA, int GFienSVKLlDQuZeqAdLC, int GeeOVBfQrpMacIFBLKOo) { int 
eqOmMKQRpqBqRQCnJmxt, NldNILHvuQqQPSAHXxdT, XVcMnvCXvZpKICKIjgZi, ugnnrhsgTeWucrMPCJUc; 
setTop(jaqKGCwoANNDMHgAsehk); setBatchSize(getTop()->getBatchSize()); 
setNumInputFeatures(getTop()->getNumOutputFeatures()); 
setNumOutputFeatures(getNumInputFeatures()); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); 
CUDNN_CALL(cudnnSetPooling2dDescriptor(jLyhrFjMmVnNjoeDJCwH, CUDNN_POOLING_MAX, 
CUDNN_NOT_PROPAGATE_NAN, GsZlHFuhbvjLtRMDjXnW, HJHXkKmgFxxIOsIvRRnF, 
GFienSVKLlDQuZeqAdLC, GeeOVBfQrpMacIFBLKOo, HtQBsWTCGEkpylRklilw, 
IAlDgIFcchbwRGBSfVfA)); 
CUDNN_CALL(cudnnGetPooling2dForwardOutputDim(jLyhrFjMmVnNjoeDJCwH, 
*getTop()->getOutputDescriptor(), &eqOmMKQRpqBqRQCnJmxt ,&NldNILHvuQqQPSAHXxdT, &XVcMnvCXvZpKICKIjgZi, 
&ugnnrhsgTeWucrMPCJUc)); CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, eqOmMKQRpqBqRQCnJmxt, NldNILHvuQqQPSAHXxdT, XVcMnvCXvZpKICKIjgZi, 
ugnnrhsgTeWucrMPCJUc)); CUDA_CALL(cudaMalloc((void**)getDataPtr(), 
sizeof(float)*eqOmMKQRpqBqRQCnJmxt*NldNILHvuQqQPSAHXxdT*XVcMnvCXvZpKICKIjgZi*ugnnrhsgTeWucrMPCJUc)); 
setHeight(XVcMnvCXvZpKICKIjgZi); setWidth(ugnnrhsgTeWucrMPCJUc); return; } void 
MWMaxPoolingLayer::predict() { 
CUDNN_CALL(cudnnPoolingForward(*getCudnnHandle(), jLyhrFjMmVnNjoeDJCwH, 
getOnePtr(), *getTop()->getOutputDescriptor(), getTop()->getData(), 
getZeroPtr(), *getOutputDescriptor(),getData())); return; } void 
MWMaxPoolingLayer::cleanup() { 
CUDNN_CALL(cudnnDestroyPoolingDescriptor(jLyhrFjMmVnNjoeDJCwH)); 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); if 
(getData()) {  call_cuda_free(getData()); } return; } MWFCLayer::MWFCLayer() : 
ugnnrhsgTeWucrMPCJUc(NULL) , KHClOltUSuqFVVErSxVb(NULL) { 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); 
CUDNN_CALL(cudnnCreateTensorDescriptor(&MCrRCXUsCsGPMgQbvMOt)); } 
MWFCLayer::~MWFCLayer() { } void MWFCLayer::createFCLayer(MWCNNLayer* 
jaqKGCwoANNDMHgAsehk, int CGbFsczkgkhjcHoCKzBx, int FrpxvsDMwwgbpqHXWxmN) 
{ setTop(jaqKGCwoANNDMHgAsehk); setBatchSize(getTop()->getBatchSize()); 
setHeight(1); setWidth(1); AzTsxYcYjIEJsGQbeYHm = getTop()->getHeight(); 
BLjrjqvCcCommiXWQLjs = getTop()->getWidth(); 
setNumInputFeatures(CGbFsczkgkhjcHoCKzBx); 
setNumOutputFeatures(FrpxvsDMwwgbpqHXWxmN); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); 
CUDA_CALL(cudaMalloc((void**)&ugnnrhsgTeWucrMPCJUc, 
sizeof(float)*getNumInputFeatures()*getNumOutputFeatures())); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, getTop()->getBatchSize(), 
getNumOutputFeatures(), 1, 1)); CUDA_CALL(cudaMalloc((void**)getDataPtr(), 
sizeof(float)*getBatchSize()*getNumOutputFeatures())); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(MCrRCXUsCsGPMgQbvMOt, CUDNN_TENSOR_NCHW, 
CUDNN_DATA_FLOAT, 1, getNumOutputFeatures(), 1, 1)); 
CUDA_CALL(cudaMalloc((void**)&KHClOltUSuqFVVErSxVb, sizeof(float)*getNumOutputFeatures()));
#ifdef RANDOM
 curandGenerateNormal(VCbcPxtPsBLTrHYdEvqn, ugnnrhsgTeWucrMPCJUc, 
getNumInputFeatures()*getNumOutputFeatures(), 0, 0.1); 
curandGenerateNormal(VCbcPxtPsBLTrHYdEvqn, KHClOltUSuqFVVErSxVb, 
getNumOutputFeatures(), -0.5, 1);
#endif
 return; } void MWFCLayer::loadWeights(const char* SDWKEQTZaTFZByPlzUDR) {  
FILE* UKtMXCCqdjeyaVHabkxg = openBinaryFile(SDWKEQTZaTFZByPlzUDR); 
assert(UKtMXCCqdjeyaVHabkxg); int fhikqqlnUKCjleVKDqiG = 
getNumInputFeatures()*getNumOutputFeatures();  float* NDjzAZSYJuWymuKDNZYB = 
(float*)malloc(sizeof(float)*fhikqqlnUKCjleVKDqiG); fread(NDjzAZSYJuWymuKDNZYB, 
sizeof(float), fhikqqlnUKCjleVKDqiG, UKtMXCCqdjeyaVHabkxg); if( AzTsxYcYjIEJsGQbeYHm != 1 
&& BLjrjqvCcCommiXWQLjs != 1 ) { float* NMMfJylfQjiIUAKhXCJb = 
(float*)malloc(sizeof(float)*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs); 
for(int k=0; k<fhikqqlnUKCjleVKDqiG/AzTsxYcYjIEJsGQbeYHm/BLjrjqvCcCommiXWQLjs; 
k++) { for(int i=0; i<AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs; i++) 
NMMfJylfQjiIUAKhXCJb[i]=NDjzAZSYJuWymuKDNZYB[k*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs+i]; 
for(int j=0; j<AzTsxYcYjIEJsGQbeYHm; j++) for(int i=0; 
i<BLjrjqvCcCommiXWQLjs; i++) 
NDjzAZSYJuWymuKDNZYB[k*AzTsxYcYjIEJsGQbeYHm*BLjrjqvCcCommiXWQLjs+j*BLjrjqvCcCommiXWQLjs+i]=NMMfJylfQjiIUAKhXCJb[j+i*AzTsxYcYjIEJsGQbeYHm]; 
} free(NMMfJylfQjiIUAKhXCJb); } CUDA_CALL(cudaMemcpy(ugnnrhsgTeWucrMPCJUc, 
NDjzAZSYJuWymuKDNZYB, sizeof(float)*fhikqqlnUKCjleVKDqiG, cudaMemcpyHostToDevice));
#if 0
 printf("%s loaded. Size = %d. %f\n", SDWKEQTZaTFZByPlzUDR, fhikqqlnUKCjleVKDqiG, NDjzAZSYJuWymuKDNZYB[0]);
#endif
 free(NDjzAZSYJuWymuKDNZYB); fclose(UKtMXCCqdjeyaVHabkxg); return; } void 
MWFCLayer::loadBias(const char* SDWKEQTZaTFZByPlzUDR) { FILE* UKtMXCCqdjeyaVHabkxg = 
openBinaryFile(SDWKEQTZaTFZByPlzUDR); assert(UKtMXCCqdjeyaVHabkxg); int fhikqqlnUKCjleVKDqiG 
= getNumOutputFeatures();  float* NDjzAZSYJuWymuKDNZYB = 
(float*)malloc(sizeof(float)*fhikqqlnUKCjleVKDqiG); fread(NDjzAZSYJuWymuKDNZYB, 
sizeof(float), fhikqqlnUKCjleVKDqiG, UKtMXCCqdjeyaVHabkxg); 
CUDA_CALL(cudaMemcpy(KHClOltUSuqFVVErSxVb, NDjzAZSYJuWymuKDNZYB, 
sizeof(float)*fhikqqlnUKCjleVKDqiG, cudaMemcpyHostToDevice)); 
free(NDjzAZSYJuWymuKDNZYB); fclose(UKtMXCCqdjeyaVHabkxg); return; } void 
MWFCLayer::predict() { int aLsOwwcceEmRSYzllBNs=1; int bDTIjtxZiSHtjwzgEluE=1; if( 
getBatchSize()==1 ) { CUDA_CALL(cudaMemcpy(getData(), KHClOltUSuqFVVErSxVb, 
sizeof(float)*getNumOutputFeatures(), cudaMemcpyDeviceToDevice)); 
CUBLAS_CALL(cublasSgemv(*getCublasHandle(), CUBLAS_OP_T, getNumInputFeatures(), 
getNumOutputFeatures(), getOnePtr(), ugnnrhsgTeWucrMPCJUc, getNumInputFeatures(), 
getTop()->getData(), aLsOwwcceEmRSYzllBNs, getOnePtr(),getData(), bDTIjtxZiSHtjwzgEluE)); 
} else { CUBLAS_CALL(cublasSgemm(*getCublasHandle(), CUBLAS_OP_T, CUBLAS_OP_N, 
getNumOutputFeatures(), getBatchSize(), getNumInputFeatures(), getOnePtr(), 
ugnnrhsgTeWucrMPCJUc, getNumInputFeatures(), getTop()->getData(), 
getNumInputFeatures(), getZeroPtr(),getData(), getNumOutputFeatures())); 
CUDNN_CALL(cudnnAddTensor(*getCudnnHandle(), getOnePtr(), MCrRCXUsCsGPMgQbvMOt, 
KHClOltUSuqFVVErSxVb, getOnePtr(), *getOutputDescriptor(),getData())); } return; } void 
MWFCLayer::cleanup() { if (ugnnrhsgTeWucrMPCJUc) { call_cuda_free(ugnnrhsgTeWucrMPCJUc); }  
CUDNN_CALL(cudnnDestroyTensorDescriptor(MCrRCXUsCsGPMgQbvMOt)); if 
(KHClOltUSuqFVVErSxVb) { call_cuda_free(KHClOltUSuqFVVErSxVb); } 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); if 
(getData()) { call_cuda_free(getData()); } return; } 
MWSoftmaxLayer::MWSoftmaxLayer() { 
CUDNN_CALL(cudnnCreateTensorDescriptor(getOutputDescriptor())); } 
MWSoftmaxLayer::~MWSoftmaxLayer() { } void 
MWSoftmaxLayer::createSoftmaxLayer(MWCNNLayer* jaqKGCwoANNDMHgAsehk) { 
setTop(jaqKGCwoANNDMHgAsehk); setBatchSize(getTop()->getBatchSize()); 
setHeight(getTop()->getHeight()); setWidth(getTop()->getWidth()); 
setNumInputFeatures(getTop()->getNumOutputFeatures()); 
setNumOutputFeatures(getNumInputFeatures()); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); 
CUDNN_CALL(cudnnSetTensor4dDescriptor(*getOutputDescriptor(), 
CUDNN_TENSOR_NCHW, CUDNN_DATA_FLOAT, getBatchSize(), getNumOutputFeatures(), 
getHeight(), getWidth())); CUDA_CALL(cudaMalloc((void**)getDataPtr(), 
sizeof(float)*getBatchSize()*getNumInputFeatures()*getHeight()*getWidth())); 
return; } void MWSoftmaxLayer::predict() { 
CUDNN_CALL(cudnnSoftmaxForward(*getCudnnHandle(), CUDNN_SOFTMAX_ACCURATE, 
CUDNN_SOFTMAX_MODE_CHANNEL, getOnePtr(), *getTop()->getOutputDescriptor(), 
getTop()->getData(), getZeroPtr(), *getOutputDescriptor(),getData())); return; 
} void MWSoftmaxLayer::cleanup() { 
CUDNN_CALL(cudnnDestroyTensorDescriptor(*getOutputDescriptor())); if 
(getData()) {  call_cuda_free(getData()); } return; } 
MWOutputLayer::MWOutputLayer() { } MWOutputLayer::~MWOutputLayer() { } void 
MWOutputLayer::createOutputLayer(MWCNNLayer* jaqKGCwoANNDMHgAsehk) { 
setTop(jaqKGCwoANNDMHgAsehk); setBatchSize(getTop()->getBatchSize()); 
setHeight(getTop()->getHeight()); setWidth(getTop()->getWidth()); 
setNumInputFeatures(getTop()->getNumOutputFeatures()); 
setNumOutputFeatures(getNumInputFeatures()); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); setData(getTop()->getData()); 
return; } void MWOutputLayer::predict() { return; } void 
MWOutputLayer::cleanup() { return; } MWPassthroughLayer::MWPassthroughLayer() { 
} MWPassthroughLayer::~MWPassthroughLayer() { } void 
MWPassthroughLayer::createPassthroughLayer(MWCNNLayer* 
jaqKGCwoANNDMHgAsehk) { setTop(jaqKGCwoANNDMHgAsehk); 
setBatchSize(getTop()->getBatchSize()); setHeight(getTop()->getHeight()); 
setWidth(getTop()->getWidth()); 
setNumInputFeatures(getTop()->getNumOutputFeatures()); 
setNumOutputFeatures(getNumInputFeatures()); 
setWorkSpaceSize(*getTop()->getWorkSpaceSize()); setData(getTop()->getData()); 
return; } void MWPassthroughLayer::predict() { return; } void 
MWPassthroughLayer::cleanup() { return; }