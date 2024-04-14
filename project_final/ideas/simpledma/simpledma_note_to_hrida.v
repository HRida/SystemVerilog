Here's an updated version of the SimpleDMAC module that reads data from a ROM (Read-Only Memory) and writes it to a RAM (Random-Access Memory):

Verilog
module SimpleDMAC (
  // Clock and Reset signals
  input clk,
  input reset,

  // Memory Interface signals
  input  logic         rom_ready,
  output logic        rom_valid,
  output logic [31:0]  rom_addr,
  input  logic [31:0]  rom_rdata,

  input  logic         ram_ready,
  output logic        ram_valid,
  output logic [31:0]  ram_addr,
  output logic [31:0]  ram_wdata,

  // CPU Control signals
  input  logic         cpu_config_valid,
  input  logic [31:0]  cpu_source_addr (/* ROM address */),
  input  logic [31:0]  cpu_dest_addr (/* RAM address */),
  input  logic [31:0]  cpu_byte_count,
  output logic         cpu_config_ready,

  // Interrupt signal to CPU
  output logic         interrupt
);

  // Internal registers
  reg  logic         config_valid;
  reg  [31:0]       source_addr;
  reg  [31:0]       dest_addr;
  reg  [31:0]       byte_count;
  reg  [31:0]       current_addr;
  reg  logic         state;
  reg  logic         mem_valid_reg;

  // Parameters (assuming 32-bit data transfers)
  parameter IDLE = 1'b0;
  parameter TRANSFER = 1'b1;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      config_valid <= 1'b0;
      source_addr <= 32'h0;
      dest_addr <= 32'h0;
      byte_count <= 32'h0;
      current_addr <= 32'h0;
      state <= IDLE;
      mem_valid_reg <= 1'b0;
      interrupt <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          config_valid <= cpu_config_valid;
          source_addr <= cpu_source_addr;
          dest_addr <= cpu_dest_addr;
          byte_count <= cpu_byte_count;
          current_addr <= source_addr;
          state <= (config_valid) ? TRANSFER : IDLE;
          cpu_config_ready <= config_valid;
        end
        TRANSFER: begin
          if (rom_ready) begin  // Read from ROM
            rom_valid <= 1'b1;
            rom_addr <= current_addr;
            mem_valid_reg <= 1'b0;  // No write to ROM in this case
          end else if (ram_ready) begin  // Write to RAM
            ram_valid <= 1'b1;
            ram_addr <= dest_addr;
            ram_wdata <= rom_rdata;  // Data received from ROM
            current_addr <= current_addr + 4; // Assuming 32-bit transfers
            byte_count <= byte_count - 4;
          end
          if (byte_count == 0) begin
            state <= IDLE;
            interrupt <= 1'b1;
          end
        end
      endcase
    end
  end

  assign rom_valid = mem_valid_reg & state == TRANSFER;
  assign ram_valid = mem_valid_reg & state == TRANSFER;

endmodule
Use code with caution.
Changes made:

Separate rom_ready and ram_ready signals for each memory interface.
rom_valid and ram_valid are controlled by mem_valid_reg to avoid simultaneous read/write conflicts.
During the TRANSFER state:
 The controller first reads from the ROM when rom_ready is high.
 Once data is received from the ROM, it writes that data to the RAM when ram_ready is high.
The mem_valid_reg is used to ensure data is only sent to one memory at a time.
Note:

This is still a simplified example and may require further modifications depending on the specific memory interfaces.
