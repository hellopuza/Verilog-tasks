`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "task_1_count.v"

module top;

wire            rst;
wire            clk;
reg             inc_up;
reg             inc_down;
wire    [6:0]   out;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

task_1_count task_1_count
(
    .clk            (clk),
    .key0_rst       (~rst),
    .key1_inc_up    (inc_up),
    .key2_inc_down  (inc_down),
    .hex0           (out)
);

initial begin
    inc_up = 1'h1;
    inc_down = 1'h1;
    #4;
    inc_up = 1'h0;
    #4;
    inc_up = 1'h1;
    #4;
    inc_up = 1'h0;
    #4;
    inc_up = 1'h1;
    #4;
    inc_down = 1'h0;
    #4;
    inc_down = 1'h1;
    #4;
    #4;
    $stop;
end

endmodule