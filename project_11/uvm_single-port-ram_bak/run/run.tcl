exec xvlog -sv -f ramlist.f -L uvm -define NO_OF_TRANSACTIONS=200 ; 
exec xelab testbench_top -relax -s top -timescale 1ns/1ps ;  
exec xsim top -testplusarg UVM_TESTNAME=test -testplusarg UVM_VERBOSITY=UVM_LOW -runall
