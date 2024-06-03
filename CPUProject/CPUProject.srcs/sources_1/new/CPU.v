`timescale 1ns / 1ps


module CPU(
    input [7:0] in,
    output reg [7:0] ACC_OUT, IR_OUT, DR_OUT, PC_OUT, AR_OUT,
    input clk,
    input ACC_LOAD, IR_LOAD, DR_LOAD, PC_LOAD, AR_LOAD,
    input inc,
    input rst
); 

PCRegister ACC(
    .in(in), 
    .out(ACC_OUT), 
    .clk(clk), 
    .load(ACC_LOAD),
    .rst(rst)   
);
PCRegister IR(
    .in(in), 
    .out(IR_OUT), 
    .clk(clk), 
    .load(IR_LOAD),
    .rst(rst)  
);
PCRegister DR(
    .in(in), 
    .out(DR_OUT), 
    .clk(clk), 
    .load(DR_LOAD),
    .rst(rst)  
);
PCRegister PC(
    .in(in), 
    .out(PC_OUT), 
    .clk(clk), 
    .load(PC_LOAD),
    .inc(inc),
    .rst(rst)  
);
PCRegister AR(
    .in(in), 
    .out(AR_OUT), 
    .clk(clk), 
    .load(AR_LOAD),
    .rst(rst)  
);

endmodule
