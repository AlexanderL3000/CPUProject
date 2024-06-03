`timescale 1ns / 1ps


module branch_adder(
    input wire rst_n,
    input wire [31:0] read_addr, //address from pc
    input wire [31:0] lsl, // immgen instruction shifted left by 2
    output reg [31:0] branch_addr
    );
    
always @(*) begin
    if (rst_n) begin
        branch_addr = read_addr + lsl;
    end
    else begin
        branch_addr = 32'b0;
    
    end
end
endmodule
