`timescale 1ns / 1ps
`include "commands.vh"

module ALU_control(
    input wire rst_n,
    input wire [31:0] instr,
    input wire [1:0] ALUOp,
    output reg [3:0] decode
);

always @(*) begin
    if (rst_n) begin
        case (ALUOp)
            2'b10: begin // alu_op is 2, R-Type
                if(instr[31]) begin //func7 = 1
                    case (instr[14:12])// func3, decodes the instruction 
                        3'b000: decode = SUB;
                        3'b101: decode = SRA;
                        default: decode = ADD; // Default to ADD if not specified
                    endcase
                end
                else begin
                    case (instr[14:12])
                        3'b000: decode = ADD;
                        3'b001: decode = SLL;
                        3'b010: decode = SLT;
                        3'b011: decode = SLTU;
                        3'b100: decode = XOR;
                        3'b101: decode = SRL;
                        3'b110: decode = ORR;
                        3'b111: decode = AND;
                        default: decode = ADD;
                    endcase
                end    
            end
            2'b00: decode = ADD; // alu_op is 0, ld/str
            2'b01: begin // alu_op is 1, BEQ
                if (instr[14:12] == 3'b000) begin
                    decode = XOR;
                end
            end
        endcase
    end
end
endmodule
