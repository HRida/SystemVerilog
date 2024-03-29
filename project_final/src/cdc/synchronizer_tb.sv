// `timescale 1ns / 1ps

module synchronizer_tb;

  // Parameters
  parameter CLK_PERIOD = 10;

  // Signals
  reg clk2;
  reg g;
  wire g_sync;

  synchronizer synchronizer_dut (
    .clk2(clk2),
    .g(g),
    .g_sync(g_sync)
  );

  // Clock generation
  always begin
    # (CLK_PERIOD / 2) clk2 = ~clk2;
  end

  // Stimulus
  initial begin
    // Initialize signals
    clk2 = 0;
    g = 0;

    // Apply stimulus
    #CLK_PERIOD g = 1;
    #CLK_PERIOD g = 0;
    #CLK_PERIOD g = 1;

    // Finish the simulation
    #CLK_PERIOD $finish;
  end

  // Monitor
  initial begin
    $monitor("At time %t, g = %b, g_sync = %b", $time, g, g_sync);
  end

endmodule