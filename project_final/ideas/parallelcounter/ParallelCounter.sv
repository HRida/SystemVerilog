module ParallelCounter #(parameter int limit = 10)
  (output logic [3:0] counter1, counter2);

  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      {counter1, counter2} <= 4'b0;
    else begin
      if (counter1 == limit)
        counter1 <= 4'b0;
      else
        counter1 <= counter1 + 1;

      if (counter2 == limit)
        counter2 <= 4'b0;
      else
        counter2 <= counter2 + 1;
    end
  end

endmodule
