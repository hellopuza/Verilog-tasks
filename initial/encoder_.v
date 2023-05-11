`timescale 1ns/1ps

module encoder
#(
	parameter	VECT_W = 8,
	parameter	BIN_W = 3
)
(
	input	wire	[VECT_W-1:0]	vec,
	output	wire	[BIN_W-1:0]	out
);

wire	[BIN_W-1:0]	wires	[VECT_W-1:0];

genvar Gi;
generate for (Gi = 0; Gi < VECT_W; Gi = Gi + 1)
begin: loop
	if (Gi == 0)
		assign wires[Gi] = {BIN_W{1'h0}};
	else
		assign wires[Gi] = wires[Gi - 1] | {BIN_W{vec[Gi]}} & Gi;
end
endgenerate

assign out = wires[VECT_W - 1];

endmodule

`define INPUT_N 16

module top;

localparam OUTPUT_N = $clog2(`INPUT_N);

reg	[`INPUT_N-1:0]	vec;
wire	[OUTPUT_N-1:0]	out;

encoder
#(
	.VECT_W(`INPUT_N),
	.BIN_W(OUTPUT_N)
) encoder
(
	.vec	(vec),
	.out	(out)
);

initial	vec = 1'h1;

always  #1 vec = vec << 1;

initial begin
	#100
	$stop;
end
endmodule