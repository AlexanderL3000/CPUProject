`timescale 1ns / 1ps


module branch_taken(
    input wire rst_n,
    input wire Branch,
    input wire alu_zero,
    output reg branch_taken
);

always @(*) begin
    if (rst_n) begin
        branch_taken = (alu_zero && Branch);
    end 
       
end
endmodule
