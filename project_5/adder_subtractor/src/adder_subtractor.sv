module adder_subtractor #(
  parameter DATA_WIDTH = 8
) (
  input logic [DATA_WIDTH-1:0] operand_a,
  input logic [DATA_WIDTH-1:0] operand_b,
  input logic operation, // 1:add or 0:subtract
  output logic of_uf, //overflow or underflow
  output logic [DATA_WIDTH-1:0] result
);

  always_comb {of_uf, result} = operation ? (operand_a + operand_b) : (operand_a - operand_b);

endmodule : adder_subtractor
