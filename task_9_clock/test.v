`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_9_clock.v"

module top;

wire            rst;
wire            clk;
reg             mode;
reg             next;
reg             incr;
wire    [6:0]   hex2_sec;
wire    [6:0]   hex3_sec;
wire    [6:0]   hex4_min;
wire    [6:0]   hex5_min;
wire    [6:0]   hex6_hour;
wire    [6:0]   hex7_hour;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_9_clock task_9_clock
(
    .clk        (clk),
    .key0_rst   (~rst),
    .key1_mode  (~mode),
    .key2_next  (~next),
    .key3_incr  (~incr),
    .hex2_sec   (hex2_sec),
    .hex3_sec   (hex3_sec),
    .hex4_min   (hex4_min),
    .hex5_min   (hex5_min),
    .hex6_hour  (hex6_hour),
    .hex7_hour  (hex7_hour)
);

initial begin
    {mode, next, incr} <= 3'b000;
    #50;
    {mode, next, incr} <= 3'b100;
    #4;
    {mode, next, incr} <= 3'b000;
    #1500;
    {mode, next, incr} <= 3'b100;
    #4;
    {mode, next, incr} <= 3'b001;
    #4;
    {mode, next, incr} <= 3'b010;
    #4;
    {mode, next, incr} <= 3'b001;
    #4;
    {mode, next, incr} <= 3'b010;
    #4;
    {mode, next, incr} <= 3'b001;
    #4;
    {mode, next, incr} <= 3'b010;
    #4;
    {mode, next, incr} <= 3'b001;
    #4;
    {mode, next, incr} <= 3'b010;
    #4;
    {mode, next, incr} <= 3'b001;
    #4;
    {mode, next, incr} <= 3'b100;
    #500;
    $stop;
end

endmodule