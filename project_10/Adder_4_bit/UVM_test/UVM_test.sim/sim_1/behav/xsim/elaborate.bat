@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Thu Jan 23 03:20:41 +0530 2020
REM SW Build 2708876 on Wed Nov  6 21:40:23 MST 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto 2eb18a5bf9ec4666b114743800cde057 --debug typical --relax --mt 2 -d "NO_OF_TRANSACTIONS=2000" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot adder_4_bit_tb_top_behav xil_defaultlib.adder_4_bit_tb_top xil_defaultlib.glbl -log elaborate.log -L UVM -timescale 1ns/1ps"
call xelab  -wto 2eb18a5bf9ec4666b114743800cde057 --debug typical --relax --mt 2 -d "NO_OF_TRANSACTIONS=2000" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot adder_4_bit_tb_top_behav xil_defaultlib.adder_4_bit_tb_top xil_defaultlib.glbl -log elaborate.log -L UVM -timescale 1ns/1ps
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
