module tb;
  reg a, b, cin;
  wire sum, cout;

  my _adder #(ADDER_TYPE(0)) u0 (.a(a), .b(b), .cin(cin), .sum(sum), .cout (cout));

  initial
  begin
    a <= 0;
    b <= 0;
    cin <= 0;

    $monitor ("a-0x%0h b=0x%0h cin=0x%0h cout=0%0h sum=0x%0h" , a, b, cin, cout, sum);
    for (int i = 0; i < 5; i =  i + 1)
    begin
      #10 a <= $random;
      b <= $random;
      cin <= $random;
    end
  end
endmodule
