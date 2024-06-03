`timescale 1ns / 1ps

module pc(
    input wire rst_n,
    input wire [31:0] pc,
    output reg [31:0] read_addr
    );
    
always @(*) begin
    if (rst_n) begin
        read_addr = pc;
    end
    else begin
        read_addr = 32'b0;
    end
end
endmodule
