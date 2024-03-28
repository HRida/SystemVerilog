module rom #(
  parameter INIT_FILE = "rom_file.mem",
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 8,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input  logic clk,
  input  logic start_rom,
  input  logic [ADDR_WIDTH-1:0] rom_addr,
  output int rom_data   
);
  //[0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]  
  logic [DATA_WIDTH-1:0] rom_arr[DEPTH];

  initial $readmemh(INIT_FILE, rom_arr);

  always_ff @(posedge clk) begin
    if (start_rom) begin
       rom_data <= rom_arr[rom_addr];
    end else begin
      rom_data <= 0;
    end
  end

endmodule : rom