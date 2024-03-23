module parallel2serial #(
  DATA_WIDTH = 4
) (
  input logic clk,
  input logic reset,
  input logic [DATA_WIDTH-1:0] parin, //parallel input
  input logic load, //load the parallel input
  output logic completed, //notifies end of serialization
  output logic serout //serial output
);

  //buffer to hold parallel input value when load is set to 1
  logic [DATA_WIDTH-1:0] buffered_parin;
  //counter to count bits serially output
  logic [$clog2(DATA_WIDTH)-1:0] counter;

  always_ff @(posedge clk) begin
    if (reset) begin
      serout <= 0;
      counter <= 0;
      completed <= 1'b0;
    end else if (load) begin
      buffered_parin <= parin;
      counter <= 0;
      serout <= 0;
      completed <= 1'b0;
    end else begin
      serout <= buffered_parin[DATA_WIDTH-1];

      //flag completion here
      if (counter == DATA_WIDTH - 1) begin
        completed <= 1'b1;
        //otherwise increment counter and shift the stored parallel input
      end else begin
        counter <= counter + 1;
        buffered_parin[DATA_WIDTH-1:1] <= buffered_parin[DATA_WIDTH-2:0];
      end
    end
  end

endmodule : parallel2serial


