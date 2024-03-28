// `timescale 1 ns / 1 ps
`define NUM_ELEMS 5
`define DATA_WIDTH 2

module mat_mult_tb();
  parameter N_ROWS = 3;
  parameter N_COLUMNS = 2;

  logic clk = 1'b1;
  logic reset = 1'b0;
  logic enable_mult = 1'b0;
  logic mult_done = 1'b0; 
  int mat1 [0 : N_ROWS-1] [0 : N_COLUMNS-1];
  int mat2 [0 : N_ROWS-1] [0 : N_COLUMNS-1];
  int mat_out [0 : N_ROWS-1] [0 : N_COLUMNS-1];

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    //array initialization
    mat1 = '{'{1, 2}, '{3, 4}, '{5, 6}};
    mat2 = '{'{1, 2}, '{3, 4}, '{0, 0}};
    // vec1 = '{1, 2};
    // vec2 = '{1, 2};
    
    //displaying array elements 
    $display("-------displaying 2d array-------");
    foreach(mat1[i,j]) $display("\t mat1[%0d][%0d] = %0d",i,j,mat1[i][j]);
    foreach(mat2[i,j]) $display("\t mat2[%0d][%0d] = %0d",i,j,mat2[i][j]);
  end

  // Instantiate mat_mult module
  mat_mult #(
    .N_ROWS(N_ROWS), 
    .N_COLUMNS(N_COLUMNS)
    ) mat_mult_dut (
    .clk(clk),
    .reset(reset),
    .enable_mult(enable_mult),
    .mat1(mat1),
    .mat2(mat2),
    .mat_out(mat_out),
    .mult_done(mult_done)
  );

  initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    enable_mult = 0;
    #10;
    // Apply reset
    reset = 0;
    // Enable operation
    enable_mult = 1;
    
    // other way to test 
    // for (int i = 0; i < N; i = i + 1) begin
    //  for (int j = 0; j < N; j = j + 1) begin
    //     mat1[i][j] = i * N + j;
    //     mat2[i][j] = i * N + j;
    //  end
    // end

    // #10 reset = 0;
    // #10 reset = 1;
    // #10 reset = 0;

    // #10 enable = 1;

    // Wait for operation to complete
    #100ns;

    // Check results
    for (int i = 0; i < N_ROWS; i = i + 1) begin
      for (int j = 0; j < N_COLUMNS; j = j + 1) begin
        $display("mat_out[%0d][%0d] = %0d", i, j, mat_out[i][j]);
      end
    end
    
    #100ns; $finish;
  end
endmodule