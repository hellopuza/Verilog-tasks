`include "button.v"
`include "byte2sev_segm.v"
`include "counter.v"

`define FREQUENCY 50000000
`define MAX_RES_NUM 4

module task_8_timer (
    input           clk,
    input           key0_rst,
    input           key1_start_stop,
    input           key2_write,
    input           key3_show,
    output  [6:0]   hex1_dsec,
    output  [6:0]   hex2_sec,
    output  [6:0]   hex3_sec,
    output  [6:0]   hex4_result,
    output  [6:0]   hex5_result
);

wire rst = ~key0_rst;

wire    start_stop;
button button_start_stop
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_start_stop),
    .out_key    (start_stop)
);

wire    write;
button button_write
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key2_write),
    .out_key    (write)
);

wire    show;
button button_show
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key3_show),
    .out_key    (show)
);

localparam max_cycles = `FREQUENCY / 10;
wire [$clog2(max_cycles)-1:0] cycles;

wire       is_running;
wire [3:0] dseconds;
wire [6:0] seconds;

wire incr_dsec = (is_running & (cycles == (max_cycles - 1)));
wire incr_sec  = (is_running & (cycles == (max_cycles - 1)) & (dseconds == 4'd9));

localparam nbits = $clog2(`MAX_RES_NUM + 1);

reg [3:0] memory_dsec[`MAX_RES_NUM-1:0];
reg [6:0] memory_sec [`MAX_RES_NUM-1:0];

wire [nbits-1:0] show_res_num;
wire [nbits-1:0] recorded_res_num;

wire incr_show_res_num = (~is_running & show);
wire set_show_res_num  = (~is_running & write);

wire incr_recorded_res_num = (is_running & write & (recorded_res_num != `MAX_RES_NUM));
wire set_recorded_res_num  = (~is_running & write);

wire [nbits-1:0] show_res_num_data = {nbits{1'd0}};
wire [nbits-1:0] recorded_res_num_data = {nbits{1'd0}};

wire [3:0] displayed_dsec = (is_running | (show_res_num == {nbits{1'd0}})) ? dseconds : memory_dsec[show_res_num - 1'd1];
wire [6:0] displayed_sec  = (is_running | (show_res_num == {nbits{1'd0}})) ? seconds  : memory_sec [show_res_num - 1'd1];
wire [6:0] last_result    = (recorded_res_num == {nbits{1'd0}})            ? 7'd0     : memory_sec [recorded_res_num - 1'd1];

wire incr_is_running = start_stop & (show_res_num == {nbits{1'd0}});

counter
#(
    .MODULUS    (2)
) counter_is_running
(
    .clk        (clk),
    .rst        (rst),
    .incr       (incr_is_running),
    .number     (is_running),
    .set_data   (),
    .data       ()
);

counter
#(
    .MODULUS    (max_cycles)
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
    .MODULUS    (10)
) counter_dsec
(
    .clk        (clk),
    .rst        (rst),
    .incr       (incr_dsec),
    .number     (dseconds),
    .set_data   (),
    .data       ()
);

counter
#(
    .MODULUS    (100)
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
    .MODULUS    (`MAX_RES_NUM + 1)
) counter_show_res_num
(
    .clk        (clk),
    .rst        (rst),
    .incr       (incr_show_res_num),
    .number     (show_res_num),
    .set_data   (set_show_res_num),
    .data       (show_res_num_data)
);

counter
#(
    .MODULUS    (`MAX_RES_NUM + 1)
) counter_recorded_res_num
(
    .clk        (clk),
    .rst        (rst),
    .incr       (incr_recorded_res_num),
    .number     (recorded_res_num),
    .set_data   (set_recorded_res_num),
    .data       (recorded_res_num_data)
);

byte2sev_segm
#(
    .NOTATION   (10)
) byte2sev_segm_secs
(
    .byte       ({1'd0, displayed_sec}),
    .segm0      (hex2_sec),
    .segm1      (hex3_sec),
    .overflow   ()
);

byte2sev_segm
#(
    .NOTATION   (10)
) byte2sev_segm_dsecs
(
    .byte       ({4'h0, displayed_dsec}),
    .segm0      (hex1_dsec),
    .segm1      (),
    .overflow   ()
);

byte2sev_segm
#(
    .NOTATION   (10)
) byte2sev_segm_result
(
    .byte       ({1'd0, last_result}),
    .segm0      (hex4_result),
    .segm1      (hex5_result),
    .overflow   ()
);

integer i;

always @(posedge clk)
begin
    if (rst | (~is_running & write))
    begin
        for (i = 0; i < `MAX_RES_NUM; i = i + 1)
        begin
            memory_dsec[i] <= 4'd0;
            memory_sec [i] <= 7'd0;
        end
    end

    if (incr_recorded_res_num)
    begin
        memory_dsec[recorded_res_num] <= dseconds;
        memory_sec [recorded_res_num] <= seconds;
    end
end

endmodule