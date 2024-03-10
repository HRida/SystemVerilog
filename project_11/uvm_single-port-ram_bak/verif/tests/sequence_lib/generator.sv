`ifndef GENERATOR 
`define GENERATOR 

class generator extends uvm_sequence#(transaction);
     //register object in the factory
    `uvm_object_utils(generator)

    //used to index transactions
    integer i;

    //constructor
    function new(string name = "GENSEQ");
      super.new(name);
    endfunction

    //task that generates transactions (sequence items)
    virtual task body();
      //loop to create `NO_OF_TRANSACTIONS transactions
      for(i =0; i< `NO_OF_TRANSACTIONS; i++) begin
        //create a single transaction item
        transaction t = transaction::type_id::create("TRANS");
        start_item(t);
        t.randomize(); //randomize transaction fields
        `uvm_info(get_full_name(), "Generated Data sent to Driver", UVM_LOW);
        t.print(); //print transaction fields
        finish_item(t);
      end
      `uvm_info("GENSEQ", $sformatf("Generation of %0d items completed",`NO_OF_TRANSACTIONS), UVM_LOW);
    endtask
endclass
`endif

