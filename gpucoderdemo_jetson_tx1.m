%% Running an Embedded Application on the NVIDIA(R) Jetson TX1 Developer Kit
% This example shows how to generate CUDA(R) code from a SeriesNetwork object
% and target it to NVIDIA's TX1 board with an external camera. This example
% uses the AlexNet deep learning network to classify images from a USB
% webcam video stream. 
%
%   Copyright 2017 The MathWorks, Inc.
%% Prerequisites
% * Neural Network Toolbox(TM) to load the SeriesNetwork object.
% * NVIDIA(R) Jetson TX1 developer kit.
% * USB camera to connect to the TX1.
% * NVIDIA(R) CUDA toolkit installed on the TX1.
% * NVIDIA(R) cuDNN 5.0 library installed on the TX1.
% * OpenCV 2.4.9 libraries for video read and image display operations
% installed on the TX1.
% * OpenCV header and library files should be in the NVCC compiler search
% path of the TX1.
% * Environment variables for the compilers and libraries. For more 
% information see 
% <matlab:web(fullfile(docroot,'gpucoder/gs/setting-up-the-toolchain.html')) Environment Variables>.
% * This demo is supported on Linux(R) platform only.
%% Create a New Folder and Copy Relevant Files
% The following line of code creates a folder in your current working 
% folder (pwd), and copies all the relevant files into this folder. If you 
% do not want to perform this operation or if you cannot generate files in 
% this folder, change your current working folder.
gpucoderdemo_setup('gpucoderdemo_jetson_tx1');
%% Get the Pre-trained SeriesNetwork
% It contains 25 layers including convolution, fully connected and the
% classification output layers.
net = getAlexnet();
disp(net.Layers);

%% Generate Code from the SeriesNetwork
% Generate code for the TX1 platform.

cnncodegen(net, 'targetarch', 'tx1', 'codegenonly', 1);
%% Generated Code Description
% This generates the .cu and header files within the
% codegen directory of the current folder. The generated code folder includes 
% a make file to build a static library cnnbuild.a. 
%
% The SeriesNetwork is generated as a C++ class containing an array of 25
% layer classes.
%
%  class CnnMain
%  {
%    public:
%      int32_T batchSize;
%      int32_T numLayers;
%      real32_T *inputData;
%      real32_T *outputData;
%      MWCNNLayer *layers[25];
%    private:
%      cublasHandle_t cublasHandle;
%      cudnnHandle_t cudnnHandle;
%      uint32_T workSpaceSize;
%      real32_T *workSpace;
%    public:
%      CnnMain();
%      void setup();
%      void predict();
%      void cleanup();
%      ~CnnMain();
%  };
%
% The setup() method of the class sets up handles and allocates memory for
% each layer object. The predict() method invokes prediction for each of
% the 25 layers in the network.
% 
% The cnn_CnnMain_convX_w and cnn_CnnMain_convX_b files are the binary
% weights and bias files for
% convolution layer in the network. The cnn_CnnMain_fcX_w and
% cnn_CnnMain_fcX_b files are the binary weights and bias files for fully
% connected layer in the network. The text file cnn_CnnMain_labels.txt is
% generated from the labels of the classification layer.

dir('codegen')
%% Main File 
% The custom main file creates and sets up the CnnMain network object with 
% layers and weights. It uses the OpenCV VideoCapture method to 
% read frames from a camera connected to the TX1. 
% Each frame is processed and classified, 
% until no more frames are to be read.
%
%  int main(int argc, char* argv[])
%  {
%      int n = 1;	
%      if (argc > 1) {
%          n = atoi(argv[1]);
%      }
%
%      float *inputBuffer = (float*)calloc(sizeof(float),227*227*3);
%      float *outputBuffer = (float*)calloc(sizeof(float),1000);
%      if ((inputBuffer == NULL) || (outputBuffer == NULL)) {
%          printf("ERROR: Input/Output buffers could not be allocated!\n");
%          exit(-1);
%      }	   
%      CnnMain* net = new CnnMain;
%      net->batchSize = 1;
%      net->setup();
%      char synsetWords[1000][100];
%      if (prepareSynset(synsetWords) == -1) {
%          printf("ERROR: Unable to find synsetWords.txt\n");
%          return -1;
%      }       
%      VideoCapture cap(n); //use device number for camera. 
%      if (!cap.isOpened()) {
%          printf("Could not open the video capture device.\n");
%          return -1;
%      }
%      namedWindow("Alexnet Demo",CV_WINDOW_NORMAL);
%      resizeWindow("Alexnet Demo", 1000,1000);
% 		
%      float fps=0;	
%      cudaEvent_t start, stop;
%      cudaEventCreate(&start);
%      cudaEventCreate(&stop);		
% 	    	
%      for (;;)
%      {    
%          Mat orig;
%          cap >> orig; 
%          if (orig.empty()) break;
%          Mat im;
%          readData(inputBuffer, orig, im);
%         
%          cudaEventRecord(start);
%          cudaMemcpy( net->inputData, inputBuffer, sizeof(float)*227*227*3, cudaMemcpyHostToDevice );
%          net->predict();
%          cudaMemcpy( outputBuffer, net->outputData, sizeof(float)*1000, cudaMemcpyDeviceToHost );
%          cudaEventRecord(stop);
%          cudaEventSynchronize(stop);
% 
%          float milliseconds = -1.0;
%          cudaEventElapsedTime(&milliseconds, start, stop);
%          fps = fps*.9+1000.0/milliseconds*.1;
% 		
%          writeData(outputBuffer, synsetWords, orig, fps);
%          if(waitKey(1)%256 == 27 ) break; // stop when ESC key is pressed
%      }
%      destroyWindow("Alexnet Demo");
%
%      delete net;
%   
%      free(inputBuffer);
%      free(outputBuffer);
%         
%      return 0;
%  }
%% Copy Files to the Codegen Directory
% Copy the files required for the executable.

copyfile('create_exe.mk', fullfile('codegen', 'create_exe.mk'));
copyfile('synsetWords.txt', fullfile('codegen', 'synsetWords.txt'));
copyfile('main_webcam.cpp', fullfile('codegen', 'main_webcam.cpp'));
copyfile('maxperf.sh', fullfile('codegen', 'maxperf.sh'));

%% Build and Run
% Copy the codegen folder to a directory in the TX1.
%
%  scp -r ./codegen username@jetson-tx1-name:/path/to/desired/location
%
% On the TX1, navigate to the copied codegen directory and execute the
% following commands.
%
%  sudo ./maxperf.sh
%%
% Run make to build static library cnnbuild.a.
%%
%  make -f cnnbuild_rtw.mk
%% 
% Run make to generate an executable using the main file , the static library cnnbuild.a and OpenCV libraries.
%%
%  make -f create_exe.mk
% 
% The maxperf.sh script is used to boost TX1 performance. Run the
% executable on the TX1 platform with a device number for your webcam.
%
%  ./alexnet_exe 1
%
% This displays a live video feed from the webcam accompanied by the
% AlexNet predictions of the current image. Press escape at any time to
% quit.
%% AlexNet Classification Output on TX1
% <<gpucoderdemo_jetson_tx1_alexnet_screenshot.png>>
%% Cleanup
% Remove files and return to original folder.

cleanup


displayEndOfDemoMessage(mfilename)
