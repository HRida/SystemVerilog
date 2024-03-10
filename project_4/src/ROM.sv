module ROM #(
	parameter INIT_FILE = "rom_file.mem",
	parameter DATA_WIDTH = 8,
	parameter DEPTH = 8,
	localparam ADDR_WIDTH = $clog2(DEPTH)
	) (
	input logic clk,
	input logic  [ADDR_WIDTH-1:0] rd_addr,
	output logic [DATA_WIDTH-1:0] rd_data
	);

	logic [DATA_WIDTH-1:0] rom [DEPTH];

	initial 
		$readmemh(INIT_FILE, rom);

	always_ff @(posedge clk) 
		rd_data <= rom[rd_addr];

endmodule : ROM




