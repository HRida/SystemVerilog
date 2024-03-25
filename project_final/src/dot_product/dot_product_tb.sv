`timescale 1 ns / 1 ps
`define NUM_ELEMS 5
`define DATA_WIDTH 2

parameter CLK_PERIOD = 12.5; 
parameter HALF_PERIOD = 0.5 * CLK_PERIOD;

module dot_product_tb;
  
  logic clock = 1'b1;
  logic reset = 1'b0;
  logic enable = 1'b0;
  int sum;
  
  //generate clock signal
  always #5ns clock = ~clock;
  
  int array1[0:1][0:1];
  int array2[0:1][0:1];
  // int vec1 [0:1];
  // int vec2 [0:1];
  
  initial begin
    //array initialization
    array1 = '{'{1, 2}, '{3, 4}};
    array2 = '{'{1, 2}, '{3, 4}};
    // vec1 = '{1, 2};
    // vec2 = '{1, 2};
    
    //displaying array elements 
    $display("-------displaying 2d array-------");
    foreach(array1[i,j]) $display("\t array1[%0d][%0d] = %0d",i,j,array1[i][j]);
    foreach(array2[i,j]) $display("\t array2[%0d][%0d] = %0d",i,j,array2[i][j]);
  end
  
  dot_product #(
    .N(2),
    .DW(8)
  ) dot_product_dut (
    .clk(clock),
    .reset(reset),
    .enable(enable),
    .inp1(array1[0]),
    .inp2(array2[1]),
    .sum(sum)
  );
  
  initial begin
      clock <= 0; 
      reset <= 1; 
      #10ns reset <= 0; 
      enable <= 1;
      
      #200ns $finish; // finish simu after 40 ns
  end

  // display inputs and output on each clock cycle
  always @(posedge clock) begin
    $display("sum = ", sum);
  end

endmodule
