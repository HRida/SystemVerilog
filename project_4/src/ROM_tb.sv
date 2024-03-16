module ROM_tb;
	//local parameters
	localparam DATA_WIDTH = 8;
	localparam DEPTH = 16;
	localparam ADDR_WIDTH = $clog2(DEPTH);
	localparam INIT_FILE = "rom_init.mem";

	//testbench signals to be connected to DUT
	logic clk;
        logic [ADDR_WIDTH-1:0] rd_addr;
        logic [DATA_WIDTH-1:0] rd_data;

	//Instantiate the DUT
	ROM #(.DATA_WIDTH(DATA_WIDTH),
	      .DEPTH(DEPTH), 
		  .INIT_FILE(INIT_FILE)) DUT (.*);

	//Generate the clock input to the DUT
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	//Generate the stimulus
	initial begin
		//init signals
		rd_addr = 0;
		#10;
		for (int i=0; i < DEPTH; i++) begin
			rd_addr = i;
			#10;
			assert (rd_data == i) else
				$fatal (1, "Something went \
		wrong at time %0t ! Expected = %0h, Got %0h",
			       	$time, i, rd_data);
		end

		//finish the simulation
		#10 $finish;
	end

endmodule

	
