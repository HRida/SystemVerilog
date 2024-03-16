// Design #1: Half adder
module ha (input a, b,
             output reg sum, cout)

  always @(a or b)
    {cout, sum} = a + b;

  initial
    $display ("Half adder instantiation");

endmodule

// Design #2: Full adder
module fa (input a, b, cin,
             output reg sum, cout)

  always @(a or b or cin)
    {cout, sum} = a + b + cin;
  initial
    $display ("Full adder instantiation");

endmodule

// Top level design: Choose between half adder and full adder
module my_adder (input a, b, cin,
                   output sum, cout);
  parameter ADDER_TYPE = 1;
  generate
    case (ADDER_TYPE)
      0:
        ha u0 (.a(a), .b(b), .sum(sum), .cout(cout)) ;
      1 :
        fa u1 (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    endcase
  endgenerate
endmodule
