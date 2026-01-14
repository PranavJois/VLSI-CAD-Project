module gray2bin #(parameter W=4)(
    input  wire [W:0] gray,
    output reg  [W:0] bin
);
    integer i;
    always @(*) begin
        bin[W] = gray[W];
        for (i = W-1; i >= 0; i = i-1)
            bin[i] = bin[i+1] ^ gray[i];
    end
endmodule
