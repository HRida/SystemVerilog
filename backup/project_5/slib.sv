`timescale 1 ns / 1 ps
import Types::*;
module slib();
  /* paramters to certain block */
  reg         clk;
  reg         rstb;
  reg         ena;
  logic [7:0] result;
  logic       equal;
  sel_t       Sel_i;
  // Op1 
  // Op2 
  // Sel 
  // C_In
  // Mode
  always_comb begin
    Sel_i=0;
  end

  always @(posedge clk or negedge rstb) if(!rstb) ena<=0; else ena<=~ena;
  ALU #() dut(
     .Result(result),
     .Equal(equal ),
     .Op1(4'd1),
     .Op2(4'd1),
     .Sel(Sel_i),
     .C_In(0'b0),
     .Mode(0'b0)
);

   /* clk and reset generation */
  parameter CLK_PERIOD=25;
  parameter HAF_PERIOD=0.5*CLK_PERIOD;
  initial begin clk =1'b0; forever begin #HAF_PERIOD clk=~clk;end end
  initial begin rstb=1'b0; #100 rstb=1'b1; end

endmodule

