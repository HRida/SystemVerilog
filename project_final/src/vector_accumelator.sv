module vector_accumelator #(N = 4) (
    input clk,
    input reset,
    input array of signed(N-1:0) [7:0] a,
    input enable,
    output logic signed [15:0] f
  );

  logic signed [15:0] out, mul1, mul2, f;

  always_ff @(posedge clk)
  begin
    if (reset == 1)
    begin
      f <= 0;
      enable <= 0;
    end
    else if (enable == 1)
    begin
      for (int i=0; i < N-1; ++i)
      begin
        acc_out = acc_out + a[i];
      end
    end
    f <= acc_out;
  end

endmodule
