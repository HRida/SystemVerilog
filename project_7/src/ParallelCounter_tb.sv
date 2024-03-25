module ParallelCounter_tb;

  logic clk;
  logic rst;
  logic [3:0] counter1 = 4'b00, counter2 = 4'b00;

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
        repeat (20) counter_monitor("counter1", counter1);
      end
      begin
        repeat (20) counter_monitor("counter2", counter2);
      end
      join

      // repeat (20) counter_monitor("counter1", counter1);

      /** join_any is used to wait for any one of the threads to finish
      fork
      //your code goes here
      begin
        counter_monitor("counter1", counter1);
      end
      join_any

      fork
      begin
        counter_monitor("counter2", counter2);
      end
      join_any
      **/

      /*** Alternative way to create threads using
      fork
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
      **/

      // Run simulation for a duration
      #50;
      $finish;
  end

  // Thread to monitor and display counter values
  task automatic counter_monitor(string name, logic [3:0] counter);
    $display("%0s monitoring:", name);
    begin
      #10;
      $display("%0s Counter Value: %0d time: %t", name, counter, $time);
    end
  endtask

  initial begin
    $dumpfile("ParallelCounter_tb.vcd");
    $dumpvars(0, ParallelCounter_tb);
  end

endmodule
