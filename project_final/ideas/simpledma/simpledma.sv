module SimpleDMAC (
  // Clock and Reset signals
  input clk,
  input reset,

  // Memory Interface signals
  input  logic         rom_busy,
  output logic [31:0]  rom_addr,
  input  logic [31:0]  rom_rdata,

  input  logic         ram_busy,
  output logic [31:0]  ram_addr,
  output logic [31:0]  ram_wdata,

  // Configuration Interface
  logic               config_valid;
  logic [31:0]        source_addr;
  logic [31:0]        dest_addr;
  logic [31:0]        byte_count;

  // Done signal
  output logic         done;
);

  // Internal registers
  logic               config_active;
  logic [31:0]        source_addr_reg;
  logic [31:0]        dest_addr_reg;
  logic [31:0]        byte_count_reg;
  logic [31:0]        current_addr;
  logic               state;

  // Parameters (assuming 32-bit data transfers)
  parameter IDLE = 1'b0;
  parameter TRANSFER = 1'b1;

  // Always block with posedge clk or posedge reset
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      config_active <= 1'b0;
      source_addr_reg <= 32'h0;
      dest_addr_reg <= 32'h0;
      byte_count_reg <= 32'h0;
      current_addr <= 32'h0;
      state <= IDLE;
      done <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          // Capture configuration on positive edge of config_valid
          config_active <= config_valid;
          source_addr_reg <= source_addr;
          dest_addr_reg <= dest_addr;
          byte_count_reg <= byte_count;
          current_addr <= source_addr_reg;
          state <= (config_active & byte_count_reg > 0) ? TRANSFER : IDLE;
        end
        TRANSFER: begin
          // Busy wait for ROM access
          while (rom_busy) begin
            // stall the clock (not recommended for real designs)
          end
          rom_addr <= current_addr;
          // Read data from ROM (assumed to be available after busy wait)
          ram_addr <= dest_addr_reg;
          ram_wdata <= rom_rdata;
          current_addr <= current_addr + 4; // Assuming 32-bit transfers
          byte_count_reg <= byte_count_reg - 4;

          // Busy wait for RAM access
          while (ram_busy) begin
            // stall the clock (not recommended for real designs)
          end

          if (byte_count_reg == 0) begin
            state <= IDLE;
            done <= 1'b1;  // Set done signal upon transfer completion
          end
        end
      endcase
    end
  end

endmodule
