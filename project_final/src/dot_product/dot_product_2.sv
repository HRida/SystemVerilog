module dot_product_2 #(
  parameter N = 2,
  parameter DW = 8
) (
  input clk,
  input reset,
  input logic signed [DW-1:0] inp2 [0:N-1],
  input logic signed [DW-1:0] inp1 [0:N-1],
  output logic signed [DW*2-1:0] sums
);  

  ///compute
  assign sums[0] = inp1[0] * inp2[0];

  generate
    for (genvar i = 1; i < N; i = i + 1) begin : sum_loop
      assign sums[i] = sums[i-1] + inp1[i] * inp2[i];
    end
  endgenerate

endmodule : dot_product_2
