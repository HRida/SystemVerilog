module dot_product #(N = 4) (
    input clk,
    input reset,
    input array of signed(N-1:0) [7:0] a,
    input array of signed(N-1:0) [7:0] b,
    output array of signed(N-1:0) [15:0] f
);

  logic signed [15:0] out, mul1, mul2, f; // properly do that 
  
  f = dual_mac_out; 

  vector_multiply dut0 (clk, rst, input1_array, input2_array, out_enable, output_array);

  accumalator dut1 (clk, rst, out_enable, output_array, f);

  
endmodule
