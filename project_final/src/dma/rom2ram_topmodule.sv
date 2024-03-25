module rom2ram_topmodule #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 16,
  parameter ROM_FILE = "rom_file.mem",
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input clk,
  input reset,
  input start,
  output done
);
  // cpu definitions  
  logic [ADDR_WIDTH-1:0] starting_rom_addr;
  logic [ADDR_WIDTH-1:0] starting_ram_addr;
  // number of elements to be read
  logic [ADDR_WIDTH-1:0] num_elements;

  // rom inputs & outputs  
  logic [ADDR_WIDTH-1:0] rom_address; 
  logic [ADDR_WIDTH-1:0] rom_data;

  // ram inputs & outputs
  logic [ADDR_WIDTH-1:0] ram_address_write;
  logic [ADDR_WIDTH-1:0] ram_address_read;
  logic [ADDR_WIDTH-1:0] ram_data;
  
  // ROM is given addresses and retreive back data of one address (one element) from the defined "ROM_FILE" 
  rom #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ROM_FILE(ROM_FILE)
  ) rom_dut (
    .clk(clk), // input comes from Arbiter
    .start_rom(start_rom), // input from DMATopModule
    .rom_addr(rom_address), // input comes from DMA
    .rom_data(rom_data) // output goes to DMA
  );

  // DMA is given rom data & retrieve back ram data & addresses 
  dma dma_dut (
    .clk         (clk), // input comes from Arbiter
    .reset       (reset), // input comes from Arbiter
    .start_dma   (start_dma), // input comes from DMATopModule
    .data_amt    (num_elements), // input comes from DMATopModule
    .starting_rom(starting_rom_addr), // input comes from DMATopModule
    .starting_ram(starting_ram_addr), // input comes from DMATopModule
    .rom_data    (rom_data), // input from ROM to DMA
    .rom_addr    (rom_address), // output from DMA to ROM
    .ram_addr    (ram_address), // output from DMA to RAM
    .ram_data    (ram_data), // output from DMA to RAM
    .done        (done), // output goes to Arbiter
    .ram_wea     (ram_wea) // output from DMA to RAM
  );

  simple_dualport_mem simple_dualport_mem (  
    .clk(clk),
    .addra(ram_address),
    .dina(ram_data),
    .wea(ram_wea),
    .addrb(),
    .doutb(matrix_data)
  );

  always_ff @(posedge clk) begin
    if (reset == 1)
    begin
      
    end
  end  

  initial begin
    rom_address = 0; // for loop

    // delayness waiting for rom to be ready
  end
endmodule : rom2ram_topmodule