module ram #(parameter ADDR_WIDTH=3, parameter DATA_WIDTH=8) (
    input reg clk, wr, en, 
    input reg[ADDR_WIDTH-1:0] addr,
    input reg[DATA_WIDTH-1:0] datain,
    output reg[DATA_WIDTH-1:0] dataout
);
    localparam RAMSIZE = $pow(2, ADDR_WIDTH);
    reg[DATA_WIDTH-1:0] ram_array[RAMSIZE-1:0];

    always @(posedge clk) begin
        if(en) begin
            if(wr) ram_array[addr] <= datain;
            else dataout <= ram_array[addr];
        end
    end
endmodule