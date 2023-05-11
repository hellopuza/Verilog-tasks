`include "button.v"
`include "hex2sev_segm.v"

module task_1_count (
    input           clk,
    input           key0_rst,
    input           key1_inc_up,
    input           key2_inc_down,
    output  [6:0]   hex0
);

reg [3:0] num;
wire rst = ~key0_rst;

wire    inc_up;
button button_inc_up
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_inc_up),
    .out_key    (inc_up)
);

wire    inc_down;
button button_inc_down
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key2_inc_down),
    .out_key    (inc_down)
);

hex2sev_segm hex2sev_segm
(
    .hex    (num),
    .segm   (hex0)
);

always @(posedge clk)
    num <= rst ? 4'd0 :
           inc_up ? num + 1'd1 :
           inc_down ? num - 1'd1 :
           num;

endmodule