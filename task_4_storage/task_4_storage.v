`include "button.v"
`include "hex2sev_segm.v"

module task_4_storage (
    input           clk,
    input           key0_rst,
    input           key1_record,
    input           key2_transfer,
    input           key3_copy,
    input   [7:0]   sw,
    input           sw8,
    output  [7:0]   ledr,
    output  [7:0]   ledg,
    output  [6:0]   hex0,
    output  [6:0]   hex1,
    output  [6:0]   hex2,
    output  [6:0]   hex3
);

reg [7:0]   rnum;
reg [7:0]   gnum;
assign ledr = rnum;
assign ledg = gnum;

wire rst = ~key0_rst;

wire    record;
button button_record
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_record),
    .out_key    (record)
);

wire    transfer;
button button_transfer
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key2_transfer),
    .out_key    (transfer)
);

wire    copy;
button button_copy
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key3_copy),
    .out_key    (copy)
);

hex2sev_segm hex2sev_segm0
(
    .hex    (gnum[3:0]),
    .segm   (hex0)
);

hex2sev_segm hex2sev_segm1
(
    .hex    (gnum[7:4]),
    .segm   (hex1)
);

hex2sev_segm hex2sev_segm2
(
    .hex    (rnum[3:0]),
    .segm   (hex2)
);

hex2sev_segm hex2sev_segm3
(
    .hex    (rnum[7:4]),
    .segm   (hex3)
);

always @(posedge clk)
begin
    rnum <= rst ? 8'h0 :
            record ? sw :
            transfer ? (rnum >> 1) | (sw8 << 7) :
            rnum;

    gnum <= rst ? 8'h0 :
            transfer ? {rnum[0], gnum[7:1]} :
            copy ? rnum :
            gnum;
end

endmodule