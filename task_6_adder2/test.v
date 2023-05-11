`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_6_adder2.v"

module top;

wire            rst;
wire            clk;
reg             add;
reg     [7:0]   sw1;
reg     [7:0]   sw2;
wire            ledg8;
wire    [6:0]   hex2;
wire    [6:0]   hex3;
wire    [6:0]   hex4;
wire    [6:0]   hex5;
wire    [6:0]   hex6;
wire    [6:0]   hex7;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_6_adder2 task_6_adder2
(
    .clk        (clk),
    .key0_rst   (~rst),
    .key1_add   (~add),
    .sw1        (sw1),
    .sw2        (sw2),
    .ledg8      (ledg8),
    .hex2       (hex2),
    .hex3       (hex3),
    .hex4       (hex4),
    .hex5       (hex5),
    .hex6       (hex6),
    .hex7       (hex7)
);

initial begin
    {add, sw1, sw2} <= {1'h0, 8'h0, 8'h0};
    #4;
    {add, sw1, sw2} <= {1'h1, 8'h4, 8'h3};
    #4;
    {add, sw1, sw2} <= {1'h0, 8'h0, 8'h0};
    #4;
    {add, sw1, sw2} <= {1'h1, 8'hF4, 8'hF3};
    #4;
    $stop;
end

endmodule