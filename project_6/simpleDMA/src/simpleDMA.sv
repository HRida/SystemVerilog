module SimpleDMA #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 4
) (
  input logic clk,
  input logic rst,
  input logic start, // to start a transfer
  output logic done, //notify end of transfer
  //base source address for the transfer
  input logic [ADDR_WIDTH-1:0] srcAddr,
  //base destination address for the transfer
  input logic [ADDR_WIDTH-1:0] destAddr,
  //data amount to be transferred
  input logic [ADDR_WIDTH-1:0] data_amt
);
endmodule : SimpleDMA
