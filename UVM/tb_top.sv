// Code your testbench here
// or browse Examples
`include "test.sv"
`include "interface.sv"
`include "ram.sv"
`include "ram_params.svh"

module tb_top();

    ram_if #(`ADDR_WIDTH, `DATA_WIDTH) ramif();

    ram #(`ADDR_WIDTH, `DATA_WIDTH) dut(ramif.clk, ramif.wr, ramif.en,
    ramif.addr, ramif.datain, ramif.dataout);

    initial begin
        ramif.clk=0;
    end

    always #10 ramif.clk = ~ramif.clk;

    initial begin
      	$dumpfile("dump.vcd"); 
      	$dumpvars;
        uvm_config_db #(virtual ram_if)::set(null,"*","ramif",ramif);
        run_test("test");
    end

endmodule