module BarrelShifter_tb;

  // Parameters
  localparam WIDTH = 8;

  // Signals
  logic [WIDTH-1:0] data_in, data_out;
  logic [$clog2(WIDTH)-1:0] shift_amount;
  logic shift_direction; // 0: right shift, 1: left shift

  // Instantiate the BarrelShifter module
  BarrelShifter #(WIDTH) DUT (.*);

  // Stimulus generation
  initial begin
    // Initialize signals
    data_in = 8'b10101010;
    shift_amount = 5;
    shift_direction = 0; // Right shift

    // Test right shift
    #10;
    if (data_out !== 8'b00000101)
      $fatal(1,"Test failed for right shift");

    // Test left shift
    data_in = 8'b00000101;
    shift_amount = 2; 
    shift_direction = 1; // Left shift
    #10;
    if (data_out !== 8'b00010100)
      $fatal(1,"Test failed for left shift");

    // Finish simulation
    #10 $stop;
  end

  // Monitor
  always @(*) begin
    $display("Time=%0t: data_in=%b, shift_amount=%0d, \
    shift_direction=%b, data_out=%b",
    $time, data_in, shift_amount, shift_direction, data_out);
  end

endmodule

