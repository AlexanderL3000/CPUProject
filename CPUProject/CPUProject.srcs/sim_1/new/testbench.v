`timescale 1ns / 1ps

module testbench;
    reg clk = 0;
    wire [3:0] q;
    counter4bit C4_0 (clk, q);
    initial begin
        clk = 1;
        #5;
        forever begin
            #5 clk = ~clk;
        end
    end
    always @(posedge clk) begin
        $display ($time, " clk = %b, q = %b", clk, q);
    end

endmodule
