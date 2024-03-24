module mac #(
  parameter DATA_WIDTH = 4
) (
  input logic clk,
  input logic reset,
  input logic [DATA_WIDTH-1:0] operand_a,
  input logic [DATA_WIDTH-1:0] operand_b,
  output logic [2*DATA_WIDTH-1:0] acc
);

  logic [2*DATA_WIDTH-1:0] accumulator;
  logic [2*DATA_WIDTH-1:0] product;

  always_ff @(posedge clk) begin
    if (reset) begin
      accumulator <= 0;
      product <= 0;
    end else begin
      product <= operand_a * operand_b;
      accumulator <= accumulator + product;
    end
  end

  assign acc = accumulator;

endmodule : mac
