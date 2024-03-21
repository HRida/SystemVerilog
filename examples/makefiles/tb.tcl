proc tbsim { } {
 vlib work;
#  vlog ../src/arbiter.sv;
#  vlog ../src/arbiter_tb.sv;
 vlog  ../src/dual_edge_detector_tb.sv;
 vlog  ../src/dual_edge_detector_tb.sv;
 # vlog  ../src/counter.sv;
 # vlog  ../src/counter_tb.sv;

#  vsim -voptargs=+acc arbiter_tb
 vsim -voptargs=+acc dual_edge_detector_tb

add wave *
add wave DUT/*


#  add wave -radix unsigned dut/*
 run 2500ns;   
}