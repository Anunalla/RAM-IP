`ifndef TRANSACTION_SVH
`define TRANSACTION_SVH
`include "uvm_macros.svh"
`include "ram_params.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)
    rand bit wr;
    rand bit[`ADDR_WIDTH-1:0] addr;
    rand bit[`DATA_WIDTH-1:0] data_in;
    bit [`DATA_WIDTH-1:0] data_out;
    bit en;

  constraint addr_C {addr < `RAM_SIZE ; } ;

    function new(input string name = "transaction");
        super.new(name);
    endfunction
endclass

`endif