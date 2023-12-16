`timescale 1ps/1ps
module unittb();
    logic clk, wr, en;
    logic[2:0] addr;
    logic[7:0] write;
    logic[7:0] read;

    ram #(3,8) dut(clk,wr,en,addr,write,read);

    always #1 clk = ~clk;
    
    initial begin
        #0 clk=1; 
        #2 en=1; wr=1; addr=0; write=2;
        #2 addr =1; write=addr;
        #2 addr =2; write=addr;
        #2 addr =3; write=addr;
        #2 addr =5; write=addr;
        #2 wr=0;
        addr=0;
        #2 addr=1;
        #2 $stop();

    end
endmodule