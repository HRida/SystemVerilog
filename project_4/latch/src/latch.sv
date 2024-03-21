module latch (
  input logic clk,
  input logic enable,
  input logic din,
  output logic dout
);

  always_latch @(posedge clk) begin
    if (enable) begin
      dout <= din;
    end
  end

endmodule : latch
