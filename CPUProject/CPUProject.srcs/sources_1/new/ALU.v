`timescale 1ns / 1ps
`include "commands.vh"

module ALU(
    input wire rst_n,
    input wire [31:0] opA,
    input wire [31:0] opB,
    input wire [3:0] decode,
    output reg [31:0] aluResult,
    output reg aluZero
);

always @(*) begin
    if (rst_n) begin
        case (decode)
            ADD: aluResult = opA + opB;
            SLL: aluResult = opA << opB;
            SLT: aluResult = $signed(opA) < $signed(opB);
            SLTU: aluResult = opA < opB;
            XOR: aluResult = opA ^ opB;
            SRL: aluResult = opA >>> opB;
            ORR: aluResult = opA | opB;
            AND: aluResult = opA & opB;
            
            SUB: aluResult = opA - opB;
            SRA: aluResult = opA >> opB;
           
            default: aluResult = 32'b0; // Default output
            
        endcase
        
        if (aluResult == 32'b0) begin
            aluZero = 1'b1;
        end
        else begin
            aluZero = 1'b0;
        end
    end
end
endmodule
