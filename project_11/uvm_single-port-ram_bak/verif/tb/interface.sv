`ifndef INTERFACE
`define INTERFACE

interface ram_if();
    logic clk;
    logic wr;
    //PORT A (write port)
    logic [15:0] dina,
    logic [5:0] addra,
    //PORT B (read port)
    logic [15:0] doutb,
    logic [5:0] addrb
endinterface

`endif

