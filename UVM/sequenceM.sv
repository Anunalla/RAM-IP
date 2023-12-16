`ifndef SEQUENCEM_SVH
`define SEQUENCEM_SVH
`include "uvm_macros.svh"
`include "transaction.svh"
`include "ram_params.svh"
import uvm_pkg::*;

class sequenceRandom extends uvm_sequence#(transaction);
  `uvm_object_utils(sequenceRandom);
    transaction t;

  function new(input string name="seqr");
        super.new(name);
    endfunction

    virtual task body();
      for(int i=0; i<20; i++) begin
            t = transaction::type_id::create("TRANS");
            start_item(t);
        	t.en=1;
        	t.randomize();
        	
        `uvm_info("SEQRandom",$sformatf("Sending random request: #%0d; t.wr=%0d t.addr=%0d, t.data_in=%0d",i,t.wr,t.addr,t.data_in),UVM_NONE);
            finish_item(t);
        end
    endtask
endclass

class sequenceRead extends uvm_sequence#(transaction);
  `uvm_object_utils(sequenceRead);
    transaction t;

  function new(input string name="seqrd");
        super.new(name);
    endfunction

    virtual task body();
      for(int i=0; i<5; i++) begin
            t = transaction::type_id::create("TRANS");
            start_item(t);
        if(!t.randomize() with {t.wr==0;}) begin 
          `uvm_fatal("SEQRd", "Not able to create a random read sequence");
                     end
        t.en = 1;
                     `uvm_info("SEQRead",$sformatf("Sending a read request: #%0d; t.wr=%0d t.addr=%0d",i,t.wr,t.addr),UVM_NONE);
        finish_item(t);
        end
    endtask
endclass

class sequenceWrite extends uvm_sequence#(transaction);
  `uvm_object_utils(sequenceWrite);
    transaction t;

  function new(input string name="seqwr");
        super.new(name);
    endfunction

    virtual task body();
      for(int i=0; i<`RAM_SIZE; i++) begin
            t = transaction::type_id::create("TRANS");
            start_item(t);
//         if(!t.randomize() with {t.wr==1;}) begin 
//           `uvm_fatal("SEQWr", "Not able to create a random write sequence"); 
//                      end
        t.randomize();
        t.wr =1;
        t.addr = i;
          	t.en = 1;
                         `uvm_info("SEQWrite",$sformatf("Sending a write request: #%0d; t.wr=%0d t.addr=%0d, t.data_in=%0d",i,t.wr,t.addr,t.data_in),UVM_NONE);
            finish_item(t);
        end
    endtask
endclass
`endif