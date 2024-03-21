module UpDownCounter_tb;
  reg CLK;
  reg RESET;
  reg LOAD;
  reg [5:0] DATA;
  reg COUNT_UP;
  wire [5:0] COUNT;

  // Instantiate the UpDownCounter
  UpDownCounter u1 (
    .CLK(CLK),
    .RESET(RESET),
    .LOAD(LOAD),
    .DATA(DATA),
    .COUNT_UP(COUNT_UP),
    .COUNT(COUNT)
  );

  // Clock generator
  always begin
    #5 CLK = ~CLK;
  end

  // Test sequence
  initial begin
    // Initialize signals
    CLK = 0;
    RESET = 0;
    LOAD = 0;
    DATA = 0;
    COUNT_UP = 0;

    #10;
    RESET = 1;  // Reset the counter
    #10;
    RESET = 0;  // Release the reset
    #10;
    LOAD = 1; // Load the counter
    DATA = 6'b101010; // Load with this value
    #10;
    LOAD = 0;  // Stop loading
    #10;
    COUNT_UP = 1;  // Start counting up
    #20;
    COUNT_UP = 0;  // Start counting down
    #20;
    $finish;  // End the simulation
  end
endmodule
