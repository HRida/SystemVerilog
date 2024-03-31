module mat_mult #(
  parameter N_ROWS = 2,
  parameter N_COLUMNS = 2
) (
  input  logic clk,
  input  logic reset,
  input  logic enable_mult,
  input  int   mat1 [0 : N_ROWS-1] [0 : N_COLUMNS-1],
  input  int   mat2 [0 : N_ROWS-1] [0 : N_COLUMNS-1],
  output int   mat_out [0 : N_ROWS-1] [0 : N_COLUMNS-1],
  output logic mult_done
);
  
 logic mult_done_array [0 : N_ROWS-1] [0 : N_COLUMNS-1];
 // logic product_done; // deprecated
 // int product_counter; // deprecated

  // Instantiate dot_product module
  generate
    for (genvar i = 0; i < N_ROWS; i = i + 1) begin : row_loop
      for (genvar j = 0; j < N_COLUMNS; j = j + 1) begin : col_loop
        dot_product #(
          .N(N_ROWS)
          ) 
          dot_product (
          .clk(clk),
          .reset(reset),
          .enable_product(enable_mult),
          .inp1(mat1[i]),
          .inp2(mat2), // Pass the whole 2D array => usually the kth element should be passed here in a third loop but since we are using the generate loop we cannnot assign the kth element in it
          .column_index(j), // Pass the column index => which will help the dot_product module to select the kth element from the 2D array 
          .sum(mat_out[i][j]),
          .product_done(mult_done_array[i][j]) // since using one bit will result to multiple concurrent drivers error because of the generate loop
        );
      end
    end
  endgenerate  

  always_comb begin
    if (enable_mult) begin
      mult_done = 1'b1; // as if all the product_done are true then we can say that the multiplication is done properly
      for (int i = 0; i < N_ROWS; i = i + 1) begin
        for (int j = 0; j < N_COLUMNS; j = j + 1) begin
          mult_done = mult_done & mult_done_array[i][j]; // bit and'ing all the product_done signals
        end
      end
    end
  end

  // 1st idea to calulcate the mult_done signal using a counter (deprecated)
  // always_ff @(posedge clk)  begin
  //   if (reset) begin
  //     product_counter <= 0;
  //   end
  //   else begin
  //     if(product_done) begin
  //       product_counter <= product_counter + 1;
  //     end
  //     else begin
  //       product_counter <= product_counter;
  //     end
  //   end
  // end

  // 2nd idea to check on every product_done signal changed the product_counter increased (deprecated)
  // always @(product_done) begin
  //   product_counter <= product_counter + 1;
  // end  

  // always_comb 
  //   mult_done = product_counter == (N_ROWS*N_COLUMNS);   

endmodule : mat_mult
