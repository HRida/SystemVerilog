module ram(
    input logic clk,
    input logic wr, //write enable
    //PORT A (write port)
    input logic [15:0] dina,
    input logic [5:0] addra,
    //PORT B (read port)
    output logic [15:0] doutb,
    input logic [5:0] addrb
    );
     
    logic [15:0] mem [15:0];
    integer i = 0;
     
    initial begin
      for(i = 0; i < 16; i = i + 1) begin
        mem[i] = 0;
      end
    end
     
    always_ff @(posedge clk) begin
      if (wr) mem[addra] <= dina; //write operation (Port A)
    end
     
    always_ff @(posedge clk) begin
      doutb <= mem[addrb]; //read operation (Port B)
    end
endmodule
