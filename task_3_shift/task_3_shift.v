`include "button.v"

`define NUM_W 8

module task_3_shift (
    input                   clk,
    input                   key0_rst,
    input                   key1_rshift,
    input                   key2_lshift,
    input                   sw1_rshift,
    input                   sw0_lshift,
    output  [`NUM_W-1:0]    ledr
);

reg [`NUM_W-1:0]    num;
assign ledr = num;

wire rst = ~key0_rst;

wire    rshift;
button button_rshift
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_rshift),
    .out_key    (rshift)
);

wire    lshift;
button button_lshift
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key2_lshift),
    .out_key    (lshift)
);

always @(posedge clk)
    num <= rst ? {`NUM_W{1'h0}} :
           rshift ? (num >> 1) | (sw1_rshift << (`NUM_W - 1)) :
           lshift ? (num << 1) | sw0_lshift :
           num;

endmodule