`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_7_translation.v"

module top;

wire            rst;
wire            clk;
reg             set;
reg     [7:0]   sw;
wire            ledg8;
wire    [7:0]   ledr;
wire    [6:0]   hex4;
wire    [6:0]   hex5;
wire    [6:0]   dec6;
wire    [6:0]   dec7;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_7_translation task_7_translation
(
    .clk        (clk),
    .key0_rst   (~rst),
    .key1_set   (~set),
    .sw         (sw),
    .ledg8      (ledg8),
    .ledr       (ledr),
    .hex4       (hex4),
    .hex5       (hex5),
    .dec6       (dec6),
    .dec7       (dec7)
);

initial begin
    {set, sw} <= {1'h0, 8'd0};
    #4;
    {set, sw} <= {1'h1, 8'd5};
    #4;
    {set, sw} <= {1'h0, 8'd0};
    #4;
    {set, sw} <= {1'h1, 8'd154};
    #4;
    {set, sw} <= {1'h1, 8'd254};
    #4;
    $stop;
end

endmodule