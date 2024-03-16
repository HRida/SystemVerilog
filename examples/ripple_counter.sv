module ripple_counter #(parameter int WIDTH = 4) (
    input logic CLK,
    input logic CLR,
    output logic [WIDTH-1:0] COUNT
);
  generate
    for (genvar i = 0; i < WIDTH; i++) begin : gen_bit
      logic local_clk;
      always_comb local_clk = (i == 0) ? CLK : !COUNT[i-1];
      TFF tff_I (
          .CLK(local_clk),
          .CLR,
          .Q  (COUNT[i])
      );
    end
  endgenerate
endmodule : ripple_counter
