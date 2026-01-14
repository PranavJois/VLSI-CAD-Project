module reset_sync (
    input  wire clk,
    input  wire arst,
    output reg  srst
);
    reg r1;

    always @(posedge clk or posedge arst) begin
        if (arst) begin
            r1   <= 1'b1;
            srst <= 1'b1;
        end else begin
            r1   <= 1'b0;
            srst <= r1;
        end
    end
endmodule
