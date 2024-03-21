module MAC_tb;
  // Local Parameters
  localparam WIDTH = 8;
  // Signals
  logic clk, reset;
  logic [WIDTH-1:0] operand_a, operand_b;
  logic [2*WIDTH-1:0] acc;

  // Instantiate the MAC module
  MAC #(WIDTH) mac_dut (.*);

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    // Initialize signals
    reset = 1;
    operand_a = 4'b0011; //3
    operand_b = 4'b0101; //5

    // Disable reset
    #10 reset = 0;
    // Apply operands and observe the result
    operand_a = 4'b0010; //2
    operand_b = 4'b0011; //3
    #10;
    operand_a = 4'b1111; //15
    operand_b = 4'b0001; //1
    #10;
    assert (acc == 6);  //2*3
    operand_a = 4'b0010; //2
    operand_b = 4'b0010; //2
    #10;
    assert (acc == 21);  //6+15*1
    #10;
    assert (acc == 25);  //(6+15*1)+2*2
    // Finish simulation
    #10 $stop;
  end
  // Monitor
  always_ff @(posedge clk) begin
    $display("Time=%0t: operand_a=%b, operand_b=%b, acc=%b", $time, operand_a, operand_b, acc);
  end
endmodule
