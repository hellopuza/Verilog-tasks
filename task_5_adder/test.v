`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_5_adder.v"

module top;

wire            rst;
wire            clk;
reg             add;
reg     [7:0]   sw1;
reg     [7:0]   sw2;
wire    [7:0]   ledr1;
wire    [7:0]   ledr2;
wire    [7:0]   ledg;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_5_adder task_5_adder
(
    .clk        (clk),
    .key0_rst   (~rst),
    .key1_add   (~add),
    .sw1        (sw1),
    .sw2        (sw2),
    .ledr1      (ledr1),
    .ledr2      (ledr2),
    .ledg       (ledg)
);

initial begin
    {add, sw1, sw2} <= {1'h0, 8'h0, 8'h0};
    #4;
    {add, sw1, sw2} <= {1'h1, 8'h4, 8'h3};
    #4;
    {add, sw1, sw2} <= {1'h0, 8'h0, 8'h0};
    #4;
    {add, sw1, sw2} <= {1'h1, 8'h14, 8'h13};
    #4;
    $stop;
end

endmodule