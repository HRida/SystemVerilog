`ifndef SEQUENCER
`define SEQUENCER

class sequencer extends uvm_sequencer#(transaction);

  `uvm_component_utils(sequencer)

  ///////////////////////////////////////////////////////////////////////////////
  //constructor
  ///////////////////////////////////////////////////////////////////////////////
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

endclass

`endif

