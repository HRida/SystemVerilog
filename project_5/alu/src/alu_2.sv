module alu_2 #(
  parameter WIDTH = 4
) (
  input logic [WIDTH-1:0] operand_a,
  input logic [WIDTH-1:0] operand_b,
  input logic [2:0] alu_op,
  output logic [WIDTH-1:0] result,
  output logic zero
);

  // Internal signals
  logic [WIDTH-1:0] and_result, or_result;
  logic [WIDTH-1:0] xor_result, add_result;
  logic [WIDTH-1:0] sub_result, mul_result;

  // AND operation
  always_comb and_result = operand_a & operand_b;

  // OR operation
  always_comb or_result = operand_a | operand_b;

  // XOR operation
  always_comb xor_result = operand_a ^ operand_b;

  // ADD operation
  always_comb add_result = operand_a + operand_b;

  // SUB operation
  always_comb sub_result = operand_a - operand_b;

  // MUL operation
  always_comb mul_result = operand_a * operand_b;

  // Output result based on ALU operation code
  always_comb begin
    case (alu_op)
      3'b000:  result = and_result;  // AND
      3'b001:  result = or_result;  // OR
      3'b010:  result = xor_result;  // XOR
      3'b011:  result = add_result;  // ADD
      3'b100:  result = sub_result;  // SUB
      3'b101:  result = mul_result;  // MUL
      default: result = 0;
    endcase
  end

  // Output zero flag
  always_comb zero = (result == 0);

endmodule
