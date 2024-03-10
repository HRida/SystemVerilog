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
    clk <= 0;
    reset <= 1'b1;
    signal <= 1'b0;
    #10 reset <= 1'b0;

    // Apply a rising edge
    #15 signal <= 1'b1;

    // Apply a falling edge
    #20 signal <= 1'b0;

    // Terminate simulation
    #10 $finish;
  end

endmodule

