import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"
`include "ram_params.svh"
`include "interface.sv"


class driver extends uvm_driver #(transaction);
    `uvm_component_utils(driver)
    transaction t;
    virtual ram_if ramif;

    function new(input string name="driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        t = transaction::type_id::create("t");
      if(!uvm_config_db#(virtual ram_if)::get(this,"","ramif",ramif))
            `uvm_error("DRV","Unable to access interface");
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(t);
          	ramif.en <= t.en;
            ramif.wr <= t.wr;
            ramif.datain <= t.data_in;
            ramif.addr <= t.addr;
            seq_item_port.item_done();
            @(posedge ramif.clk);
            //if(t.wr == 1'b0)
                //@(posedge ramif.clk); // why is this? because RAM has 2 clock read cycle - really?
        end
    endtask
endclass