`include "uvm_macros.svh"
`include "environment.sv"
`include "sequenceM.sv"
import uvm_pkg::*;

class test extends uvm_test;
    `uvm_component_utils(test);

    env e;
    sequenceRandom seqRandom;
  sequenceRead seqRd;
  sequenceWrite seqWr;
    function new(input string name="test",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e = env::type_id::create("env",this);
      seqRandom = sequenceRandom::type_id::create("seqRandom");
      seqRd = sequenceRead::type_id::create("seqRd");
      seqWr = sequenceWrite::type_id::create("seqWr");
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seqWr.start(e.a.seqr);
        #20;
        phase.drop_objection(this);
      phase.raise_objection(this);
        seqRandom.start(e.a.seqr);
        #20;
        phase.drop_objection(this);
    endtask
endclass