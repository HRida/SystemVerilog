module ROM #(parameter ROM_DEPTH = 1024)(
    input  logic             clk,
    input  logic             rst_n,
    input  logic      [7:0]  address,
    output logic      [7:0]  data
);

    // Define ROM data
    logic [7:0] rom_data [0:ROM_DEPTH-1];

    // Initialize ROM contents (example)
    initial begin
        for (int i = 0; i < ROM_DEPTH; i++) begin
            rom_data[i] = $random;
        end
    end

    // Read data from ROM based on address
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data <= 8'h00;
        end
        else begin
            data <= rom_data[address];
        end
    end

endmodule

module RAM #(parameter RAM_DEPTH = 1024)(
    input  logic             clk,
    input  logic             rst_n,
    input  logic      [7:0]  address,
    input  logic             write_en,
    input  logic      [7:0]  data_in,
    output logic      [7:0]  data_out
);

    // Define RAM data
    logic [7:0] ram_data [0:RAM_DEPTH-1];

    // Initialize RAM contents (example)
    initial begin
        for (int i = 0; i < RAM_DEPTH; i++) begin
            ram_data[i] = 8'h00;
        end
    end

    // Read and write data to RAM based on address and control signals
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'h00;
        end
        else if (write_en) begin
            ram_data[address] <= data_in;
        end
        else begin
            data_out <= ram_data[address];
        end
    end

endmodule

module DMA #(
    parameter DATA_WIDTH = 8, // Data width in bits
    parameter ADDR_WIDTH = 10 // Address width for ROM and RAM
)(
    input  logic             clk,
    input  logic             rst_n,
    input  logic      [ADDR_WIDTH-1:0]  rom_address,
    input  logic      [ADDR_WIDTH-1:0]  ram_address,
    input  logic      [ADDR_WIDTH-1:0]  transfer_length,
    output logic             done
);

    // Internal state
    typedef enum logic [1:0] {
        IDLE,
        TRANSFER
    } dma_state_t;
    dma_state_t state, next_state;

    // Internal counters
    logic [ADDR_WIDTH-1:0] rom_counter;
    logic [ADDR_WIDTH-1:0] ram_counter;

    // Signals for data transfer
    logic [DATA_WIDTH-1:0] data;

    // Default assignments
    assign done = (state == IDLE);

    // State machine
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            rom_counter <= 0;
            ram_counter <= 0;
        end
        else begin
            state <= next_state;
            rom_counter <= (state == TRANSFER) ? rom_counter + 1 : 0;
            ram_counter <= (state == TRANSFER) ? ram_counter + 1 : 0;
        end
    end

    // Combinational logic
    always_comb begin
        case (state)
            IDLE: begin
                next_state = (transfer_length > 0) ? TRANSFER : IDLE;
            end
            TRANSFER: begin
                next_state = (rom_counter == transfer_length - 1) ? IDLE : TRANSFER;
            end
            default: next_state = IDLE;
        endcase
    end

    // DMA data transfer
    ROM #(
        .ROM_DEPTH(1 << ADDR_WIDTH)
    ) rom_inst (
        .clk(clk),
        .rst_n(rst_n),
        .address(rom_address),
        .data(data)
    );

    RAM #(
        .RAM_DEPTH(1 << ADDR_WIDTH)
    ) ram_inst (
        .clk(clk),
        .rst_n(rst_n),
        .address(ram_address),
        .write_en(state == TRANSFER),
        .data_in(data),
        .data_out()
    );

    // Data transfer process
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data <= '0;
        end
        else if (state == TRANSFER) begin
            data <= data;
        end
        else begin
            data <= rom_inst.data;
        end
    end

endmodule

module testbench;
    // Parameters
    parameter ROM_DEPTH = 1024;
    parameter RAM_DEPTH = 1024;
    parameter TRANSFER_LENGTH = 16;

    // Signals
    logic clk, rst_n;
    logic [9:0] rom_address, ram_address, transfer_length;
    logic done;

    // Instantiate design under test (DUT)
    ROM #(ROM_DEPTH) rom_inst (
        .clk(clk),
        .rst_n(rst_n),
        .address(rom_address),
        .data()
    );

    RAM #(RAM_DEPTH) ram_inst (
        .clk(clk),
        .rst_n(rst_n),
        .address(ram_address),
        .write_en(),
        .data_in(),
        .data_out()
    );

    DMA #(8, 10) dma_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rom_address(rom_address),
        .ram_address(ram_address),
        .transfer_length(transfer_length),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        rst_n = 0;
        #10;
        rst_n = 1;
    end

    // Test process
    initial begin
        clk = 0;
        rom_address = 0;
        ram_address = 0;
        transfer_length = TRANSFER_LENGTH;

        #20; // Wait for some cycles

        // Check if DMA is done
        if (done) begin
            $display("DMA transfer completed successfully.");
        end
        else begin
            $display("DMA transfer failed.");
        end

        // Stop simulation
        $finish;
    end

endmodule
