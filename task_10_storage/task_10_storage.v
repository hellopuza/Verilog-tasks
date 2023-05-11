`include "button.v"

module task_10_storage (
    input           clk,
    input           key0_rst,
    input           key1_write,
    input   [2:0]   sw_addr,
    input   [7:0]   sw_value,
    output  [7:0]   ledr_indic
);

wire rst = ~key0_rst;

wire    write;
button button_write
(
    .rst        (rst),
    .clk        (clk),
    .in_key     (key1_write),
    .out_key    (write)
);

reg [7:0] memory [7:0];

assign ledr_indic = memory[sw_addr];

integer i;

always @(posedge clk)
begin
    if (rst)
        for (i = 0; i < 8; i = i + 1)
            memory[i] <= 8'd0;
    else
        if (write)
            memory[sw_addr] <= sw_value;
end

/*
genvar Gi;
generate for (Gi = 0; Gi < 8; Gi = Gi + 1)
begin: loop
    memory[Gi] <= (Gi == sw_addr) ? sw_value : memory[Gi];
end
endgenerate
*/

endmodule