 module dot_product #(
  parameter N = 2
) (
  input  logic clk,
  input  logic reset,
  input  logic enable_product,
  input  int   inp1 [0:N-1],
  input  int   inp2 [0:N-1] [0 : N-1],
  input  int   column_index,
  output int   sum, 
  output logic product_done
);  
    
    int temp_sum = 0;
    
    always_ff @(posedge clk)
    begin
        if(reset) begin
            temp_sum <= 0;
            product_done <= 0;
        end
        else if (enable_product)
        begin
            temp_sum = 0;
            for (int i = 0; i < N; i = i + 1) begin : sum_loop // $size(inp1)
                temp_sum = temp_sum  + inp1[i] *  inp2[i][column_index];
            end 
            product_done <= 1;
        end 
        else begin
            temp_sum <= 0;
            product_done <= 0;
        end 
           
        sum <= temp_sum;
    end

    // assign sum = temp_sum;
    
endmodule : dot_product
