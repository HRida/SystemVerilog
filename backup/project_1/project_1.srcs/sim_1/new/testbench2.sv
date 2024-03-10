`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 10:59:17 AM
// Design Name: 
// Module Name: testbench2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench2( input Clock, Reset, Enable, Load, UpDn, 
                   input[7:0] Data, output reg[7:0] Q);
    
    always @(posedge Clock or posedge Reset)
        if (Rest)
            Q <= 0;
        else
            if (Enable)
                if (Load)
                    Q <= Data;
                else
                if (UpDn)
                    Q <= Q + 1;
                else
                    Q <= Q - 1;
endmodule
