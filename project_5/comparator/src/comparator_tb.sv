module comparator_tb;

  //local parameters
  localparam DATA_WIDTH = 4;

  // testbench signals
  logic [DATA_WIDTH-1:0] operand_a, operand_b;
  logic less, equal, greater;
  // Instantiate the BinaryComparator module
  comparator #(DATA_WIDTH) comparator_dut (.*);

  // Initial block to apply test values
  initial begin
    operand_a = $random;
    operand_b = $random;

    for (int i = 0; i < 20; i++) begin
      #10 operand_a = $random;
      operand_b = $random;
      #0;
      if (operand_a < operand_b)
        assert (less == 1 && greater == 0 && equal == 0);
        else if (operand_a == operand_b)
          assert (less == 0 && greater == 0 && equal == 1);
          else assert (less == 0 && greater == 1 && equal == 0);
    end

    // Stop the simulation
    #10 $stop;
  end

  // Display results in the simulation log
  always @(less, greater, equal) begin
    $display("operand_a = %0d, operand_b = %0d -> Equal: %b, \
 Greater: %b, Less: %b", operand_a, operand_b, equal,
             greater, less);
  end

endmodule
