module fifo_transfer #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 16,
  parameter DATA_AMOUNT = 16, 
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input  logic clk,
  input  logic reset,
  input  int matrix_out_in [0:ADDR_WIDTH-1] [0:ADDR_WIDTH-1],  // The output of the dot product matrix is the input of the FIFO
  output logic done
);

  // fifo inputs
  logic clk;
  logic reset;
  logic write_enable;
  logic read_enable;
  int data_in; 

  // fifo outputs
  int data_out;  
  logic full;
  logic empty;

  // Instantiate the sync_fifo module
  simple_sync_fifo #(
    .DATA_WIDTH(DATA_WIDTH),  
    .FIFO_DEPTH(DEPTH) 
  ) dut (
    .clk(clk),
    .reset(reset),
    .push(write_enable),
    .wr_data(data_in),
    .pop(read_enable),
    .rd_data(data_out),
    .fifo_full(full),
    .fifo_empty(empty)
  );

  // Instantiate the simple_dualport_mem module
  
  // alaways_ff for pushing data into the FIFO till full then poping data out  
  // of the FIFO till empty to the dualport memory
endmodule