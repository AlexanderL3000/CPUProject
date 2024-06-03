`timescale 1ns / 1ps


module pc_mux(
    input wire rst_n,
    input wire [31:0] pc_addr,
    input wire [31:0] branch_addr,
    input wire branch_taken,
    output reg [31:0] pc

);

always @(*) begin
    if (rst_n) begin //rst_n is active low
        if (branch_taken) begin
            pc = branch_addr;
        end
        else begin
            pc = pc_addr;
        end   
    end  
          
end
endmodule
