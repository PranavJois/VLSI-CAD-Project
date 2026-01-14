module bit_sync (
    input  wire clk,
    input  wire rst,
    input  wire d,
    output reg  q
);
    reg q1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q1 <= 1'b0;
            q  <= 1'b0;
        end else begin
            q1 <= d;
            q  <= q1;
        end
    end
endmodule

