`timescale 1ns / 1ps

module counter4bit(
    input clk,
    output reg [3:0] q
    );
    
initial begin
    q = 0;
end

always @ (posedge clk) begin
    q = q + 1;
end

endmodule
