module mat_mult #(
  parameter N_ROWS = 4,
  parameter N_COLUMNS = 4,
  parameter DW = 8
) (
  input clk,
  input reset,
  input logic signed [DW-1:0] mat1 [0 : N_ROWS-1] [0 : N_COLUMNS-1],
  input logic signed [DW-1:0] mat2 [0 : N_ROWS-1] [0 : N_COLUMNS-1],
  output logic signed [DW*2-1:0] mat_out [0 : N_ROWS-1] [0 : N_COLUMNS-1]
);

  ///compute
  assign sums[0] = inp1[0] * inp2[0];

  dot_product_2 #(
    .N(N_ROWS),
    .DW(DW)
  ) dot_product_2_dut (
    .clk(clk),
    .reset(reset),
    .inp1(mat1[0]),
    .inp2(mat2[0]),
    .sums(mat_out)
  );

  // generate
  //   for (genvar i = 1; i < N_ROWS; i = i + 1) begin : mat_loop
  //     assign sums[i] = sums[i-1] + inp1[i] * inp2[i];
  //   end
  // endgenerate

endmodule : mat_mult
