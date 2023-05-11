`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_4_storage.v"

module top;

wire            rst;
wire            clk;
reg             record;
reg             transfer;
reg     [7:0]   sw;
reg             sw8;
wire    [7:0]   ledr;
wire    [7:0]   ledg;
wire    [6:0]   hex0;
wire    [6:0]   hex1;
wire    [6:0]   hex2;
wire    [6:0]   hex3;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_4_storage task_4_storage
(
    .clk            (clk),
    .key0_rst       (~rst),
    .key1_record    (~record),
    .key2_transfer  (~transfer),
    .sw             (sw),
    .sw8            (sw8),
    .ledr           (ledr),
    .ledg           (ledg),
    .hex0           (hex0),
    .hex1           (hex1),
    .hex2           (hex2),
    .hex3           (hex3)
);

initial begin
    {record, transfer, sw, sw8} <= {1'h0, 1'h0, 8'h0, 1'h0};
    #4;
    {record, transfer, sw, sw8} <= {1'h1, 1'h0, 8'h6, 1'h0};
    #4;
    {record, transfer, sw, sw8} <= {1'h0, 1'h0, 8'h0, 1'h0};
    #4;
    {record, transfer, sw, sw8} <= {1'h0, 1'h1, 8'h0, 1'h1};
    #4;
    {record, transfer, sw, sw8} <= {1'h0, 1'h0, 8'h0, 1'h0};
    #4;
    {record, transfer, sw, sw8} <= {1'h0, 1'h1, 8'h0, 1'h1};
    #4;
    {record, transfer, sw, sw8} <= {1'h0, 1'h0, 8'h0, 1'h0};
    #4;
    $stop;
end

endmodule