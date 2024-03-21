proc tbsim { } {
 vlib work;
 # vlog  ../src/counter_tb.sv;
 vlog  ../../src/;

#  vsim -voptargs=+acc arbiter_tb
 vsim -voptargs=+acc dual_edge_detector_tb

add wave *
add wave DUT/*


#  add wave -radix unsigned dut/*
 run 2500ns;   
}