/* Copyright 2016-2017 The MathWorks, Inc. */
#ifndef CNN_API_HPP
#define CNN_API_HPP

#include <string>
#include <cudnn.h>
#include <cublas_v2.h>
#include <stdexcept>

#define CUDA_CALL(status) cuda_call_line_file(status,__LINE__,__FILE__)
#define CUDNN_CALL(status) cudnn_call_line_file(status,__LINE__,__FILE__)
#define CUBLAS_CALL(status) cublas_call_line_file(status,__LINE__,__FILE__)

//#define RANDOM
#ifdef RANDOM
#include <curand.h>
#define CURAND_CALL(status) curand_call_line_file(status,__LINE__,__FILE__)
#endif

void cuda_call_line_file(cudaError_t, const int, const char *);
void cudnn_call_line_file(cudnnStatus_t, const int, const char *);
const char* cublasGetErrorString(cublasStatus_t);
void cublas_call_line_file(cublasStatus_t, const int, const char *);
void call_cuda_free(float* mem);
#ifdef RANDOM
void curand_call_line_file(curandStatus_t, const int, const char *);
#endif

class MWCNNLayer
{
  protected:  
    std::string fOpFYwKNwIfWjnPzNuob;           //Name of the layer
    
  private:
    MWCNNLayer* sRECVoNNtDdcBOWgDyar;            //The previous layer   
    int AIXLuRgdeiqpaCehGSYD;
    int BRSPqxNffoBYKqpSVHne;
    int IbSWJNMuIiKbocfQKqXb;
    int DqxLTLaJwwgQqmrtCDuu;
    int ECTnqgWHyHCHCLBZlffd;
    
    float* xHViLEwTujGGrPZZgmbF;
    cudnnTensorDescriptor_t iPqBiFnIJMxelVhQBZex;
    size_t juRPduBvIGpwaZiftkzr;
    
    float* vxtNGOWYjhKeBBSzuIMB;
    
    float* xkUNToJIgvoLoUQuzKRF;
    cudnnTensorDescriptor_t XCLDbxHBtWRStETWIkId;
    
    cublasHandle_t* OumvfgWXDdmsQaciHMHx;
    cudnnHandle_t* OwenhowBxTAXHXmJpIKd;

    float QVgVGfoCXYiYXzPhvVPX;
    float QMgBqCuvjnbWHWiVPEwn;
    float PtkeOkuClHzhOfpmBevf;
    float bMAyVFGSPDjmUbziYLAy;
    
  public:
    MWCNNLayer();
    virtual ~MWCNNLayer();

    virtual void createInputLayer(int, int, int, int, bool);
    virtual void createReLULayer(MWCNNLayer*);
    virtual void createLeakyReLULayer(MWCNNLayer*, double);
    virtual void createBatchNormalizationLayer(MWCNNLayer*, double);
    virtual void createSoftmaxLayer(MWCNNLayer*);
    virtual void createOutputLayer(MWCNNLayer*);
    virtual void createFCLayer(MWCNNLayer*, int, int);
    virtual void createNormLayer(MWCNNLayer*, unsigned, double, double, double);
    virtual void createAvgPoolingLayer(MWCNNLayer*, int, int, int, int, int, int);
    virtual void createMaxPoolingLayer(MWCNNLayer*, int, int, int, int, int, int);
    virtual void createConvLayer(MWCNNLayer*, int, int, int, int, int, int, int, int, int);
    virtual void createPassthroughLayer(MWCNNLayer*);
    virtual void predict() = 0;
    virtual void cleanup() = 0;
    virtual void loadAvg(const char*);
    virtual void loadWeights(const char*);
    virtual void loadBias(const char*);

    // methods specific to batch normalization layer 
    virtual void loadScale(const char*) {}
    virtual void loadOffset(const char*) {}
    virtual void loadTrainedMean(const char*) {}
    virtual void loadTrainedVariance(const char*) {}
    
    void setName(const char*);      // Set the name for this layer
    void createWorkSpace(float**);  // Create the workspace needed for this layer
    void setBatchSize(int);         // Set the batch size
    int getBatchSize();             // Get the batch size
    void setHeight(int);            // Set the height of output y
    int getHeight();                // Get the height of output y
    void setWidth(int);             // Set the width of output y
    int getWidth();                 // Get the width of output y
    void setNumInputFeatures(int);  // Set the number of channels of the input
    int getNumInputFeatures();      // Get the number of channels of the input
    void setNumOutputFeatures(int); // Set the number of channels of the output
    int getNumOutputFeatures();     // Get the number of channels of the output
    void setData(float*);           // Set the output tensor. This should be batchSize * numOutputFeatures * height * width
    float** getDataPtr();           // Get the pointer to the output tensor.
    float*  getData();              // Get the output tensor.
    void setOutputDescriptor(cudnnTensorDescriptor_t); // Set the cuDNN tensor descriptor for the output
    cudnnTensorDescriptor_t* getOutputDescriptor();     // Get the cuDNN tensor descriptor for the output
    void setWorkSpaceSize(size_t);  // Set the workspace size of this layer and previous layers
    size_t* getWorkSpaceSize();      // Get the workspace size of this layer and previous layers
    void setWorkSpace(float*);      // Set the workspace buffer in GPU memory
    float* getWorkSpace();          // Get the workspace buffer in GPU memory
    void setOutput2(float*);        // Set the pointer to the second half of the output for grouped convolution
    float* getOutput2();            // Get the pointer to the second half of the output for grouped convolution
    void setGroupDescriptor(cudnnTensorDescriptor_t);  // Set the cuDNN descriptor of the output for grouped convolution
    cudnnTensorDescriptor_t* getGroupDescriptor();     // Get the cuDNN descriptor of the output for grouped convolution
    void setCublasHandle(cublasHandle_t*);  // Set the cuBLAS handle to use for GPU computation
    cublasHandle_t* getCublasHandle();      // Get the cuBLAS handle to use for GPU computation
    void setCudnnHandle(cudnnHandle_t*);    // Set the cuDNN handle to use for GPU computation
    cudnnHandle_t* getCudnnHandle();        // Get the cuDNN handle to use for GPU computation
    float* getZeroPtr();            // Get the pointer to a zero value parameter
    float* getOnePtr();             // Get the pointer to a one value parameter
    float* getNegOnePtr();          // Get the pointer to a negative one value parameter
    float  getIsGrouped();          // Get the isGrouped parameter
    void   setIsGrouped(float);     // Set the isGrouped parameter
    MWCNNLayer* getTop();           // Get the top layer  
    void setTop(MWCNNLayer* previous); // Set the top layer

  protected:
    FILE* openBinaryFile(const char* filename);    
    std::runtime_error getFileOpenError(const char* filename);
};

//ImageInputLayer
class MWInputLayer: public MWCNNLayer
{
    private:
        bool bUVPfnrJhLfHzOLUUrKk;
        float* JgLfgHrHMEMmMYTettJF;

    public:
        MWInputLayer();
        ~MWInputLayer();

        void createInputLayer(int, int, int, int, bool);
        void predict();
        void cleanup();
        void loadAvg(const char*);

    private:
        cudnnTensorDescriptor_t       KCudOrFMfgCzUPMcdePX;
};

//Convolution2DWCNNLayer
class MWConvLayer: public MWCNNLayer
{
    public:
        int AzTsxYcYjIEJsGQbeYHm;           //Filter height for CONV and FC
        int BLjrjqvCcCommiXWQLjs;            //Filter width for CONV and FC
    
    private:
        int DSsxcjIrUgZCKZovyNQf;
        float* ugnnrhsgTeWucrMPCJUc;
        float* KHClOltUSuqFVVErSxVb;
        float* vFNECEAeLZsYsUxvlgqL;

   public:
        MWConvLayer();
        ~MWConvLayer();

        void createConvLayer(MWCNNLayer*, int, int, int, int, int, int, int, int, int);
        void predict();
        void cleanup();
        void loadWeights(const char*);
        void loadBias(const char*);
		
    private:
        cudnnConvolutionDescriptor_t  OKaRVOctKLlnIyGmjRNW;
        cudnnConvolutionFwdAlgo_t     NnAKUXChhnRnQmWsknGy;

        cudnnFilterDescriptor_t       UEESbUvbMihFnquvuFij;
        cudnnTensorDescriptor_t       MCrRCXUsCsGPMgQbvMOt;
};

//ReLULayer
class MWReLULayer: public MWCNNLayer
{
    public:
        MWReLULayer();
        ~MWReLULayer();

        void createReLULayer(MWCNNLayer*);
        void predict();
        void cleanup();

    private:
        cudnnActivationDescriptor_t   jscBrjkVJyVfMMDjFpgl;
};

//CrossChannelNormalizationLayer
class MWNormLayer: public MWCNNLayer
{
    public:
        MWNormLayer();
        ~MWNormLayer();

        void createNormLayer(MWCNNLayer*, unsigned, double, double, double);
        void predict();
        void cleanup();

    private:
        cudnnLRNDescriptor_t          fYaOQTeunPwVjnhhTECh;
};

//AvgPooling2DLayer
class MWAvgPoolingLayer: public MWCNNLayer
{
    public:
        MWAvgPoolingLayer();
        ~MWAvgPoolingLayer();

        void createAvgPoolingLayer(MWCNNLayer*, int, int, int, int, int, int);
        void predict();
        void cleanup();

    private:
        cudnnPoolingDescriptor_t      jLyhrFjMmVnNjoeDJCwH;
};

//MaxPooling2DLayer
class MWMaxPoolingLayer: public MWCNNLayer
{
    public:
        MWMaxPoolingLayer();
        ~MWMaxPoolingLayer();

        void createMaxPoolingLayer(MWCNNLayer*, int, int, int, int, int, int);
        void predict();
        void cleanup();

    private:
        cudnnPoolingDescriptor_t      jLyhrFjMmVnNjoeDJCwH;   
};

//FullyConnectedLayer
class MWFCLayer: public MWCNNLayer
{
    private:
        int AzTsxYcYjIEJsGQbeYHm;
        int BLjrjqvCcCommiXWQLjs;
        float* ugnnrhsgTeWucrMPCJUc;
        float* KHClOltUSuqFVVErSxVb;

    public:
        MWFCLayer();
        ~MWFCLayer();
		
        void loadWeights(const char*);
        void loadBias(const char*);

        void createFCLayer(MWCNNLayer*, int, int);
        void predict();
        void cleanup();

    private:
        cudnnTensorDescriptor_t       MCrRCXUsCsGPMgQbvMOt;
};

//SoftmaxLayer
class MWSoftmaxLayer: public MWCNNLayer
{
    public:
        MWSoftmaxLayer();
        ~MWSoftmaxLayer();

        void createSoftmaxLayer(MWCNNLayer*);
        void predict();
        void cleanup();

    private:
        cudnnLRNDescriptor_t          fYaOQTeunPwVjnhhTECh;
};

//ClassificationOutputLayer
class MWOutputLayer: public MWCNNLayer
{
    public:
        MWOutputLayer();
        ~MWOutputLayer();

        void createOutputLayer(MWCNNLayer*);
        void predict();
        void cleanup();

    private:
        cudnnLRNDescriptor_t          fYaOQTeunPwVjnhhTECh;
};

// pass through 
class MWPassthroughLayer: public MWCNNLayer
{
  public:
    MWPassthroughLayer();
    ~MWPassthroughLayer();

    void createPassthroughLayer(MWCNNLayer*);
    void predict();
    void cleanup(); 
};

#endif
