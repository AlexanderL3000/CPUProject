`timescale 1ns / 1ps

module data_mem(
    input wire rst_n,
    input wire clk,
    input wire [6:0] aluResult, //7 bits to cover 128 possible entries.
    input wire mem_wr,
    input wire mem_rd,
    input wire [31:0] read_data2,
    output reg [31:0] mem_read_data //32-bit data width
    );

reg [31:0] data_ram [0:127];

initial begin
    $readmemb("sim_1/new/data.txt", data_ram);
end

always @(*) begin
    if (rst_n) begin
        if(mem_wr) begin
            data_ram[aluResult] <= read_data2;
        end
        else if (mem_rd) begin
            mem_read_data <= data_ram[aluResult];
        end           
    end
end

endmodule
