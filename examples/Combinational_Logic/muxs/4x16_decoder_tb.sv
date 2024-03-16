
module tb;
  reg en;
  reg [3:0] in;
  wire [15:0] out;
  integer i;

  dec_3x8 ul (.en(en), .in(in), .out(out));

  initial
  begin
    en <= 0;
    in <= 0;
    Smonitor ("en=%0b in=0x%0h out=0x%0h", en, in, out);
    for (i = 0; i < 32; i = i + 1)
    begin
      {en, in} = i;
      #10;
    end
  end
endmodule
