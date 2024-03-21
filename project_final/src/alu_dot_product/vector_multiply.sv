module vector_multiply #(N = 4) (
    input clk,
    input reset,
    input array of signed(N-1:0) [7:0] a,
    input array of signed(N-1:0) [7:0] b,
    output enable_out,
    output array of signed(N-1:0) [15:0] f
);

  logic signed [15:0] out, mul1, mul2, f;
  
  f = dual_mac_out; 

  always_ff @(posedge clk) begin
    if (reset == 1) begin
      dual_mac_out <= 0;
    end
  end

  always_ff @(posedge clk) begin
    for (int i=0; i < N; ++i) begin
      mul[i] = a[i] * b[i];
    end
    // for (int i=0; i < N/2; ++i) begin
    //    temp_accumalate = mul[2*i] + mul[2*i+1];
    // end
    // for (int i=0; i < N/4; ++i) begin
    //    dual_mac_out = temp_accumalate[2*i] + temp_accumalate[2*i+1];
    // end
    f = mul;
    enable = 1;
  end

endmodule
