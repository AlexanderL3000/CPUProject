`timescale 1ns / 1ps
`include "instr_types.vh"

module control(
    input wire rst_n,
    input wire [6:0] opcode,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

always @(*) begin
    if (rst_n) begin
        case (opcode)
            RTYPE: begin
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b10;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b1;
            end
            ITYPE: begin
                Branch = 1'b0;
                MemRead = 1'b1;
                MemtoReg = 1'b1;
                ALUOp = 2'b00;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            STYPE: begin
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'bx;
                ALUOp = 2'b00;
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                RegWrite = 1'b0;
            end
            BTYPE: begin
                Branch = 1'b1;
                MemRead = 1'b0;
                MemtoReg = 1'bx;
                ALUOp = 2'b01;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
        endcase
    end
end
endmodule
