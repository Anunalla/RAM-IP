`include "uvm_macros.svh"
`include "agent.sv"
`include "scoreboard.sv"
import uvm_pkg::*;

class env extends uvm_env;
    `uvm_component_utils(env);

    agent a;
    scoreboard sb;

    function new(input string name="env", uvm_component parent=null);
        super.new(name,parent);
    endfunction   

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a = agent::type_id::create("a",this);
        sb = scoreboard::type_id::create("sb",this);
    endfunction 

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a.mon.send_sb.connect(sb.recv_monitor);
    endfunction
endclass