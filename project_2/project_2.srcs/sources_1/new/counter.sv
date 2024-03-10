module counter (
    input logic clk,
    clr,
    en,
    ld,
    input logic [7:0] data,
    output logic [7:0] count
);

always_ff @(posedge clk or posedge clr) begin
  if (clr) count <= 8'b0;
  else if (ld) count <= data;
  else if (en) count <= count + 1'd1;
end

endmodule: counter

module testbench;

  timeunit 1ns; timeprecision 100ps;
  
  bit clk; always #5 clk = !clk;
  
  bit clr, en, ld;
  logic [7:0] data = 8'd123, count;
  
  counter DUT_I(.*);
  
  initial 
  begin 
    #20 clr <= 1'b1;
    #10 clr <= 1'b0;
    @(posedge  clk);
    en <= 1'b1;
    repeat (10) @(posedge clk);
    ld <= 1'b1;
    @(posedge clk);
    ld <= 1'b0;
    repeat (10) @(posedge clk);
    en <= 1'b0;
    repeat (10) @(posedge clk);
    $finish;
  end

endmodule : testbench