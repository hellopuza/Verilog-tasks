`timescale 1ns/1ps

module reset (
	output	reg	reset
);

initial begin
	reset = 1;
	#2
	reset = 0;
end

endmodule