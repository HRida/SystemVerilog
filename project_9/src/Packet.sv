// To verify that the adder adds, we also need to check that it 
// does not add when rstn is 0, and hence rstn should also be 
// randomized along with a and b.
class Packet;
  rand bit 		rstn;
  rand bit[7:0] a;
  rand bit[7:0] b;
  bit [7:0] 	sum;
  bit 			carry;
  
  // Print contents of the data packet
  function void print(string tag="");
    $display ("T=%0t %s a=0x%0h b=0x%0h sum=0x%0h carry=0x%0h", $time, tag, a, b, sum, carry);
  endfunction
  
  // This is a utility function to allow copying contents in 
  // one Packet variable to another.
  function void copy(Packet tmp);
	  //your code here
  endfunction


endclass
