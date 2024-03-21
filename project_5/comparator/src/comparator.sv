module comparator #(
  parameter DATA_WIDTH = 4
) (
  input logic [DATA_WIDTH-1:0] operand_a,
  input logic [DATA_WIDTH-1:0] operand_b,
  output logic less,
  output logic equal,
  output logic greater
);

  always_comb less = (operand_a < operand_b);

  always_comb equal = (operand_a == operand_b);

  always_comb greater = (operand_a > operand_b);

endmodule : comparator
