  // timeunit 1ns; timeprecision 100ps; used in slib
import Types::*;

module ALU (
    output logic [7:0] Result,
    output logic       Equal ,
    input  logic [3:0] Op1   ,
    input  logic [3:0] Op2   ,
    input  sel_t       Sel   ,
    input  logic       C_In  ,
    input  mode_t      Mode
);


  always @(*) begin
    case (Sel)
      // ADD: Result = Mode ? (Op1 + Op2 + C_In) : (Op1 + Op2);
      // SUB: Result = Mode ? (Op1 - Op2 - C_In) : (Op1 - Op2);
      ADD: Result = Op1 + Op2;
      SUB: Result = Op1 - Op2;
      MUL: Result = Op1 * Op2;
      default: Result = 32'b0;
    endcase

  end

endmodule : ALU
