`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_3_shift.v"

module top;

wire            rst;
wire            clk;
reg             k_rshift;
reg             k_lshift;
reg             s_rshift;
reg             s_lshift;
wire    [7:0]   out;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_3_shift task_3_shift
(
    .clk            (clk),
    .key0_rst       (~rst),
    .key1_rshift    (~k_rshift),
    .key2_lshift    (~k_lshift),
    .sw1_rshift     (s_rshift),
    .sw0_lshift     (s_lshift),
    .ledr           (out)
);

initial begin
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0000;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b1010;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0000;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b1010;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0000;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0101;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0000;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0101;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0000;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0101;
    #4;
    {k_rshift, k_lshift, s_rshift, s_lshift} <= 4'b0000;
    #4;
    $stop;
end

endmodule