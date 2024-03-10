SRC_PATH=../src
TOP_NAME=ROM
TESTBENCH_NAME=ROM_tb

all: simulate

sv_compile:
	cp $(SRC_PATH)/rom_init.mem .
	xvlog -sv $(SRC_PATH)/$(TOP_NAME).sv $(SRC_PATH)/$(TESTBENCH_NAME).sv

elaborate: sv_compile
	xelab -debug typical -top $(TESTBENCH_NAME) -snapshot $(TESTBENCH_NAME)_snapshot

simulate: elaborate
	xsim $(TESTBENCH_NAME)_snapshot -R 

simulate_dump: elaborate
	xsim $(TESTBENCH_NAME)_snapshot -tclbatch Makefile_cfg_xsim.tcl
	xsim --gui $(TESTBENCH_NAME)_snapshot.wdb

simulate: elaborate

clean:
	find . -type f ! -name 'Makefile*' | xargs rm 
	rm -rf xsim.dir
