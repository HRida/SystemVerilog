module DMA #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 4
) (
  input logic clk,
  input logic reset,
  input logic start, // flag to start a transfer
  input logic [7:0] srcPtr, // pointer to the source address
  input logic [ADDR_WIDTH-1:0] src_addr, // base source address for the transfer
  input logic destPtr, // pointer to the destination address
  input logic [ADDR_WIDTH-1:0] dest_addr, // base destination address for the transfer
  input logic [ADDR_WIDTH-1:0] data_amt, // data amount to be transferred
  output logic done // notify end of transfer
);
  logic [31:0] current_element;

  always @(posedge clk) begin  // or posedge reset
    if (reset) done <= 1'b0;
    else if (start) begin
      if (current_element < data_amt) begin
        // Perform DMA transfer
        destAddr[destPtr + current_element] <= srcAddr[srcPtr + current_element]; // RAM <= ROM
        current_element <= current_element + 1;
      end else begin
        done <= 1'b1;
      end
    end
  end
endmodule

