`timescale 1ns / 1ps

module clock(
    input wire clk,
    output reg clk_out
);

always @(posedge clk) begin
    #10;
    clk_out <= ~clk_out; 
end

endmodule
