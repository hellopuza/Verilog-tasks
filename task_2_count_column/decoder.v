module decoder
#(
	parameter	NUM_W = 3,
	parameter	VEC_W = 8
)
(
    input   [NUM_W-1:0]   num,
    output  [VEC_W-1:0]   vec
);

genvar Gi;
generate for (Gi = 0; Gi < VEC_W; Gi = Gi + 1)
begin: loop
	assign vec[Gi] = (num > Gi);
end
endgenerate

endmodule