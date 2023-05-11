`timescale 1ns/1ps

`include "clk.v"
`include "rst.v"
`include "counter.v"

module segment (
    input   [9:0]   pos,
    input   [9:0]   size,
    input   [7:0]   col,
    input   [9:0]   point_pos,

    output  [7:0]   out
);

wire inside = (pos <= point_pos) & (point_pos < pos + size);

assign out = inside ? col : 8'd0;

endmodule

module top;

wire       rst;
wire       clk;
wire [7:0] out;
wire [9:0] pos;

rst rst_m
(
    .rst    (rst)
);

clk clk_m
(
    .clk    (clk)
);

counter
#(
    .MODULUS    (1024)
) counter
(
    .clk        (clk),
    .rst        (rst),
    .incr       (1'd1),
    .number     (pos),
    .set_data   (),
    .data       ()
);

segment seg1
(
    .pos		(10'd100),
    .size		(10'd100),
    .col		(1),
    .point_pos	(pos),

    .out		(out)
);

segment seg2
(
    .pos		(10'd50),
    .size		(10'd100),
    .col		(2),
    .point_pos	(pos),

    .out		(out)
);

initial begin
    #4000;
    $stop;
end

endmodule