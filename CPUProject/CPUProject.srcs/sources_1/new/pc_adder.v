`timescale 1ns / 1ps

module pc_adder(
    input wire rst_n,
    input wire step,
    input wire [31:0] pc,
    output reg [31:0] pc_addr
    );

always @(posedge step or negedge rst_n) begin
    if (!rst_n) begin
        pc_addr <= 32'b0; //reset to 0
    end
    else begin
        pc_addr <= pc + 4; //add 4 on posedge of step
    end
end
endmodule
