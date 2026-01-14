module apb_async_bridge (
    input  wire clk_a, rst_a,
    input  wire clk_b, rst_b,

    // A side
    input  wire [31:0] paddr_a,
    input  wire [31:0] pwdata_a,
    input  wire        pwrite_a,
    input  wire        psel_a,
    input  wire        penable_a,
    output wire [31:0] prdata_a,
    output wire        pready_a,

    // B side
    output wire [31:0] paddr_b,
    output wire [31:0] pwdata_b,
    output wire        pwrite_b,
    output wire        psel_b,
    output wire        penable_b,
    input  wire [31:0] prdata_b,
    input  wire        pready_b
);

    // Pack command
    wire [64:0] cmd = {pwrite_a, paddr_a, pwdata_a};

    wire fifo_full, fifo_empty;

    async_fifo #(.DATA_W(65)) fifo_cmd (
        .wr_clk(clk_a),
        .rd_clk(clk_b),
        .rst(rst_a | rst_b),
        .wr_en(psel_a & penable_a & ~fifo_full),
        .wr_data(cmd),
        .full(fifo_full),
        .rd_en(~fifo_empty),
        .rd_data({pwrite_b, paddr_b, pwdata_b}),
        .empty(fifo_empty)
    );

    assign psel_b    = ~fifo_empty;
    assign penable_b = ~fifo_empty;

    assign pready_a = ~fifo_full;

    assign prdata_a = prdata_b;

endmodule
