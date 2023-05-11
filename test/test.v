module mem (
    output reg data
);
endmodule

module test (
    input   clk
);

mem mem1();
mem mem2();

always @(posedge clk)
begin
    mem.data <= 1'd0;
end

endmodule