`timescale 1ns/1ps

`include "./clk.v"

module pulse_5 (
	input	wire	reset,
	input	wire	clk,
	output	reg	pulse5
);

reg	clk_div2;
reg	[1:0]	d;

always @(posedge clk)
if (reset)
	{clk_div2, pulse5, d} <= 4'h0;
else begin
	clk_div2 <= ~clk_div2;
	pulse5 <= (d[0] ~^ clk_div2) & ~d[1] ? ~pulse5 : pulse5;
	d[0] <= (d[0] ~^ clk_div2) & ~pulse5 & ~d[1] ? ~d[0] : d[0];
	d[1] <= (d[0] ~^ clk_div2) & pulse5 ? 1'h1 : (d[0] ~^ clk_div2) & ~pulse5 & d[1] ? 1'h0 : d[1];
end
endmodule

module top;

reg	reset = 0;
wire	clk;
wire	pulse5;

clk clk_module
(
	.clk	(clk)
);

pulse_5	pulse_5_module
(
	.reset	(reset),
	.clk	(clk),
	.pulse5	(pulse5)
);

initial begin
	reset = 1;
	#2
	reset = 0;
	#100
	$stop;
end
endmodule