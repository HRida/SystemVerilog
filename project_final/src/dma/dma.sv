module dma #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 4,
  parameter DATA_AMOUNT = 16,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input  logic clk,
  input  logic reset,
  input  logic start_dma,                     // flag to start a transfer
  input  logic [DATA_AMOUNT-1:0] data_amt,    // data amount to be transferred
  input  logic [DATA_WIDTH-1:0] rom_data,     // data from ROM 
  input  logic [ADDR_WIDTH-1:0] rom_addr,     // base source address for the transfer
  output logic [ADDR_WIDTH-1:0] ram_addr,     // base destination address for the transfer
  output logic [DATA_WIDTH-1:0] ram_data,     // data to be written to RAM  
  // output logic done,                       // notify end of transfer
  output logic ram_wea                        // write enable for RAM 
);
  // logic [ADDR_WIDTH-1:0] current_element = 0;

  always @(posedge clk) begin  // or posedge reset
    if (reset)begin 
      // done <= 1'b0;
      // current_element <= 1'b0;
      ram_wea <= 1'b0;
    end 
    else if (start_dma) begin
      // if (ram_addr < data_amt) begin
      // Perform DMA transfer // RAM <= ROM
      ram_addr <= rom_addr; 
      // current_element <= current_element + 1;
      ram_data <= rom_data;
      ram_wea <= 1'b1;
      // end else begin
      //   done <= 1'b1;
      //   ram_wea <= 1'b0;
      // end
    end
  end
endmodule : dma

