`include "button.v"
`include "decoder.v"

module task_2_count_column (
    input           clk,
    input           key0_rst,
    input           key1_inc_up,
    input           key2_inc_down,
    output  [7:0]   ledr
);

reg [2:0]   num;
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

decoder
#(
    .NUM_W  (3),
    .VEC_W  (8)
) decoder
(
    .num    (num),
    .vec    (ledr)
);

always @(posedge clk)
    num <= rst ? 3'd0 :
           inc_up ? num + 1'd1 :
           inc_down ? num - 1'd1 :
           num;

endmodule