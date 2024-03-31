#!/bin/bash
sleep_time=20

# Set up the environment
echo " Setting up the environment!"
source /shares/nct-opt/software/xilinx/settingsZitiVivado.sh 2021.2

# Create the build binaries
echo " Building binaries!"
make -f ../test/Makefile.run build

# Run the mem_creator
echo " Running mem_creator!"
../test/mem_creator.o

# Run the test_generator
echo " Running test_generator!"
../test/test_generator.o

# Run the test_bench
make top_quick

# Wait for the simulation to finish
# echo -n "Waiting for $sleep_time seconds till the simulation finish: "

# for ((i=1; i<=sleep_time; i++))
# do
#     sleep 1
#     echo -n "."
# done

# Running buffer_comperator
echo " Running buffer_comperator!"
../test/buffer_comperator.o

echo " Done!"