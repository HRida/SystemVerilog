# Project structure

### 1. sim file

```
a) It contains multiple makefile enviroment for each module.
b) Using make (top Makefile) which has an overview on all the makefiles that can be used easily to simulate the output of each testbench.
c) Makefile_run.sh is a bash file that can run automatically the whole process from generating memory to generating outputs and start the simulation till testing the output buffers of the two files.
```

### 2. src file

```
a) The whole simulation src files coded in system verilog (.sv).
b) testbenches for each module that can be evaluated on its own.
```

### 2. test file

```
a) The test environment contains three files with there binaries.
b) Running "make build" will creates the following binaries mem_creator.o / test_generator.o / buffer_comperator.o
b) mem_creator.c is the code to create a rom_file.mem, where by changing the value of the define N_ELEMENTS can create different sizes. (be aware by changing the values you need change the DATA_AMOUNT parameter in the topmodule under src to maintain consistency)
c) test_generator.c is the code to create the expected output of the matrix multiplication that is applied with mem_creator.c which will spits out a file called output_expected.
d) buffer_comperator.c is the code to compare the output_expected from (.c) and output file from RTL (.sv).
```

# Running the project

### It is simple as running the shell file found under sim

```
cd sim
./Makefile_run.sh
```

**Note: please provide the proper privildges for the .o files and the .mem file**
