`include "button.v"

module task_5_adder (
    input           clk,
    input           key0_rst,
    input           key1_add,
    input   [7:0]   sw1,
    input   [7:0]   sw2,
    output  [7:0]   ledr1,
    output  [7:0]   ledr2,
    output  [7:0]   ledg
);

reg [7:0] gnum;
assign ledr1 = sw1;
assign ledr2 = sw2;
assign ledg = gnum;

wire rst = ~key0_rst;

wire    add;
button button_add
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_add),
    .out_key    (add)
);

always @(posedge clk)
begin
    gnum <= rst ? 8'd0 :
            add ? sw1 + sw2 :
            gnum;
end

endmodule