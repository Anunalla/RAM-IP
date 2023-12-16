`ifndef INTERFACE_SV
`define INTERFACE_SV
interface ram_if 
#(parameter ADDR_WIDTH=3, parameter DATA_WIDTH=8);

logic clk;
logic wr;
logic en;
logic[ADDR_WIDTH-1:0] addr;
logic[DATA_WIDTH-1:0] datain;
logic[DATA_WIDTH-1:0] dataout;

endinterface
`endif