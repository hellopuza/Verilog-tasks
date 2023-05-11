`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_8_timer.v"

module top;

wire            rst;
wire            clk;
reg             start_stop;
reg             write;
reg             show;
wire    [6:0]   hex1_dsec;
wire    [6:0]   hex2_sec;
wire    [6:0]   hex3_sec;
wire    [6:0]   hex4_result;
wire    [6:0]   hex5_result;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_8_timer task_8_timer
(
    .clk                (clk),
    .key0_rst           (~rst),
    .key1_start_stop    (~start_stop),
    .key2_write         (~write),
    .key3_show          (~show),
    .hex1_dsec          (hex1_dsec),
    .hex2_sec           (hex2_sec),
    .hex3_sec           (hex3_sec),
    .hex4_result        (hex4_result),
    .hex5_result        (hex5_result)
);

initial begin
    {start_stop, write, show} <= 3'b000;
    #10;
    {start_stop, write, show} <= 3'b100;
    #80;
    {start_stop, write, show} <= 3'b000;
    #450;
    {start_stop, write, show} <= 3'b010;
    #80;
    {start_stop, write, show} <= 3'b000;
    #250;
    {start_stop, write, show} <= 3'b010;
    #80;
    {start_stop, write, show} <= 3'b000;
    #250;
    {start_stop, write, show} <= 3'b010;
    #80;
    {start_stop, write, show} <= 3'b000;
    #250;
    {start_stop, write, show} <= 3'b010;
    #80;
    {start_stop, write, show} <= 3'b000;
    #250;
    {start_stop, write, show} <= 3'b010;
    #80;
    {start_stop, write, show} <= 3'b000;
    #25;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b100;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b001;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b010;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    {start_stop, write, show} <= 3'b100;
    #80;
    {start_stop, write, show} <= 3'b000;
    #80;
    $stop;
end

endmodule