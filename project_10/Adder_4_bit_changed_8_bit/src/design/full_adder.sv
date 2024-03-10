module full_adder(x,y,cin,s,cout);
    input x,y,cin;
    output s,cout;

    logic c,c1,s1;

    half_adder ha1(x,y,s1,c);
    half_adder ha2(cin,s1,s,c1);

    or(cout,c,c1);
endmodule
