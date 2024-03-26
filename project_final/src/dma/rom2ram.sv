module rom2ram #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 16,
  parameter INIT_FILE = "rom_file.mem",
  parameter DATA_AMOUNT = 16,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input  logic clk,
  input  logic reset,
  input  logic start,
  input  logic start_rom,
  input  logic start_dma,
  input  logic [DATA_AMOUNT-1:0] data_amt,
  output logic [DATA_WIDTH-1:0] matrix_data [DATA_AMOUNT-1:0],
  output logic done
);
  // local definitions  
  // logic [ADDR_WIDTH-1:0] starting_rom_addr;
  // logic [ADDR_WIDTH-1:0] starting_ram_addr;

  // number of elements to be transfered
  // logic [ADDR_WIDTH-1:0] num_elements;

  // start flags
  logic ram_wea;

  // rom inputs & outputs  
  logic [ADDR_WIDTH-1:0] rom_address; 
  logic [DATA_WIDTH-1:0] rom_data;

  // ram inputs & outputs
  logic [ADDR_WIDTH-1:0] ram_address;
  logic [DATA_WIDTH-1:0] ram_data;
  logic [ADDR_WIDTH-1:0] read_address;

  // matrix data to be read from RAM
  logic [DATA_WIDTH-1:0] element_data;
  // logic [DATA_WIDTH-1:0] matrix_data [DATA_AMOUNT-1:0];
  
  // ROM is given addresses and retreive back data of one address (one element) from the defined "INIT_FILE" 
  rom #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .INIT_FILE(INIT_FILE)
  ) rom_dut (
    .clk(clk), // input comes from TopModule
    .start_rom(start_rom), // input from TopModule
    .rom_addr(rom_address), // input comes from DMA
    .rom_data(rom_data) // output goes to DMA
  );

  // DMA is given rom data & retrieve back ram data & addresses 
  dma dma_dut (
    .clk         (clk), // input comes from TopModule
    .reset       (reset), // input comes from TopModule
    .start_dma   (start_dma), // input comes from DMATopModule
    .data_amt    (data_amt), // input comes from DMATopModule
    // .starting_rom(starting_rom_addr), // input comes from DMATopModule
    // .starting_ram(starting_ram_addr), // input comes from DMATopModule
    .rom_data    (rom_data), // input from ROM to DMA
    .rom_addr    (rom_address), // input from ROM to DMA
    .ram_addr    (ram_address), // output from DMA to RAM
    .ram_data    (ram_data), // output from DMA to RAM
    .done        (done), // output goes to Arbiter <<<<<<<<< maybe wrong?
    .ram_wea     (ram_wea) // output from DMA to RAM
  );

  simple_dualport_mem simple_dualport_mem (  
    .clk(clk), // input comes from Arbiter
    .addra(ram_address), // input from DMA
    .dina(ram_data), // input from DMA
    .wea(ram_wea), // input from DMA
    .addrb(read_address), // input from Arbiter 
    .doutb(element_data)
  );
  
  always_ff @(posedge clk) begin
    if (clk) begin
      if (reset) begin
        rom_address <= 0;
        for (int i=0; i < DATA_AMOUNT-1; i=i+1) matrix_data[i] <= 0; // reset matrix data 
      end else begin
        if (start) begin
          if (rom_address < DATA_AMOUNT) begin
            rom_address <= rom_address + 1;
            read_address <= read_address + 1;
            matrix_data[rom_address] <= element_data;
          end
        end else begin
          rom_address <= 0;
        end
      end
    end
  end  

endmodule : rom2ram