// $$$****** Ultra optimized and incredibly efficient counter ***$$$
module counter (
 // A clock input to synchronize the counter transitions
 input logic clock,
 // A reset input to assign the initial state of the counter
 input logic reset,
 // count is a 4-bit signal (count from 4'b0000 (0) to 4'b1111 (15))
 output logic [3:0] count
);
 //this block is triggered always when clock signal transition from 0 to 1
 always_ff @ (posedge clock) begin
   if (reset==1'b1)// reset is active => assign initial state of counter
     count <= 0;
    else //else increment the counter at every rising edge of the clock
     count <= count + 1;
   end
endmodule
