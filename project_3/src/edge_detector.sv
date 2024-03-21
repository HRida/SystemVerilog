
module edge_detector (
  input logic clk,
  input logic reset,
  input logic signal,
  output logic pos_edge
);

  logic delayed_signal;

  always_ff @(posedge clk) begin
    if (reset == 1'b1) delayed_signal <= 1'b0;
    else delayed_signal <= signal;
  end

  assign pos_edge = (signal & !delayed_signal);

endmodule
