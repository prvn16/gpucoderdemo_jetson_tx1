if isempty(currentFigures), currentFigures = []; end;
close(setdiff(findall(0, 'type', 'figure'), currentFigures))
clear mex
delete *.mexw64
[~,~,~] = rmdir('C:\Sumpurn\gpucoderdemo_jetson_tx1\codegen','s');
clear C:\Sumpurn\gpucoderdemo_jetson_tx1\getAlexnet.m
delete C:\Sumpurn\gpucoderdemo_jetson_tx1\getAlexnet.m
delete C:\Sumpurn\gpucoderdemo_jetson_tx1\synsetWords.txt
delete C:\Sumpurn\gpucoderdemo_jetson_tx1\maxperf.sh
delete C:\Sumpurn\gpucoderdemo_jetson_tx1\main_webcam.cpp
delete C:\Sumpurn\gpucoderdemo_jetson_tx1\create_exe.mk
clear
load old_workspace
delete old_workspace.mat
delete C:\Sumpurn\gpucoderdemo_jetson_tx1\cleanup.m
cd C:\Sumpurn
rmdir('C:\Sumpurn\gpucoderdemo_jetson_tx1','s');
