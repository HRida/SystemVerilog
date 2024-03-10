`timescale 1ns / 1ps // ps ns us ms s
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 10:58:14 AM
// Design Name: 
// Module Name: testbench
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


module testbench;

// Instantiate the d_flip_flop module
d_ff mostafa (
     .d(), 
     .clk(), 
     .q(), 
     .q_bar()
);

// logic CLK = 1;
// always #5ns CLK = !CLK;

logic A, B; // logics created (wire)
logic Z; // "Z ist A UND B"
// AB = 0 0

reg[7:0] Y; // register created

always_comb Z = A & B;

initial begin
    { A, B } = 2'b00;
    #1 // 1 Clock cycle later
    { A, B } = 2'b10;
    #1
    { A, B } = 2'b01;
    #1
    { A, B } = 2'b11;
    #1 $stop;
    // #100ns $stop;
end  

endmodule
