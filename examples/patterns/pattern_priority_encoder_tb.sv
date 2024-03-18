module tb_4tol_mux;
  reg [7:0] a;
  reg [7:0] b;
  reg [7:0] c;
  reg [7:0] d;
  wire [7:0] out;
  reg [1:0] sel;
  integer i;

  pattern_detector pr_en (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .sel(sel),
    .out(out)
  );

  initial begin
    sel <= 0;
    a <= $random;
    b <= $random;
    c <= $random;
    d <= $random;

    for (i = 1; i < 4; i = i + 1) begin
      #5 sel <= i;
    end

    #5 $finish;
  end
endmodule
