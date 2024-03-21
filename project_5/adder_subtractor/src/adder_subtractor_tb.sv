`timescale 1ns / 1ps

module adder_subtractor_tb;

  // Parameters
  localparam DATA_WIDTH = 8;

  // Signals
  logic [DATA_WIDTH-1:0] operand_a;
  logic [DATA_WIDTH-1:0] operand_b;
  logic operation;
  logic of_uf;
  logic [DATA_WIDTH-1:0] result;

  // Instantiate the unit under test (UUT)
  adder_subtractor #(
    .DATA_WIDTH(DATA_WIDTH)
  ) adder_subtractor_dut (
    .operand_a(operand_a),
    .operand_b(operand_b),
    .operation(operation),  // 1:add or 0:subtract
    .of_uf(of_uf),  // MSB is overflow or underflow
    .result(result)
  );

  // Stimulus process
  initial begin
    // Initialize inputs
    operand_a = 0;
    operand_b = 0;
    operation = 0;

    // Wait for 10 ns for the DUT to initialize
    #10;

    // Test addition
    operand_a = 8'hA5; // 165 in decimal
    operand_b = 8'h5A; // 90 in decimal
    operation = 1;
    #10;

    // Test subtraction
    operand_a = 8'hA5; // 165 in decimal
    operand_b = 8'h5A; // 90 in decimal
    operation = 0;
    #10;

    // Test overflow
    operand_a = 8'hFF; // 255 in decimal
    operand_b = 8'h01; // 1 in decimal
    operation = 1;
    #10;

    // Test underflow
    operand_a = 8'h00; // 0 in decimal
    operand_b = 8'h01; // 1 in decimal
    operation = 0;
    #10;

    // Finish the simulation
    $finish;
  end

endmodule  // tb_adder_subtractor
