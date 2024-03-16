module counter (
    input logic clk,
    clr,
    en,
    ld,
    input logic [7:0] data,
    output logic [7:0] count
);

  timeunit 1ns; timeprecision 100ps;

  always_ff @(posedge clk or posedge clr) begin
    if (clr) count <= 8'b0;
    else if (ld) count <= data;
    else if (en) count <= count + 1'd1;
  end
endmodule : counter
