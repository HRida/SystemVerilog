module barrelshifter_tb;

  // Parameters
  localparam WIDTH = 8;

  // Signals
  logic [WIDTH-1:0] data_in, data_out;
  logic [$clog2(WIDTH)-1:0] shift_amount;
  logic shift_direction;  // 0: right shift, 1: left shift
  logic selector;  // 0: normal shift, 1: arithmetic shift

  // Instantiate the BarrelShifter module
  barrelshifter_enhanced #(WIDTH) DUT (.*);

  // Stimulus generation
  initial begin
    // Initialize signals
    data_in = 8'b10101010;
    shift_amount = 5;
    shift_direction = 0; // Right shift
    selector = 0; // Normal shift

    // Test right shift
    #10;
    if (data_out !== 8'b00000101) $fatal(1, "Test failed for right shift");

    // Test left shift
    data_in = 8'b00000101;
    shift_amount = 2;
    shift_direction = 1; // Left shift
    #10;
    if (data_out !== 8'b00010100) $fatal(1, "Test failed for left shift");

    // Test arithmetic shift with MSB = 1
    data_in = 8'b10101010;
    shift_amount = 2;
    shift_direction = 0; // Right shift
    selector = 1; // Arithmetic shift
    #10;
    if (data_out !== 8'b11101010) $fatal(1, "Test failed for arithmetic shift with MSB = 1");

    // Test arithmetic shift with MSB = 0
    data_in = 8'b00101010;
    shift_amount = 2;
    shift_direction = 0; // Right shift
    selector = 1; // Arithmetic shift
    #10;
    if (data_out !== 8'b00001010) $fatal(1, "Test failed for arithmetic shift with MSB = 0");

    // Finish simulation
    #10 $stop;
  end

  // Monitor
  always @(*) begin
    $display("Time=%0t: data_in=%b, shift_amount=%0d, \
    shift_direction=%b, selector=%b, data_out=%b", $time, data_in, shift_amount,
             shift_direction, selector, data_out);
  end

endmodule

