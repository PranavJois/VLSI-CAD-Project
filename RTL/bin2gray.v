module bin2gray #(parameter W=4)(
    input  wire [W:0] bin,
    output wire [W:0] gray
);
    assign gray = (bin >> 1) ^ bin;
endmodule

