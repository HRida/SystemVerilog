module multiplexer_tb;
  // Inputs
  logic a, b, select;
  // Output
  logic y;
  // Instantiate the 2-to-1 multiplexer
  multiplexer DUT (.*);
  // Stimulus
  initial begin
    // Test case 1: select = 0
    a = 1;
    b = 0;
    select = 0;
    #10;
    $display("Output y: %b", y);
    // Test case 2: select = 1
    a = 1;
    b = 0;
    select = 1;
    #10;
    $display("Output y: %b", y);
    // End simulation
    $finish;
  end
endmodule
