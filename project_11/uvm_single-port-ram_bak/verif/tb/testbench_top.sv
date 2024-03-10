`ifndef TESTBENCH_TOP
`define TESTBENCH_TOP

 `include "uvm_macros.svh"
 `include "interface.sv"
import uvm_pkg::*;

module testbench_top;

    //import all tests
    import test_list::*;

    test t;       // instance of our test
    ram_if rif(); // virtual interface

    //instantiate the DUT
    ram dut (.clk(rif.clk), 
             .wr(rif.wr), 
             .din(rif.din), 
             .dout(rif.dout),
             .addr(rif.addr));

         //toggle clock
    initial begin
      rif.clk = 0;
    end
    always#10 rif.clk = ~rif.clk;

    // main simulation here
    initial begin
     uvm_config_db#(virtual ram_if)::set(uvm_root::get(),"*","rif",rif);
     run_test();  //uvm task to run the test
    end

endmodule
`endif

