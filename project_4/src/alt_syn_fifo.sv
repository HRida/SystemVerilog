module sync_fifo #(
	parameter DATA_WIDTH = 32, //parametrizable width of data
	parameter FIFO_DEPTH  = 16, //parameterizable depth of fifo ram
	localparam ADDR_WIDTH = $clog2(FIFO_DEPTH) //fifo address width 
        ) (
	input  logic clk,        //clock input signal
	input  logic reset,      //reset input signal
	//write port
	input  logic push,  //write enable to issue a write operation
	input  logic [DATA_WIDTH-1:0] wr_data, // input data to be written 
	// read port
	input  logic pop,  //read enable to issue a read operation
	output logic [DATA_WIDTH-1:0] rd_data, // the read output data
	// control flags
	output logic fifo_full,  //flag showing the fifo is full
	output logic fifo_empty  //flag showing the fifo is empty
	);

	logic [ADDR_WIDTH-1:0] wr_ptr; //write operation pointer 
	logic [ADDR_WIDTH-1:0] rd_ptr; //read operation pointer
	logic [ADDR_WIDTH-1:0] wr_ptr_nxt; //next state write pointer 
	logic [ADDR_WIDTH-1:0] rd_ptr_nxt; //next state read pointer
	
	//define a "RAM" signal to act as internal storage for the memory
	// logic [ADDR_WIDTH-1:0] ram [FIFO_DEPTH];
    alt_simple_dualport_mem # (
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH     (FIFO_DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) simple_dualport_mem (
        .clk  (clk              ),
        .addra(wr_ptr           ),
        .dina (wr_data          ),
        .wea  (~fifo_full &push ),
        .addrb(rd_ptr           ),
        .doutb(rd_data          )
    );

        //WRITE operation logic
	//----------------------
	always_comb
		wr_ptr_nxt = wr_ptr + 1;

	always_ff @(posedge clk) begin
		if (reset) begin
			wr_ptr <= 0;
		end else begin
			//here a write is requested while fifo is not full
			if (~fifo_full & push) begin
				// addra[wr_ptr] <= wr_data; // write input data
				wr_ptr <= wr_ptr_nxt; //increment wr pointer
			end
		end
	end

        //READ operation logic
	//----------------------
	always_comb 
		rd_ptr_nxt = rd_ptr + 1;

	always_ff @(posedge clk) begin
		if (reset) begin
			rd_ptr <= 0;
			rd_data <= {DATA_WIDTH{1'b0}}; 
		end else begin
			//here a read is requested while fifo is not empty
			if (~fifo_empty & pop) begin
				// rd_data <= ram[rd_ptr]; // read output data
				rd_ptr <= rd_ptr_nxt; //increment wr pointer
			end
		end
	end

	//control flags logic
	//----------------------
	always_comb 
		fifo_full = (wr_ptr_nxt  == rd_ptr );

	always_comb 
		fifo_empty = (rd_ptr == wr_ptr);

endmodule : sync_fifo
