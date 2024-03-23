module rom2ram_topmodule #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 8,
  parameter INIT_FILE = "rom_file.mem",
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input clk,
  input reset,
  input [ADDR_WIDTH-1:0] rom_address,
  input [ADDR_WIDTH-1:0] ram_address,
  input [ADDR_WIDTH-1:0] num_elements,
  output reg done
);
  logic [7:0] rom_data;
  logic [7:0] ram_data;

  ROM rom_inst (
    .clk(clk),
    .rd_addr(rom_address),
    .rd_data(rom_data)
  );

  //Instantiate the DUT
  ROM #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .INIT_FILE(INIT_FILE)
  ) DUT (
    .clk(clk),
    .rd_addr(rom_address),
    .rd_data(num_elements)
  );

  simple_dualport_mem ram_inst (  // simple_dualport_memory
    .address(ram_address),
    .write_data(rom_data),
    .write_enable(1'b1),
    .read_data(ram_data)
  );

  DMA dma_inst (
    .clk(clk),
    .reset(reset),
    .start(start),
    .src_addr(rom_address),
    .dest_addr(ram_address),
    .data_amt(num_elements),
    .done(done)
  );
endmodule : rom2ram_topmodule

module RAM #(parameter SIZE = 256) (input [7:0] address, input [7:0] data_in, input write_enable, output logic [7:0] data_out);
  reg [7:0] memory [0:SIZE-1];
  always_ff @(posedge write_enable) memory[address] <= data_in;
  always_ff @(*) data_out = memory[address];
endmodule

module DMA #(parameter SIZE = 256) (input [7:0] src_address, input [7:0] dst_address, input [7:0] length, input start, input clk, ROM rom, RAM ram);
  integer i;
  always @(posedge start) begin
    for (i = 0; i < length; i = i + 1) begin
      @(posedge clk);
      ram.write_enable = 1;
      ram.address = dst_address + i;
      ram.data_in = rom.memory[src_address + i];
    end
    ram.write_enable = 0;
  end
endmodule

module testbench;
  reg [7:0] rom_data [0:255];
  initial begin
    // Initialize ROM data
    for (integer i = 0; i < 256; i = i + 1) rom_data[i] = i;
    ROM rom(.*, rom_data);
    RAM ram(.*, .write_enable(0));
    DMA dma(.src_address(0), .dst_address(0), .length(256), .start(1), .clk(1), .rom(rom), .ram(ram));
    // Check RAM data
    for (integer i = 0; i < 256; i = i + 1) assert(ram.memory[i] == i);
  end
endmodule