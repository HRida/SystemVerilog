module Bus #(
  parameter BUS_WIDTH = 16
) (
  input logic [BUS_WIDTH-1:0] busInput,
  output logic [BUS_WIDTH-1:0] busOutput
);
  // Output is assigned to the input for simplicity
  assign busOutput = busInput;

  // Additional logic or functionality related to the bus can be added here
endmodule
