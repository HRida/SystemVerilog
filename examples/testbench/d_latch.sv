module d_latch (
  input logic d,
  input logic en,
  input logic rstn,
  output logic q
);

  always @(en or rstn or d) begin
    if (!rstn) begin
      q <= 0;
    end else begin
      if (en) begin
        q <= d;
      end
    end
  end
endmodule
