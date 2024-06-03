`timescale 1ns / 1ps

module alu_input_mux(
    input wire rst_n,
    input wire [31:0] read_data2,
    input wire [31:0] immediate,
    input wire ALUSrc,
    output reg [31:0] opB
);


always @(*) begin
    if (rst_n) begin
        if (ALUSrc) begin
            opB = immediate;
        end 
        else begin
            opB = read_data2; 
        end
    end
end

endmodule
