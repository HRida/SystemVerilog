module adder_8_bit(x,y,cin,sum,cout);
    input [7:0] x,y;
    input cin;
    output[7:0] sum;
    output cout;

    logic c1,c2,c3,c4,c5,c6,c7;

    full_adder fa1(x[0],y[0],cin,sum[0],c1);
    full_adder fa2(x[1],y[1],c1,sum[1],c2);
    full_adder fa3(x[2],y[2],c2,sum[2],c3);
    full_adder fa4(x[3],y[3],c3,sum[3],c4);
    full_adder fa5(x[4],y[4],c4,sum[4],c5);
    full_adder fa6(x[5],y[5],c5,sum[5],c6);
    full_adder fa7(x[6],y[6],c6,sum[6],c7);
    full_adder fa8(x[7],y[7],c7,sum[7],cout);
endmodule

