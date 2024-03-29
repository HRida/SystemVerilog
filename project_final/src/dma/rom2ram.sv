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
  output int   matrix_data [0:ADDR_WIDTH-1] [0:ADDR_WIDTH-1],
  output logic done
);
  // rom inputs & outputs  
  logic [ADDR_WIDTH-1:0] rom_address; 
  int rom_data;
  logic [ADDR_WIDTH-1:0] nxt_rom_address;

  // ram inputs & outputs
  logic [ADDR_WIDTH-1:0] ram_address;
  int ram_data;
  logic [ADDR_WIDTH-1:0] read_ram_address;
  logic [ADDR_WIDTH-1:0] nxt_read_ram_address;
  logic ram_wea;
  logic read_ram_available;
  logic ready_ram;

  // matrix data to be read from RAM
  int element_data; // logic [DATA_WIDTH-1:0] element_data;
  int i = 0, j = 0;
  // logic ready_ram_d1, ready_ram_d2; // for synchronization purpose
  
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
    .rom_data    (rom_data),    // input from ROM to DMA
    .rom_addr    (rom_address), // input from ROM to DMA
    .ram_addr    (ram_address), // output from DMA to RAM
    .ram_data    (ram_data),    // output from DMA to RAM
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
        read_ram_address <= 0;
        for (int i=0; i < ADDR_WIDTH-1; i=i+1) 
          for (int j=0; j < ADDR_WIDTH-1; j=j+1)
            matrix_data[i][j] <= 0; // reset matrix data 
      end else begin
        if (start) begin
          if (rom_address < DATA_AMOUNT) begin
            rom_address <= nxt_rom_address;
          end
          if (ready_ram) begin
            read_ram_address <= nxt_read_ram_address;
            matrix_data[i][j] = element_data;
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

  // always_comb begin
  //   if (ready_ram_d2)
  //     nxt_read_ram_address = read_ram_address + 1;
  //   else
  //     nxt_read_ram_address = read_ram_address;
  // end

  // [01 02 03 04] 
  // [05 06 07 08] 
  // [09 0A 0B 0C] 
  // [0D 0E 0F 00] 
  always @(read_ram_address) begin 
    if(ready_ram) begin
      if(i <= 3) begin
      j <= j + 1;
      end
      if(j >= 3) begin
        i <= i + 1;
        j <= 0;
      end
    end
  end

  // delay ready_ram by 2 cycles for synchronization
  // always_ff @(posedge clk) begin
  //   if (reset) begin
  //     ready_ram_d1 = 0;
  //     ready_ram_d2 = 0;
  //   end
  //   else begin
  //     ready_ram_d1 <= ready_ram;
  //     ready_ram_d2 <= ready_ram_d1;
  //   end
  // end

endmodule : rom2ram