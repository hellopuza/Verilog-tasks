`timescale 1ns/1ps

module rst (
    output  reg rst
);

initial begin
    rst = 1'h1;
    #2
    rst = 1'h0;
end

endmodule