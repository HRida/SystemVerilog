task sum_1(input [7:0] a, b, output [7:0] c);
  begin
    c = a + b;
  end
endtask

// or

task sum_2;
  input [7:0] a, b;
  output [7:0] c;
  begin
    c = a + b;
  end
endtask

initial begin
  reg [7:0] x, y, z;
  sum_1(x, y, z);
end
