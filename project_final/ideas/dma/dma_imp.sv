module DMA #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 4
) (
  input  logic clk,
  input  logic reset,
  input  logic start_dma,                     // flag to start a transfer
  input  logic [ADDR_WIDTH-1:0] data_amt,     // data amount to be transferred
  input  logic [ADDR_WIDTH-1:0] starting_rom, // base source pointer for the transfer
  input  logic [ADDR_WIDTH-1:0] starting_ram, // base destination pointer for the transfer
  input  logic [DATA_WIDTH-1:0] rom_data,     // data from ROM 
  output logic [ADDR_WIDTH-1:0] rom_addr,     // base source address for the transfer
  output logic [ADDR_WIDTH-1:0] ram_addr,     // base destination address for the transfer
  output logic [DATA_WIDTH-1:0] ram_data,     // data to be written to RAM  
  output logic done,                          // notify end of transfer
  output logic ram_wea,                       // write enable for RAM 
); 
  // logic [31:0] current_element;
  logic [ADDR_WIDTH-1:0] local_data_amount;
  // 
  assign rom_addr = local_rom_addr;
  assign ram_addr = local_ram_addr;
  logic started_lvl;
 
 always_ff @(posedge clk) begin
   if(reset) begin
    started_lvl <= 0;
   end
   else begin
    if(start)
     started_lvl <= 1; 
    else if (done)
     started_lvl <= 0;
   end
 end   

always_ff @(start) begin
   if(reset) begin
    started_lvl <= 0;
   end
   else begin
    local_rom_addr = 
   end
 end  

  always @(posedge clk) begin  // or posedge reset
    if (reset) begin 
      done <= 1'b0;
      // safer kel shi mano msafar
    end 
    else if (started_lvl) begin
      wea = 1'b1; 
      local_ram_addr = local_rom_addr + 1;
      local_rom_addr = local_rom_addr + 1;
      if (local_data_amount > 0) begin
        // Perform DMA transfer
        ram_addr[src_addr + current_element] <= rom_addr[dest_addr + current_element]; // RAM <= ROM
        current_element <= current_element + 1;
      end else begin
        done <= 1'b1;
      end
    end 
    else begin
      // safer kel shi mano msafar
      done <= 1'b0;
    end
  end
endmodule