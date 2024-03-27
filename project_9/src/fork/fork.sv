// 1st fork idea    
fork : check_done
    wait (done);
    #50 begin
        // Check if done is asserted
        if (!done)
            $display("Test failed");
        else 
            $display("Test passed");
    end
join

// 2nd fork idea
fork : check_done
    while(1) begin
        @(posedge done);  
        // Check if done is asserted
        if (!done)
            $display("done is 0");
        else 
            $display("done is 1");
    end
join

// 3rd fork idea
fork : check_q
    wait (q) fail = 1;
    #50 begin
        if (fail) 
        $display("fail");
        else
        $display("pass");
        disable check_q;
    end
join