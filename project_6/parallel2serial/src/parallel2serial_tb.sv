module parallel2serial_tb;
    // Parameters
    parameter DATA_WIDTH = 4;

    // Signals
    logic clk;
    logic reset;    
    logic [DATA_WIDTH-1:0] parin;
    logic load;
    logic completed;
    logic serout;

    // Instantiate Parallel2Serial module
    parallel2serial #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        .parin(parin),
        .load(load),
        .completed(completed),
        .serout(serout)
    ); 

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        clk = 0;
        reset = 1;
        load = 0;
        parin = 4'b0000;

        // Wait 10 clock cycles
        #10 reset = 0;

        // Load parallel input
        #5 load = 1;
        #5 load = 0;
        #5 parin = 4'b1001;

        // Wait for completion
        #50;
        $finish;
    end

    initial begin
        $dumpfile("parallel2serial_mux.vcd");
        $dumpvars(0, parallel2serial_tb);
    end
endmodule