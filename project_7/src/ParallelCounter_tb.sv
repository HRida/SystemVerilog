module ParallelCounter_tb;

  logic clk;
  logic rst;
  logic [3:0] counter1, counter2;

  // Instantiate ParallelCounter module
  ParallelCounter #(8) dut (.clk(clk), .rst(rst), .counter1(counter1), .counter2(counter2));
    
  // Testbench logic
  initial begin
    // Initialization
    clk = 0;
    rst = 0;
    // Start clock generation process
    forever #5 clk =~ clk;
  end

   // Create threads for monitoring counters
  initial begin : monitor_counters  
      fork
      //your code goes here
      begin
        repeat (5) begin
          #10;
          $display("%0s Counter Value: %0d time: %t", "counter1", counter1, $time);
        end
      end
      begin
        repeat (5) begin
          #10;
          $display("%0s Counter Value: %0d time: %t", "counter2", counter2, $time);
        end
      end
      join

      // Run simulation for a duration
      #50;
      $finish;
  end

  // Thread to monitor and display counter values
  task automatic counter_monitor(string name, logic [3:0] counter);
    int i;
    $display("%0s monitoring:", name);
    repeat (20) begin
      #10;
      $display("%0s Counter Value: %0d", name, counter);
    end
  endtask

endmodule
