module fifo_transfer #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 16,
  parameter DATA_AMOUNT = 16, 
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input  logic clk,
  input  logic reset,
  input  logic enable_fifo,
  input  int matrix_out_in [0:ADDR_WIDTH-1] [0:ADDR_WIDTH-1],  // The output of the dot product matrix is the input of the FIFO
  output logic fifo_done,
  output int write_to_file
);

  // fifo inputs
  logic push_enable;
  logic pop_enable;
  int fifo_data_in; 

  // fifo outputs
  int fifo_data_out;  
  logic fifo_full;
  logic fifo_empty;

  // write back to file
  // int write_to_file;

  // iteration flags
  int i = 0, j = 0;

  // counter for popped elements
  int pop_counter = 0, pop_counter_nxt;

  // Instantiate the sync_fifo module
  simple_sync_fifo #(
    .DATA_WIDTH (DATA_WIDTH),  
    .FIFO_DEPTH (DEPTH),
    .DATA_AMOUNT(DATA_AMOUNT)
  ) simple_sync_fifo (
    .clk        (clk),
    .reset      (reset),
    .push       (push_enable),
    .wr_data    (fifo_data_in),
    .pop        (pop_enable),
    .rd_data    (fifo_data_out),
    .fifo_full  (fifo_full),
    .fifo_empty (fifo_empty)
  );

  always_ff @(posedge clk) begin
    if (reset) begin
      push_enable <= 0;
      fifo_done <= 0;
    end
    else begin
      if (enable_fifo) begin
        if (~fifo_full) begin
          push_enable <= 1;
          fifo_data_in = matrix_out_in[i][j];
        end
        if (~fifo_empty) begin
          write_to_file = fifo_data_out;
          pop_counter = pop_counter_nxt;
        end
        if (pop_counter == (ADDR_WIDTH * ADDR_WIDTH)+1)
          fifo_done <= 1;
      end 
      else begin
        push_enable <= 0;
      end
    end
  end

  always_comb pop_enable = !fifo_empty;

  always_comb pop_counter_nxt = pop_counter + 1;

  always @(posedge clk) begin
    if(enable_fifo) begin
      if(i <= 3) begin
      j <= j + 1;
      end
      if(j >= 3) begin
        i <= i + 1;
        j <= 0;
      end
    end
  end

endmodule