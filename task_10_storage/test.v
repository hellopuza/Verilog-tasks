`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_10_storage.v"

module top;

wire            rst;
wire            clk;
reg             write;
reg     [2:0]   sw_addr;
reg     [7:0]   sw_value;
wire    [7:0]   ledr_indic;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_10_storage task_10_storage
(
    .clk        (clk),
    .key0_rst   (~rst),
    .key1_write (~write),
    .sw_addr    (sw_addr),
    .sw_value   (sw_value),
    .ledr_indic (ledr_indic)
);

initial begin
    {write, sw_addr, sw_value} <= {1'b0, 3'd0, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b1, 3'd0, 8'd10};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd0, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b1, 3'd1, 8'd20};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd0, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b1, 3'd2, 8'd30};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd0, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b1, 3'd3, 8'd40};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd0, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b1, 3'd4, 8'd50};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd0, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd1, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd2, 8'd0};
    #4;
    {write, sw_addr, sw_value} <= {1'b0, 3'd3, 8'd0};
    $stop;
end

endmodule