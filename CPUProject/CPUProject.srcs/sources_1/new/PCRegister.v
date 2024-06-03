`timescale 1ns / 1ps


module PCRegister(
    input [7:0] in,
    output reg [7:0] out,
    input clk,
    input load,
    input inc,
    input rst
    );
    
always @ (posedge clk or negedge rst)
if (!rst) begin
    out <= 8'b0;
end else if (inc) begin
    out <= out + 1;
end else if (load) begin
    out <= in;
end    
endmodule
