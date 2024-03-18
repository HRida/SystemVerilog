module mod3_counter_1 (
  input clk,
  rstn,
  output reg [1:0] out
);

  always @(posedge clk) begin
    if (!rstn | out[1] & out[0]) out <= 0;
    else out <= out + 1;
  end
endmodule : mod3_counter_1

module mod3_counter_2 (
  input clk,
  rstn,
  output reg [1:0] out
);
  always @(posedge clk) begin
    if (!rstn) out <= 0;
    else if (out == 3) out <= 0;
    else out <= out + 1;
  end
endmodule : mod3_counter_2

module mod3_counter_3 (
  input clk,
  rstn,
  output reg [1:0] out
);
  always @(posedge clk) begin
    if (!rstn) out <= 0;
    else if (&out) out <= 0;
    else out <= out + 1;
  end
endmodule : mod3_counter_3
