`timescale 1ns / 1ps

module cpu_assembly(
    input wire clk,        
    input wire rst_n
//    output wire [31:0] pc_out,
//    output wire [31:0] instr_out,
//    output wire [31:0] alu_result_out,
//    output wire [31:0] mem_read_data_out,
//    output wire [31:0] reg_data1_out,
//    output wire [31:0] reg_data2_out,
//    output wire mem_wr_out,
//    output wire mem_rd_out,
//    output wire reg_wr_out    
    );

// Define the signals
wire [4:0] read_reg1, read_reg2, write_reg;
wire [31:0] write_data, read_data1, read_data2, rdx;
wire [3:0] alu_op;
wire brnch, mem_rd, mem_to_rgs, mem_wr, alu_src, reg_wr;
wire [6:0] opcode;
wire [31:0] aluResult, mem_read_data, lsl;
wire branch_taken, aluZero;
wire [31:0] immediate;
wire [3:0] alu_decode;
reg step;
wire [31:0] read_addr, instr, pc_addr, branch_addr;
reg [31:0] pc_reg; // Internal register for pc
wire [31:0] pc; // Wire to use pc_reg as output
assign pc = pc_reg;

// Assign internal signals to output ports
//assign pc_out = pc;
//assign instr_out = instr;
//assign alu_result_out = aluResult;
//assign mem_read_data_out = mem_read_data;
//assign reg_data1_out = read_data1;
//assign reg_data2_out = read_data2;
//assign mem_wr_out = mem_wr;
//assign mem_rd_out = mem_rd;
//assign reg_wr_out = reg_wr;


control cont(.rst_n(rst_n), .opcode(opcode), .Branch(brnch), .MemRead(mem_rd), .MemtoReg(mem_to_rgs), .ALUOp(alu_op), .MemWrite(mem_wr), .ALUSrc(alu_src), .RegWrite(reg_wr));
data_mem dmem(.rst_n(rst_n), .clk(clk), .aluResult(aluResult), .mem_wr(mem_wr), .mem_rd(mem_rd), .read_data2(read_data2), .mem_read_data(mem_read_data));
instr_mem imem(.rst_n(rst_n), .read_addr(read_addr), .instr(instr), .read_reg1(read_reg1), .read_reg2(read_reg2), .write_reg(write_reg), .opcode(opcode));
ALU alublk(.rst_n(rst_n), .opA(read_data1), .opB(rdx), .decode(decode), .aluResult(aluResult), .aluZero(aluZero));
registers regis(.rst_n(rst_n), .clk(clk), .read_reg1(read_reg1), .read_reg2(read_reg2), .write_reg(write_reg), .write_data(write_data), .read_data1(read_data1), .read_data2(read_data2), .RegWrite(reg_wr));
pc_adder padr(.rst_n(rst_n), .step(step), .pc(pc), .pc_addr(pc_addr));
branch_adder badr(.rst_n(rst_n), .read_addr(read_addr), .lsl(lsl), .branch_addr(branch_addr));
pc_mux pcmx(.rst_n(rst_n), .pc_addr(pc_addr), .branch_addr(branch_addr), .branch_taken(branch_taken), .pc(pc));
alu_input_mux almx(.rst_n(rst_n), .read_data2(read_data2), .immediate(immediate), .ALUSrc(alu_src), .opB(rdx));
datawrite_mux dwmx(.rst_n(rst_n), .MemToReg(mem_to_rgs), .read_data(read_data), .ALUResult(ALUResult), .write_data(write_data));
ALU_control aluc(.rst_n(rst_n), .instr(instr), .ALUOp(alu_op), .decode(decode));
immgen imgn(.rst_n(rst_n), .instr(instr), .immediate(immediate));
pc pcblk(.rst_n(rst_n), .pc(pc), .read_addr(read_addr));
branch_taken tken(.rst_n(rst_n), .Branch(brnch), .alu_zero(aluZero), .branch_taken(branch_taken));
    
always @(posedge step) begin
    if (pc_reg  == 32'b0) begin
        pc_reg  <= pc_reg  + 1;
    end
end

always @(posedge clk) begin
    if (rst_n) begin
        step <= ~step;
    end 
    else begin
        step <= 0;
    end
end
endmodule
