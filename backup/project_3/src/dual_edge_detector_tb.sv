module dual_edge_detector_tb;
  // Inputs
  logic clk;
  logic reset;
  logic signal;
  // Outputs
  logic pos_edge;
  logic neg_edge;

  // Instantiate the EdgeDetector module
  dual_edge_detector DUT (
    .clk(clk),
    .reset(reset),
    .signal(signal),
    .pos_edge(pos_edge),
    .neg_edge(neg_edge)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // ... your code goes here

    // Terminate simulation
    #10 $finish;
  end

endmodule

