SRC_PATH_DMA=../src/dma
SRC_PATH_ROM=../src/rom
SRC_PATH_RAM=../src/ram
DMA_MODULE=dma
ROM2RAM_MODULE=rom2ram
ROM_MODULE=rom
RAM_MODULE=simple_dualport_mem
TESTBENCH_NAME=rom2ram_tb

all: simulate

sv_compile:
	cp $(SRC_PATH_DMA)/rom_file.mem .
	xvlog -sv $(SRC_PATH_DMA)/$(DMA_MODULE).sv $(SRC_PATH_DMA)/$(ROM2RAM_MODULE).sv $(SRC_PATH_ROM)/$(ROM_MODULE).sv $(SRC_PATH_RAM)/$(RAM_MODULE).sv $(SRC_PATH_DMA)/$(TESTBENCH_NAME).sv 
	
elaborate: sv_compile
	xelab -debug typical -top $(TESTBENCH_NAME) -snapshot $(TESTBENCH_NAME)_snapshot 

simulate: elaborate
	xsim $(TESTBENCH_NAME)_snapshot -R 

simulate_dump: elaborate
	xsim $(TESTBENCH_NAME)_snapshot -tclbatch Makefile_cfg_xsim.tcl
	xsim --gui $(TESTBENCH_NAME)_snapshot.wdb

simulate: elaborate

clean:
	#find . -type f ! -name 'Makefile*' -execdir rm {} +
	find . -type f ! -name 'Makefile*' | xargs rm 
	rm -rf xsim*
