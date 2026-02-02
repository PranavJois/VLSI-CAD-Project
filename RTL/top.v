module top(
    input clk_a,
    input rst,
    output [31:0] result,
    output done
);

wire [31:0] paddr_a, pwdata_a, prdata_a;
wire pwrite_a, psel_a, penable_a, pready_a;
wire clk_b;
wire [31:0] paddr_b, pwdata_b, prdata_b;
wire pwrite_b, psel_b, penable_b, pready_b;

clk_divider divider(clk_a, clk_b);

apb_master M(clk_a, rst, paddr_a, pwdata_a, pwrite_a, psel_a, penable_a,
             pready_a, prdata_a, result, done);

apb_async_bridge B(clk_a, clk_b, rst,
             paddr_a, pwdata_a, pwrite_a, psel_a, penable_a,
             pready_a, prdata_a,
             paddr_b, pwdata_b, pwrite_b, psel_b, penable_b,
             pready_b, prdata_b);

apb_slave S(clk_b, rst, paddr_b, pwdata_b, pwrite_b, psel_b, penable_b,
            pready_b, prdata_b);

endmodule
