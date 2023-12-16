`include "uvm_macros.svh"
`include "transaction.svh"
`include "ram_params.svh"
`include "interface.sv"
import uvm_pkg::*;

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    uvm_analysis_port #(transaction) send_sb;
    virtual ram_if ramif;
    transaction t;

    function new(input string name="monitor", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        t = transaction::type_id::create("TRANS");
        send_sb = new("send_sb",this);
        if(!uvm_config_db#(virtual ram_if)::get(this,"","ramif",ramif))
            `uvm_error("Monitor","No interface found");
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge ramif.clk);
            t.wr = ramif.wr;
            t.en = ramif.en;
            t.addr = ramif.addr;
            t.data_in = ramif.datain;

            if(ramif.wr == 1'b0) begin
                @(posedge ramif.clk);
                t.data_out = ramif.dataout;
            end
            send_sb.write(t);
        end
    endtask
endclass