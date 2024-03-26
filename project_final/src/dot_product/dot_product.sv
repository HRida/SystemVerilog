 module dot_product #(
  parameter N = 2,
  parameter DW = 8
) (
  input logic clk,
  input logic reset,
  input logic enable,
  input int inp1[0:1],
  input int inp2[0:1],
  output int sum
);  
    
    int temp_sum = 0;
    
    always_ff @(posedge clk)
    begin
        if(reset == 1)
            temp_sum = 0;
        else if (enable == 1)
        begin
            temp_sum = 0;
            for (int i = 0; i < N; i = i + 1) begin : sum_loop // $size(inp1)
                temp_sum = temp_sum  + inp1[i] * inp2[i];
            end 
        end else begin
            temp_sum = 0;
        end 
           
        sum <= temp_sum;
    end

// assign sum = temp_sum;
    
endmodule : dot_product
