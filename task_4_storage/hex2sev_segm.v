module hex2sev_segm (
    input   [3:0]   hex,
    output  [6:0]   segm
);

assign segm = (hex == 4'h0) ? 7'b1000000 :
              (hex == 4'h1) ? 7'b1111001 :
              (hex == 4'h2) ? 7'b0100100 :
              (hex == 4'h3) ? 7'b0110000 :
              (hex == 4'h4) ? 7'b0011001 :
              (hex == 4'h5) ? 7'b0010010 :
              (hex == 4'h6) ? 7'b0000010 :
              (hex == 4'h7) ? 7'b1111000 :
              (hex == 4'h8) ? 7'b0000000 :
              (hex == 4'h9) ? 7'b0010000 :
              (hex == 4'hA) ? 7'b0001000 :
              (hex == 4'hB) ? 7'b0000011 :
              (hex == 4'hC) ? 7'b1000110 :
              (hex == 4'hD) ? 7'b0100001 :
              (hex == 4'hE) ? 7'b0000110 :
                              7'b0001110;

endmodule