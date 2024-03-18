module gate_full_adder (
  input a,
  b,
  cin,
  output sum,
  cout
);
  wire s1, net1, net2;

  xor (s1, a, b);
  and (net1, a, b);

  xor (sum, s1, cin);
  and (net2, s1, cin);

  xor (cout, net1, net2);
endmodule
