`include "button.v"
`include "byte2sev_segm.v"

module task_7_translation (
    input           clk,
    input           key0_rst,
    input           key1_set,
    input   [7:0]   sw,
    output          ledg8,
    output  [7:0]   ledr,
    output  [6:0]   hex4,
    output  [6:0]   hex5,
    output  [6:0]   dec6,
    output  [6:0]   dec7
);

reg [7:0]   num;
assign ledr = sw;
wire rst = ~key0_rst;

wire    set;
button button_set
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_set),
    .out_key    (set)
);

byte2sev_segm
#(
    .NOTATION   (16)
) byte2sev_segm_hex
(
    .byte       (num),
    .segm0      (hex4),
    .segm1      (hex5),
    .overflow   ()
);

byte2sev_segm
#(
    .NOTATION   (10)
) byte2sev_segm_dec
(
    .byte       (num),
    .segm0      (dec6),
    .segm1      (dec7),
    .overflow   (ledg8)
);

always @(posedge clk)
begin
    num <= rst ? 8'h0 :
           set ? sw :
           num;
end

endmodule