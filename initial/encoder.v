`timescale 1ns/1ps

module encoder_83 (
	input	wire	[7:0]	vec,
	output	wire	[2:0]	out
);

assign out = {3{vec[7]}} & 3'h7 |
             {3{~vec[7]}} & ({3{vec[6]}} & 3'h6 |
             {3{~vec[6]}} & ({3{vec[5]}} & 3'h5 |
             {3{~vec[5]}} & ({3{vec[4]}} & 3'h4 |
             {3{~vec[4]}} & ({3{vec[3]}} & 3'h3 |
             {3{~vec[3]}} & ({3{vec[2]}} & 3'h2 |
             {3{~vec[2]}} & ({3{vec[1]}} & 3'h1 |
             {3{~vec[1]}} & ({3{vec[0]}} & 3'h0)))))));
endmodule

module top;

reg	[7:0]	vec;
wire	[2:0]	out;

encoder_83	encoder_83_module
(
	.vec	(vec),
	.out	(out)
);

initial	vec = 7'h0;

always  #1 vec = vec + 7'h1;

initial begin
	#100
	$stop;
end
endmodule