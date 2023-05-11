`timescale 1ns/1ps

`include "./clk.v"

module clk_6 (
	input	wire	reset,
	input	wire	clk,
	output	reg	clk_div6
);

reg	clk_div2;
reg	d;

always @(posedge clk)
if (reset)
	{clk_div2, clk_div6, d} <= 3'h0;
else begin
	clk_div2 <= ~clk_div2;
	clk_div6 <= (clk_div2 ~^ clk_div6) & ~d ? ~clk_div6 : clk_div6;
	d <= clk_div2 ~^ clk_div6;
end
endmodule

module top;

reg	reset = 0;
wire	clk;
wire	clk_div6;

clk clk_module
(
	.clk	(clk)
);

clk_6	clk_6_module
(
	.reset		(reset),
	.clk		(clk),
	.clk_div6	(clk_div6)
);

initial begin
	reset = 1;
	#2
	reset = 0;
	#100
	$stop;
end
endmodule