module register (
  input logic clk,
  input logic reset,
  input logic d,
  output logic q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      // Reset the register output
      q <= 1'b0;
    end else begin
      // Store the input value on the rising edge of the clock
      q <= d;
    end
  end
endmodule : register
