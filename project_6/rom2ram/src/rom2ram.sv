module DMA #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 4
) (
  input logic clk,
  input logic rst,
  input logic start, // flag to start a transfer
  input logic srcPtr, // pointer to the source address
  input logic [ADDR_WIDTH-1:0] srcAddr, // base source address for the transfer
  input logic destPtr, // pointer to the destination address
  input logic [ADDR_WIDTH-1:0] destAddr, // base destination address for the transfer
  input logic [ADDR_WIDTH-1:0] data_amt, // data amount to be transferred
  output logic done // notify end of transfer
);
  logic [31:0] current_element = 0;

  always @(posedge clk) begin  // or posedge reset
    if (rst) done <= 1'b0;
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

module ROM #(
  parameter INIT_FILE = "rom_file.mem",
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 8,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input logic clk,
  input logic  [ADDR_WIDTH-1:0] rd_addr,
  output logic [DATA_WIDTH-1:0] rd_data
);

  logic [DATA_WIDTH-1:0] rom[DEPTH];

  initial $readmemh(INIT_FILE, rom);

  always_ff @(posedge clk) rd_data <= rom[rd_addr];

endmodule : ROM

module RAM #(
  parameter DATAWIDTH=16,
  parameter ADDRWIDTH=8
) (
  input logic clk,
  //PORT A (read/write port)
  input logic [ADDRWIDTH-1:0] addra, //write address
  input logic [DATAWIDTH-1:0] dina, //data input
  input logic wea, //write enable
  output logic [DATAWIDTH-1:0] douta, //data output

  //PORT B (read/write port)
  input logic [ADDRWIDTH-1:0] addrb, //write address
  input logic [DATAWIDTH-1:0] dinb, //data input
  input logic web, //write enable
  output logic [DATAWIDTH-1:0] doutb //data output
);

  //declare an unpacked array
  // signal for storing data
  logic [DATAWIDTH-1:0] mem[0:(1<<ADDRWIDTH)-1];

  //Port A can read or write data
  always_ff @(posedge clk) begin
    if (wea) mem[addra] <= dina;
    douta <= mem[addra];
  end

  //Port B can read or write data
  always_ff @(posedge clk) begin
    if (web) mem[addrb] <= dinb;
    doutb <= mem[addrb];
  end
endmodule : true_dualport_mem

