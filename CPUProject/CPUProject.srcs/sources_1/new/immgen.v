`timescale 1ns / 1ps
`include "instr_types.vh"

module immgen(
    input wire rst_n,
    input wire [31:0] instr,
    output reg [31:0] immediate
);
reg [6:0] opcode;
reg [19:0] pad;

always @* begin
    if (rst_n) begin
        opcode = instr[6:0];
        case (opcode)
            ITYPE: begin
                immediate = instr[31:20];
            end
            STYPE: begin
                immediate[11:5] = instr[31:25];
                immediate[4:0] = instr[11:7];
            end
            BTYPE: begin
                immediate[12] = instr[31];
                immediate[10:5] = instr[30:25];
                immediate[4:1] = instr[11:8];
                immediate[11] = instr[7];
                immediate[0] = 1'b0;
            end
        endcase
    
        if (instr[31] == 1'b0) begin
            pad = 20'b0;
            immediate[31:12] = pad;
        end else begin
            pad = 20'b1;
            immediate[31:12] = pad;
        end
    end
    
end
endmodule
