`timescale 1ns/1ps

module div_3 (
	input	wire	[15:0]	number,
	output	wire		is_div3
);

wire	[3:0]	even_sum4;
wire	[3:0]	odd_sum4;
wire	[3:0]	difference4;

assign even_sum4 = (number[0]  & 4'h1) +
                   (number[2]  & 4'h1) +
                   (number[4]  & 4'h1) +
                   (number[6]  & 4'h1) +
                   (number[8]  & 4'h1) +
                   (number[10] & 4'h1) +
                   (number[12] & 4'h1) +
                   (number[14] & 4'h1);

assign odd_sum4 = (number[1]  & 4'h1) +
                  (number[3]  & 4'h1) +
                  (number[5]  & 4'h1) +
                  (number[7]  & 4'h1) +
                  (number[9]  & 4'h1) +
                  (number[11] & 4'h1) +
                  (number[13] & 4'h1) +
                  (number[15] & 4'h1);

assign difference4 = even_sum4 > odd_sum4 ? even_sum4 - odd_sum4 : odd_sum4 - even_sum4;

wire	[1:0]	even_sum2;
wire	[1:0]	odd_sum2;
wire	[1:0]	difference2;

assign even_sum2 = (difference4[0] & 2'h1) +
                   (difference4[2] & 2'h1);

assign odd_sum2 = (difference4[1] & 2'h1) +
                  (difference4[3] & 2'h1);

assign difference2 = even_sum2 > odd_sum2 ? even_sum2 - odd_sum2 : odd_sum2 - even_sum2;
assign is_div3 = difference2[0] == difference2[1];

endmodule

module top;

reg	[15:0]	number;
wire		is_div3;

div_3	div_3_module
(
	.number		(number),
	.is_div3	(is_div3)
);

initial	number = 16'd0;

always	#1 number = number + 16'd1;

initial begin
	#100
	$stop;
end
endmodule