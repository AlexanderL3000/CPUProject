`timescale 1ns / 1ps
`include "instr_types.vh"


module instr_mem(
    input wire rst_n,
    input wire [6:0] read_addr, //7 bits to cover 128 possible entries.
    output reg [31:0] instr,
    output reg [4:0] read_reg1,
    output reg [4:0] read_reg2,
    output reg [4:0] write_reg,
    output reg [6:0] opcode
    );
reg [31:0] inst_mem [0:127];
initial begin
       $readmemb("mc_code.txt", inst_mem);
end

always @(*) begin
    if (rst_n) begin
        instr = inst_mem[read_addr];   
        case (inst_mem[read_addr][7:0]) 
            RTYPE: begin
                    read_reg1 = inst_mem[read_addr][19:15];
                    read_reg2 = inst_mem[read_addr][24:20];
                    opcode = inst_mem[read_addr][6:0];
                    write_reg = inst_mem[read_addr][11:7];
            end
            ITYPE: begin
                    read_reg1 = inst_mem[read_addr][19:15];
                    opcode = inst_mem[read_addr][6:0];
                    write_reg = inst_mem[read_addr][11:7];
            end
            STYPE: begin
                    read_reg1 = inst_mem[read_addr][19:15];
                    read_reg2 = inst_mem[read_addr][24:20];
                    opcode = inst_mem[read_addr][6:0];
                    write_reg = inst_mem[read_addr][24:20];
            end
            BTYPE: begin
                    read_reg1 = inst_mem[read_addr][19:15];
                    read_reg2 = inst_mem[read_addr][24:20];
                    opcode = inst_mem[read_addr][6:0];
            end
            default: begin
                    read_reg1 = 5'b0;
                    read_reg2 = 5'b0;
                    write_reg = 5'b0;
                    opcode = 7'b0;
            end
        endcase
    end   
    else begin
        instr = 32'b0;
        read_reg1 = 5'b0;
        read_reg2 = 5'b0;
        write_reg = 5'b0;
        opcode = 7'b0;
    end
end
    
    
endmodule
