module top_module #(
  parameter INIT_FILE = "rom_file.mem",
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 8,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input  logic clk,
  input  logic reset,
  input  logic top_start,
  output logic top_done
);
    logic rom2ram_done, mult_done, fifo_done;
    logic start_rom, start_dma, start_rom2ram;
    logic enable_mult, enable_fifo;
    int matrix_data [0:ADDR_WIDTH-1] [0:ADDR_WIDTH-1];
    int mat_out [0:ADDR_WIDTH-1] [0:ADDR_WIDTH-1];

    // Instantiate the amazing arbiter
    arbiter arbiter_dut(
     .clk  (clk),
     .reset(reset),
     .r0   (r0),
     .r1   (r1),
     .r2   (r2),
     .g0   (g0),
     .g1   (g1),
     .g2   (g2)
    );

    // Instantiate ROM2RAM module
    rom2ram #(
     .DATA_WIDTH(DATA_WIDTH),
     .DEPTH(DEPTH),
     .INIT_FILE(INIT_FILE),
     .DATA_AMOUNT(DATA_AMOUNT)
    ) rom2ram_dut (
     .clk(clk),
     .reset(reset),
     .start(start_rom2ram),
     .start_rom(start_rom),
     .start_dma(start_dma),
     .matrix_data(matrix_data),
     .done(rom2ram_done)
    );

    // Instantiate mat_mult module
    mat_mult #(
     .N_ROWS(DATA_WIDTH), 
     .N_COLUMNS(DATA_WIDTH) 
    ) mat_mult_dut (
     .clk(clk),
     .reset(reset),
     .enable_mult(enable_mult),
     .mat1(matrix_data),
     .mat2(matrix_data),
     .mult_done(mult_done),
     .mat_out(mat_out)
    );

    // Instantiate fifo_transfer module
    fifo_transfer #(
     .N_ROWS(DATA_WIDTH), 
     .N_COLUMNS(DATA_WIDTH) 
    ) mat_mult_dut (
     .clk(clk),
     .reset(reset),
     .enable(enable_fifo),
     .mat_out_in(mat_out),
     .fifo_done(fifo_done)
    );

    // TODO: Write back the matrix data to the file

    always_ff @(posedge clk) begin
        if (reset) begin
          r0 <= 0;
          r1 <= 0;
          r2 <= 0;
        end 
        else begin
            if(top_start) begin
              r0 <= 1;
              r1 <= 0;
              r2 <= 0;
            end 
            if(rom2ram_done) begin
              r0 <= 0;
              r1 <= 1;
              r2 <= 0;
            end
            if(mult_done) begin
              r0 <= 0;
              r1 <= 0;
              r2 <= 1;
            end
            if(fifo_done) begin
              r0 <= 0;
              r1 <= 0;
              r2 <= 0;
              top_done <= 1;
            end
        end
    end

    always_comb begin
        if (g0) begin
            $display("Arbiter granted ROM2RAM access");
            start_rom <= 1;
            start_dma <= 1;
            start_rom2ram <= 1;
        end
        if (g1) begin
            $display("Arbiter granted DOT_PRODUCT access");
            enable_mult <= 1;
        end
        if (g2) begin
            $display("Arbiter granted FIFO_TRANSFER access");
            enable_fifo <= 1;
        end
    end

endmodule : rom