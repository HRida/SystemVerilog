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
  // rom inputs & outputs  
  logic [ADDR_WIDTH-1:0] rom_address; 
  logic [DATA_WIDTH-1:0] rom_data;
  logic [ADDR_WIDTH-1:0] nxt_rom_address;

  // ram inputs & outputs
  logic [ADDR_WIDTH-1:0] ram_address;
  logic [DATA_WIDTH-1:0] ram_data;
  logic [ADDR_WIDTH-1:0] read_ram_address;
  logic [ADDR_WIDTH-1:0] nxt_read_ram_address;
  logic ram_wea;
  logic read_ram_available;
  logic ready_ram;

  // matrix data to be read from RAM
  logic [DATA_WIDTH-1:0] element_data;
  
  // ROM is given addresses and retreive back data of one address (one element) from the defined "INIT_FILE" 
  rom #(
    .DATA_WIDTH (DATA_WIDTH),
    .DEPTH      (DEPTH),
    .INIT_FILE  (INIT_FILE)
  ) rom_dut (
    .clk        (clk),         // input comes from TopModule
    .start_rom  (start_rom),   // input from TopModule
    .rom_addr   (rom_address), // input comes from DMA
    .rom_data   (rom_data)     // output goes to DMA
  );

  // DMA is given rom data & retrieve back ram data & addresses 
  dma #(
    .DATA_WIDTH  (DATA_WIDTH),
    .DEPTH       (DEPTH),
    .DATA_AMOUNT (DATA_AMOUNT)
  ) dma_dut (
    .clk         (clk),         // input comes from rom2ram
    .reset       (reset),       // input comes from rom2ram
    .start_dma   (start_dma),   // input comes from rom2ram
    .data_amt    (data_amt),    // input comes from rom2ram
    .rom_data    (rom_data),    // input from ROM to DMA
    .rom_addr    (rom_address), // input from ROM to DMA
    .ram_addr    (ram_address), // output from DMA to RAM
    .ram_data    (ram_data),    // output from DMA to RAM
    // .done     (done),        // output goes to Arbiter <<<<<<<<< maybe wrong?
    .ram_wea     (ram_wea)      // output from DMA to RAM
  );

  simple_dualport_mem #(
    .DATA_WIDTH           (DATA_WIDTH),
    .DEPTH                (DEPTH),
    .DATA_AMOUNT          (DATA_AMOUNT)
  ) simple_dualport_mem (  
    .clk                  (clk),               // input comes from Arbiter
    .addra                (ram_address),       // input from DMA
    .dina                 (ram_data),          // input from DMA
    .wea                  (ram_wea),           // input from DMA
    .addrb                (read_ram_address),  // input from rom2ram 
    .doutb                (element_data),
    .read_ram_available   (read_ram_available) // output goes to rom2ram
  );
  
  always_ff @(posedge clk) begin
    if (clk) begin
      if (reset) begin
        rom_address <= 0;
        for (int i=0; i < DATA_AMOUNT-1; i=i+1) matrix_data[i] <= 0; // reset matrix data 
      end else begin
        if (start) begin
          if (rom_address < DATA_AMOUNT) begin
            rom_address <= nxt_rom_address;
          end
          if (ready_ram) begin
            read_ram_address <= nxt_read_ram_address;
            matrix_data[read_ram_address] <= element_data;
          end
          if (read_ram_address == (DATA_AMOUNT-1)) begin
            done <= 1;
          end
        end else begin
          rom_address <= 0;
          read_ram_address <= 0;
        end
      end
    end
  end  

  always_comb 
    nxt_rom_address = rom_address + 1;
  
  always_comb begin
    if (read_ram_available)
      ready_ram = 1;
  end

  always_comb 
    nxt_read_ram_address = read_ram_address + 1;

endmodule : rom2ram