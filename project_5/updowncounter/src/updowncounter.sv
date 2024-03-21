module UpDownCounter (
  input logic CLK,
  input logic RESET,
  input logic LOAD,
  input logic [5:0] DATA,
  input logic COUNT_UP, // == 1: count up, == 0: count down
  output logic [5:0] COUNT
);
  always_ff @(posedge CLK) begin
    if (RESET) begin
      COUNT <= 6'b0;  // Reset the counter
    end else if (LOAD) begin
      COUNT <= DATA;  // Load the data into the counter
    end else begin
      if (COUNT_UP) begin
        COUNT <= COUNT + 1;  // Count up
      end else begin
        COUNT <= COUNT - 1;  // Count down
      end
    end
  end
endmodule : UpDownCounter
