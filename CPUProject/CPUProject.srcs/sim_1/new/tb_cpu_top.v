`timescale 1ns / 1ps

module tb_cpu_top();

// Declare signals
wire clk;
reg clk_out;
reg rst_n;  // Active-low reset signal

// Instantiate the clock generator module
clock clkin (
    .clk(clk),
    .clkout(clk_out)
);

// Instantiate the CPU top module
cpu_assembly cputp (
    .clk(clk_out),
    .rst_n(rst_n)
);

// Testbench stimulus
initial begin
    // Initialize signals
    rst_n = 1;

    // Apply reset
    rst_n = 0;
    #10;  // Wait for one clock cycle
    rst_n = 1;

    // Run the simulation for a certain period
    #1400;  // Run simulation for 1400 time units

    // Finish the simulation
    $stop;
end

endmodule
