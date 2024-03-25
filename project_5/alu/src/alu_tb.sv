`timescale 1 ns / 1 ps
import data_types::*;

module alu_tb;
  // Declare the signals
  logic [3:0] Op1;
  logic [3:0] Op2;
  sel_t Sel;
  logic C_In;  // carry in
  mode_t Mode;
  logic [7:0] Result;
  logic Equal;

  // Instantiate the ALU
  alu alu_dut (
    .Result(Result),
    .Equal(Equal),
    .Op1(Op1),
    .Op2(Op2),
    .Sel(Sel),
    .C_In(C_In),
    .Mode(Mode)
  );

  // Test procedure
  initial begin
    // Apply inputs for ADD operation
    Op1 = 4'b0001;
    Op2 = 4'b0010;
    Sel = ADD;
    C_In = 1'b0;
    Mode = 1'b0;

    // Wait for the ALU to process the inputs
    // #10; <<< this is not needed anymore since we are doing actions on every posedge of the clock

    // Wait for the next clock edge
    @(posedge Clock);

    // Check the output
    if (Result !== 4'b0011) begin
      $display("Test failed: Expected 4'b0011, got %b", Result);
    end else begin
      $display("Test passed");
    end

    // Apply inputs for SUB operation
    Op1 = 4'b0100;
    Op2 = 4'b0100;
    Sel = SUB;
    C_In = 1'b0;
    Mode = 1'b0;

    // Wait for the ALU to process the inputs
    // #10; <<< this is not needed anymore since we are doing actions on every posedge of the clock

    // Wait for the next clock edge
    @(posedge Clock);

    // Check the output
    if (Result !== 4'b0000) begin
      $display("Test failed: Expected 4'b0000, got %b", Result);
    end else begin
      $display("Test passed");
    end

    // Apply inputs for MUL operation
    Op1 = 4'b0010; // 2
    Op2 = 4'b0011; // 3
    Sel = MUL;
    C_In = 1'b0;
    Mode = 1'b0;

    // Wait for the ALU to process the inputs
    // #10; <<< this is not needed anymore since we are doing actions on every posedge of the clock

    // Wait for the next clock edge
    @(posedge Clock);

    // Check the output
    if (Result !== 4'b0110) begin  // 2*3 = 6
      $display("Test failed: Expected 4'b0110, got %b", Result);
    end else begin
      $display("Test passed");
    end

    // Finish the simulation
    $finish;
  end
endmodule

