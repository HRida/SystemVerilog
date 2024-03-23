module mac (
  input clk,
  input reset,
  input signed [7:0] a,
  input signed [7:0] b,
  output logic signed [15:0] f
);

  logic signed [7:0] l1, l2;
  logic signed [15:0] out, mul, add;

  always_ff @(posedge clk) begin
    if (reset == 1) begin
      l1 <= 0;
      l2 <= 0;
    end else begin
      l1 <= a;
      l2 <= b;
    end
  end

  always_ff @(posedge clk) begin
    if (reset == 1) f <= 0;
    else f <= add;
  end

  always_comb begin
    mul = l1 * l2;
    add = mul + f;
  end

endmodule
