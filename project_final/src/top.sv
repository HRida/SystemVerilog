// Define the width of the DUT output
parameter int OUTPUT_WIDTH = 8;

module top;
  // Clock and reset signals
  input logic clk;
  input logic rst;

  // Array to store DUT outputs
  logic [OUTPUT_WIDTH-1:0] outputs[0:9];

  // DUT instantiation
  DUT dut0 (clk, rst, outputs[0]);
  DUT dut1 (clk, rst, outputs[1]);
  DUT dut2 (clk, rst, outputs[2]);
  DUT dut3 (clk, rst, outputs[3]);
  DUT dut4 (clk, rst, outputs[4]);
  DUT dut5 (clk, rst, outputs[5]);
  DUT dut6 (clk, rst, outputs[6]);
  DUT dut7 (clk, rst, outputs[7]);
  DUT dut8 (clk, rst, outputs[8]);
  DUT dut9 (clk, rst, outputs[9]);

  // Variable to store the sum
  logic [OUTPUT_WIDTH+3:0] sum;  // +3 to accommodate potential overflow

  // Calculate the sum in an always_comb block
  always_comb
  begin
    sum = 0;
    for (int i = 0; i < 10; i++)
    begin
      sum = sum + outputs[i];
    end
  end

  // Optional: Print the sum after simulation
  initial
  begin
    #100;  // Wait for simulation to settle
    $display("Sum of DUT outputs: %0d", sum);
    $finish;
  end

endmodule
