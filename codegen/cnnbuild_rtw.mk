###########################################################################
## Makefile generated for MATLAB file/project |>PROJNAME<|. 
## 
## Makefile     : C:\Sumpurn\gpucoderdemo_jetson_tx1\codegen\cnnbuild_rtw.mk
## 
## Final product: C:/Sumpurn/gpucoderdemo_jetson_tx1/codegen/cnnbuild.lib
## Product type : Static Library
## 
###########################################################################
#
# Copyright 2016 The MathWorks, Inc.

###########################################################################
## MACROS
##########################################################################

PRODUCT_NAME              = C:/Sumpurn/gpucoderdemo_jetson_tx1/codegen/cnnbuild.lib
MAKEFILE                  = C:\Sumpurn\gpucoderdemo_jetson_tx1\codegen\cnnbuild_rtw.mk
START_DIR                 = C:/Sumpurn/gpucoderdemo_jetson_tx1/codegen
ARCH                      = win64
MATLAB                    = C:\Program Files\MATLAB\R2017b
MATLAB_ARCH_BIN           = $(MATLABROOT)/bin/$(ARCH)

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          NVIDIA CUDA  (w/Microsoft Visual C++ 2013)  | nmake (64-bit Windows)
# Supported Version(s):    12.0

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# C Compiler: NVIDIA CUDA C Compiler Driver
CC = nvcc

# Linker: NVIDIA CUDA C Compiler Driver
LD = nvcc -lib

# C++ Compiler: NVIDIA CUDA C++ Compiler Driver
CPP = nvcc

# C++ Linker: NVIDIA CUDA C++ Compiler Driver
CPP_LD = nvcc -lib

# Archiver: GNU Archiver
AR = lib

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: GMAKE Utility
MAKE_PATH = $(MATLAB)/bin/$(ARCH)
MAKE = $(MAKE_PATH)/gmake

#-------------------------
# Directives/Utilities
#-------------------------

CDEBUG              = -g -G 
CPPDEBUG            = -g -G 
LDDEBUG             = -g -G 
CPPLDDEBUG          = -g -G 
RM                  = @rm -f
ECHO                = @echo
MV                  = @mv


#----------------------------------------
# "Faster Builds" Build Configuration
#----------------------------------------

ARFLAGS =   $(ARDEBUG)
CFLAGS =  -c $(C_STANDARD_OPTS) -Xcompiler "/wd 4819" -rdc=true -Xcudafe "--diag_suppress=unsigned_compare_with_zero" -O0 $(CDEBUG)
CPPFLAGS =  -c $(CPP_STANDARD_OPTS) -Xcompiler "/wd 4819" -rdc=true -Xcudafe "--diag_suppress=unsigned_compare_with_zero" -O0 $(CPPDEBUG)
CPP_LDFLAGS =  -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" $(conlibs) cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets $(CPPLDDEBUG)
CPP_SHAREDLIB_LDFLAGS =  -shared -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets -Xlinker -dll -Xlinker -def:$(DEF_FILE) $(CPPLDDEBUG)
DOWNLOAD_FLAGS = 
EXECUTE_FLAGS = 
LDFLAGS =  -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" $(conlibs) cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets $(LDDEBUG)
MEX_CPPFLAGS = 
MEX_CPPLDFLAGS = 
MEX_CFLAGS =  -MATLAB_ARCH=$(ARCH) $(INCLUDES)   COPTIMFLAGS="$(C_STANDARD_OPTS)  -O0  $(DEFINES)"   -silent
MEX_LDFLAGS =  LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS' LDFLAGS=='$$LDFLAGS'
MAKE_FLAGS =  -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE) -f $(MAKEFILE)
SHAREDLIB_LDFLAGS =  -shared -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets -Xlinker -dll -Xlinker -def:$(DEF_FILE) $(LDDEBUG)


#--------------------
# File extensions
#--------------------
#
# |>FILEEXTFLAGS<|
#

###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = $(PRODUCT_NAME)

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = -I"$(START_DIR)"

INCLUDES = $(INCLUDES_BUILDINFO) -I"$(NVIDIA_CUDNN)\include"

###########################################################################
## SOURCE FILES
###########################################################################

SRCS =  $(START_DIR)/cnn_api.cu $(START_DIR)/cnn_exec.cpp

ALL_SRCS = $(SRCS)

###########################################################################
## OBJECTS
###########################################################################

OBJS =  $(START_DIR)/cnn_api.obj $(START_DIR)/cnn_exec.obj

ALL_OBJS = $(OBJS)

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS =  -L"$(START_DIR)"

TOOLCHAIN_LIBS = -L"$(CUDA_PATH)\lib\x64" "$(NVIDIA_CUDNN)\lib\x64\cudnn.lib" -lcublas -lcudart -lcusolver 

###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build buildobj clean info


all : build
	@echo "### Successfully generated all binary outputs."


build : buildobj $(PRODUCT)


buildobj : $(OBJS)


###########################################################################
## FINAL TARGET
###########################################################################

$(PRODUCT) : $(OBJS)
	$(LD) $(LDFLAGS) -o $(PRODUCT) $(OBJS) $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	@echo "### Created: $(PRODUCT)"

###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.obj : %.cu
	$(CC) $(CFLAGS) -arch sm_35  $(INCLUDES) -o "$@" "$<"

%.obj : %.c
	$(CC) $(CFLAGS) -arch sm_35  $(INCLUDES) -o "$@" "$<"

%.obj : %.cpp
	$(CPP) $(CPPFLAGS) -arch sm_35  $(INCLUDES) -o "$@" "$<"

###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : $(MAKEFILE)


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	@echo "### PRODUCT = $(PRODUCT)"
	@echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	@echo "### BUILD_TYPE = $(BUILD_TYPE)"
	@echo "### INCLUDES = $(INCLUDES)"
	@echo "### DEFINES = $(DEFINES)"
	@echo "### ALL_SRCS = $(ALL_SRCS)"
	@echo "### ALL_OBJS = $(ALL_OBJS)"
	@echo "### LIBS = $(LIBS)"
	@echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	@echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	@echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	@echo "### CFLAGS = $(CFLAGS)"
	@echo "### LDFLAGS = $(LDFLAGS)"
	@echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	@echo "### CPPFLAGS = $(CPPFLAGS)"
	@echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	@echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	@echo "### ARFLAGS = $(ARFLAGS)"
	@echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	@echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	@echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files..."
	$(RM) $(PRODUCT)
	$(RM) $(ALL_OBJS)
	$(ECHO) "### Deleted all derived files."


