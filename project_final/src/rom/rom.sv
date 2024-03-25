module rom #(
  parameter ROM_FILE = "rom_file.mem",
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 8,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input  logic clk,
  input  logic start_rom,
  input  logic [ADDR_WIDTH-1:0] rom_addr,
  output logic [DATA_WIDTH-1:0] rom_data
);

  logic [DATA_WIDTH-1:0] rom_d[DEPTH];

  initial $readmemh(ROM_FILE, rom_d);

  always_ff @(posedge clk) begin
    if (start_rom) begin
      rom_data <= rom_d[rom_addr];
    end else begin
      rom_data <= 0;
    end
  end

endmodule : rom