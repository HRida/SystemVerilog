// timeunit 1ns; timeprecision 100ps; used in slib
import data_types::*;

module alu (
  input  logic       Clock,
  output logic [7:0]   Result,
  output logic         Equal,
  input  logic [3:0] Op1,
  input  logic [3:0] Op2,
  input  sel_t       Sel,
  input  logic       C_In,
  input  mode_t      Mode
);

  always @(posedge Clock) begin
    Equal <= (Op1 == Op2);

    case (Sel)
      ADD: Result <= (Mode == WITH_CARRY) ? (Op1 + Op2 + C_In) : (Op1 + Op2);
      SUBTRACT: Result <= (Mode == WITH_CARRY) ? (Op1 - Op2 - C_In) : (Op1 - Op2);
      MULTIPLY: Result <= Op1 * Op2;
      default: Result <= 8'b0;
    endcase
  end

endmodule : alu
