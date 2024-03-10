proc tbsim { } {
 vlib work;
 vlog ALU.sv;
 vlog slib.sv;
 vsim -voptargs=+acc slib

add wave *

#  add wave -radix unsigned dut/*
 run 2500ns;   
}
