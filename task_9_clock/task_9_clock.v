`include "button.v"
`include "byte2sev_segm.v"
`include "counter.v"

`define FREQUENCY 50000000

module task_9_clock (
    input           clk,
    input           key0_rst,
    input           key1_mode,
    input           key2_next,
    input           key3_incr,
    output  [6:0]   hex2_sec,
    output  [6:0]   hex3_sec,
    output  [6:0]   hex4_min,
    output  [6:0]   hex5_min,
    output  [6:0]   hex6_hour,
    output  [6:0]   hex7_hour
);

wire rst = ~key0_rst;

wire    mode;
button button_mode
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_mode),
    .out_key    (mode)
);

wire    next;
button button_next
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key2_next),
    .out_key    (next)
);

wire    incr;
button button_incr
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key3_incr),
    .out_key    (incr)
);

wire       is_running;
wire [1:0] set_mode;

wire [$clog2(`FREQUENCY)-1:0] cycles;

wire [5:0] seconds;
wire [5:0] minutes;
wire [4:0] hours;

wire incr_sec = (is_running & (cycles == (`FREQUENCY - 1))) |
                (~is_running & (set_mode == 2'd0) & incr);

wire incr_min = (is_running & (cycles == (`FREQUENCY - 1)) & (seconds == 6'd59)) |
                (~is_running & (set_mode == 2'd1) & incr);

wire incr_hours = (is_running & (cycles == (`FREQUENCY - 1)) & (seconds == 6'd59) & (minutes == 6'd59)) |
                  (~is_running & (set_mode == 2'd2) & incr);

counter
#(
    .MODULUS    (2)
) counter_is_running
(
    .clk        (clk),
    .rst        (rst),
    .incr       (mode),
    .number     (is_running),
    .set_data   (),
    .data       ()
);

counter
#(
    .MODULUS    (3)
) counter_set_mode
(
    .clk        (clk),
    .rst        (rst),
    .incr       (~is_running & next),
    .number     (set_mode),
    .set_data   (),
    .data       ()
);

counter
#(
    .MODULUS    (`FREQUENCY)
) counter_cycles
(
    .clk        (clk),
    .rst        (rst),
    .incr       (is_running),
    .number     (cycles),
    .set_data   (),
    .data       ()
);

counter
#(
    .MODULUS    (60)
) counter_sec
(
    .clk        (clk),
    .rst        (rst),
    .incr       (incr_sec),
    .number     (seconds),
    .set_data   (),
    .data       ()
);

counter
#(
    .MODULUS    (60)
) counter_min
(
    .clk        (clk),
    .rst        (rst),
    .incr       (incr_min),
    .number     (minutes),
    .set_data   (),
    .data       ()
);

counter
#(
    .MODULUS    (24)
) counter_hours
(
    .clk        (clk),
    .rst        (rst),
    .incr       (incr_hours),
    .number     (hours),
    .set_data   (),
    .data       ()
);

byte2sev_segm
#(
    .NOTATION   (10)
) byte2sev_segm_secs
(
    .byte       ({2'd0, seconds}),
    .segm0      (hex2_sec),
    .segm1      (hex3_sec),
    .overflow   ()
);

byte2sev_segm
#(
    .NOTATION   (10)
) byte2sev_segm_mins
(
    .byte       ({2'd0, minutes}),
    .segm0      (hex4_min),
    .segm1      (hex5_min),
    .overflow   ()
);

byte2sev_segm
#(
    .NOTATION   (10)
) byte2sev_segm_hours
(
    .byte       ({3'd0, hours}),
    .segm0      (hex6_hour),
    .segm1      (hex7_hour),
    .overflow   ()
);

endmodule