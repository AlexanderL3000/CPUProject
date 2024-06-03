`timescale 1ns / 1ps

module registers(
    input wire rst_n,
    input wire clk,
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2,
    input wire RegWrite
);

reg [31:0] registers [31:0]; // Array of 32 registers

always @* begin
    if (rst_n) begin
        read_data1 = (read_reg1 == 0) ? 32'd0 : registers[read_reg1];
        read_data2 = (read_reg2 == 0) ? 32'd0 : registers[read_reg2];
    end
end

always @(posedge clk) begin
    if(rst_n) begin
        if (RegWrite && write_reg != 0) begin
            registers[write_reg] <= write_data;
        end
    end
end

endmodule
