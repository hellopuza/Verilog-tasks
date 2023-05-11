`include "button.v"
`include "hex2sev_segm.v"

module task_6_adder2 (
    input           clk,
    input           key0_rst,
    input           key1_add,
    input   [7:0]   sw1,
    input   [7:0]   sw2,
    output          ledg8,
    output  [6:0]   hex2,
    output  [6:0]   hex3,
    output  [6:0]   hex4,
    output  [6:0]   hex5,
    output  [6:0]   hex6,
    output  [6:0]   hex7
);

reg [8:0] sum;
assign ledg8 = sum[8];
wire rst = ~key0_rst;

wire    add;
button button_add
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_add),
    .out_key    (add)
);

hex2sev_segm hex2sev_segm2
(
    .hex    (sum[3:0]),
    .segm   (hex2)
);

hex2sev_segm hex2sev_segm3
(
    .hex    (sum[7:4]),
    .segm   (hex3)
);

hex2sev_segm hex2sev_segm4
(
    .hex    (sw1[3:0]),
    .segm   (hex4)
);

hex2sev_segm hex2sev_segm5
(
    .hex    (sw1[7:4]),
    .segm   (hex5)
);

hex2sev_segm hex2sev_segm6
(
    .hex    (sw2[3:0]),
    .segm   (hex6)
);

hex2sev_segm hex2sev_segm7
(
    .hex    (sw2[7:4]),
    .segm   (hex7)
);

always @(posedge clk)
begin
    sum <= rst ? 9'd0 :
           add ? sw1 + sw2 :
           sum;
end

endmodule