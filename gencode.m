%% Generate CUDA code and MEX function
% Setup the input for code generation and create a configuration for GPU code
% generation.
inputImage = imread('foggyInput.png');

net = getAlexnet();
cnncodegen(net, 'targetarch', 'NVIDIA CUDA  (w/Microsoft Visual C++ 2015) | gmake (64-bit Windows)', 'codegenonly', 1);

%% Copy Files to the Codegen Directory
% Copy the files required for the executable.

copyfile('create_exe.mk', fullfile('codegen', 'create_exe.mk'));
copyfile('synsetWords.txt', fullfile('codegen', 'synsetWords.txt'));
copyfile('main_webcam.cpp', fullfile('codegen', 'main_webcam.cpp'));
copyfile('maxperf.sh', fullfile('codegen', 'maxperf.sh'));

%% Run Code Generation

rr= RoboNouMiChiClass(1,2);
genCodeOnlyValue = true;
rr.genCode('lib','fog_rectification','embed','normal',genCodeOnlyValue, "{inputImage}");

codegendir = fullfile(pwd, str2mat(rr.codepath));

copyfile('*.c*',codegendir);
copyfile('*.mk',codegendir);
copyfile('*.txt',codegendir);
copyfile('*.sh',codegendir);
