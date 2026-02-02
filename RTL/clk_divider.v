module clk_divider (clk, clk_b);
input clk;
output reg clk_b;

always @(posedge clk) begin
    clk_b <= clk;
end

endmodule
