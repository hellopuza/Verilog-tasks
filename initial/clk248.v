`timescale 1ns/1ps

`include "./clk.v"

module clk_248 (
	input	wire	reset,
	input	wire	clk,
	output	reg	clk_2,
	output	reg	clk_4,
	output	reg	clk_8
);

always @(posedge clk)
if (reset)
	{clk_2, clk_4, clk_8} <= 3'h0;
else begin
	clk_2 <= ~clk_2;
	clk_4 <= clk_2 ? ~clk_4 : clk_4;
	clk_8 <= (clk_2 & clk_4) ? ~clk_8 : clk_8;
end
endmodule

module top;

reg	reset = 0;
wire	clk;
wire	clk_2;
wire	clk_4;
wire	clk_8;

clk clk_module
(
	.clk	(clk)
);

clk_248	clk_248_module
(
	.reset	(reset),
	.clk	(clk),
	.clk_2	(clk_2),
	.clk_4	(clk_4),
	.clk_8	(clk_8)
);

initial begin
	reset = 1'h1;
	#2
	reset = 1'h0;
	#100
	$stop;
end
endmodule