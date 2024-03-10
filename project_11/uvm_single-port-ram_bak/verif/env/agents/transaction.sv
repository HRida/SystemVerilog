`include "uvm_macros.svh"
import uvm_pkg::*;
 
class transaction extends uvm_sequence_item;
  //use the keyword rand
  //for signals that should
  //be randomized
  rand bit wr;
  rand bit [3:0] addr;
  rand bit [7:0] din;
  bit [7:0] dout;

  //PORT A (write port)
  logic [15:0] dina,
  logic [5:0] addra,
  //PORT B (read port)
  logic [15:0] doutb,
  logic [5:0] addrb

  //constraint address cover all possible values
  constraint addr_c {addr > 0; addr < 16;};
  //constraint wr is 50% 1 and 50% 0
  constraint wr_c {wr dist {1:=50, 0:=50};};

    //register object within factory
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(wr,UVM_DEFAULT)
  `uvm_field_int(din,UVM_DEFAULT)
  `uvm_field_int(addr,UVM_DEFAULT)
  `uvm_field_int(dout,UVM_DEFAULT)
  `uvm_object_utils_end

  //custom function to display transaction fields
  virtual function string convert2str();
    return $sformatf("addr=0x%0h wr=0x%0h wdata=0x%0h rdata=0x%0h", addr, wr, din, dout);
  endfunction

  //transaction constructor
  function new(string name = "TRANS_ITEM");
    super.new(name);
  endfunction
endclass
