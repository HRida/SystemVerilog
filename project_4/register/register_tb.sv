module register_tb;

  // Declare the signals
  logic clk;
  logic reset;
  logic d;
  logic q;

  // Instantiate the module under test (MUT)
  register register_dut (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  // Stimulus
  initial begin
    // Initialize signals
    reset = 1;
    d = 0;
    #20 reset = 0;  // Release reset
    #20 d = 1'b1;  // Change input
    #40 d = 1'b0;  // Change input
    #20 $finish;  // End simulation
  end

  // Monitor
  initial begin
    $monitor("At time %0d, reset = %b, d = %b, q = %b", $time, reset, d, q);
  end

endmodule : tb_register
