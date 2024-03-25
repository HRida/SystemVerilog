module mat_mult #(
  parameter N_ROWS = 2,
  parameter N_COLUMNS = 2,
  parameter DW = 8
) (
  input logic clk,
  input logic reset,
  input logic enable,
  input int mat1 [0 : N_ROWS-1] [0 : N_COLUMNS-1],
  input int mat2 [0 : N_ROWS-1] [0 : N_COLUMNS-1],
  output int mat_out [0 : N_ROWS-1] [0 : N_COLUMNS-1]
);

  generate
    for (genvar i = 0; i < N_ROWS; i = i + 1) begin : row_loop
      for (genvar j = 0; j < N_COLUMNS; j = j + 1) begin : col_loop
        dot_product #(.N(N_ROWS), .DW(DW)) dot_product_dut (
          .clk(clk),
          .reset(reset),
          .enable(enable),
          .inp1(mat1[i]),
          .inp2(mat2[j]),
          .sum(mat_out[i][j])
        );
      end
    end
  endgenerate  

endmodule : mat_mult
