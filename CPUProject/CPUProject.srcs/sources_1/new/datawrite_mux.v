`timescale 1ns / 1ps

module datawrite_mux(
    input wire rst_n,
    input wire MemToReg,
    input wire [31:0] read_data,
    input wire [31:0] ALUResult,
    output reg [31:0] write_data
);

always @(*) begin
    if(rst_n) begin
        if(MemToReg) begin
            write_data = read_data;
        end
        else begin
            write_data = ALUResult;
        end
    end
end
endmodule
