`timescale 1ns/1ps

module clk (
    output  reg clk
);

initial clk = 1'h0;
always  #1 clk = ~clk;

endmodule