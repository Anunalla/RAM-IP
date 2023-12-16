`include "uvm_macros.svh"
`include "transaction.svh"
`include "ram_params.svh"
`include "interface.sv"
import uvm_pkg::*;

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard);
    
    uvm_analysis_imp #(transaction, scoreboard) recv_monitor;
    reg[`DATA_WIDTH-1:0] ramarray[`RAM_SIZE-1:0];

    function new(input string name="sb",uvm_component parent);
        super.new(name,parent);
        recv_monitor = new("recv_monitor",this);
    endfunction

    virtual function void write(transaction data);
        if(data.wr == 1'b1) begin
            ramarray[data.addr] = data.data_in;
            //`uvm_info("SB", $sformatf("WR= Addr:%0d, Data=%0d ",data.addr, data.data_in), UVM_NONE);
        end

        if(data.wr == 1'b0) begin
            if(data.data_out == ramarray[data.addr]) begin
              `uvm_info("SB",$sformatf("Test success: OP=RD @ Addr=%0d; Data Out=%0d; Data In =%0d, SB out=%0d",data.addr,data.data_out,data.data_in,ramarray[data.addr]),UVM_NONE);
            end
            else begin 
                `uvm_error("SB",$sformatf("Test Failure: OP=RD @ Addr=%0d; Data Out=%0d; Data In =%0d, SB Out=%0d",data.addr,data.data_out,data.data_in, ramarray[data.addr]));
            end
        end
    endfunction
endclass