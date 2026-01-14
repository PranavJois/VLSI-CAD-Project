module async_fifo #(
    parameter DATA_W = 65,
    parameter ADDR_W = 3
)(
    input  wire                 wr_clk,
    input  wire                 rd_clk,
    input  wire                 rst,

    input  wire                 wr_fire,
    input  wire [DATA_W-1:0]    wr_data,
    output wire                 full,

    input  wire                 rd_fire,
    output reg  [DATA_W-1:0]    rd_data,
    output wire                 empty
);

    localparam DEPTH = 1 << ADDR_W;

    reg [DATA_W-1:0] mem [0:DEPTH-1];

    reg  [ADDR_W:0] wptr_bin, rptr_bin;
    wire [ADDR_W:0] wptr_gray, rptr_gray;

    reg [ADDR_W:0] wptr_gray_rdclk, rptr_gray_wrclk;

    genvar i;
    generate
        for (i=0; i<=ADDR_W; i=i+1) begin
            bit_sync sw(.clk(rd_clk), .rst(rst), .d(wptr_gray[i]), .q(wptr_gray_rdclk[i]));
            bit_sync sr(.clk(wr_clk), .rst(rst), .d(rptr_gray[i]), .q(rptr_gray_wrclk[i]));
        end
    endgenerate

    bin2gray #(ADDR_W) b2g_w (.bin(wptr_bin), .gray(wptr_gray));
    bin2gray #(ADDR_W) b2g_r (.bin(rptr_bin), .gray(rptr_gray));

    always @(posedge wr_clk or posedge rst) begin
        if (rst)
            wptr_bin <= 0;
        else if (wr_fire && !full) begin
            mem[wptr_bin[ADDR_W-1:0]] <= wr_data;
            wptr_bin <= wptr_bin + 1;
        end
    end

    always @(posedge rd_clk or posedge rst) begin
        if (rst) begin
            rptr_bin <= 0;
            rd_data  <= 0;
        end else if (rd_fire && !empty) begin
            rd_data  <= mem[rptr_bin[ADDR_W-1:0]];
            rptr_bin <= rptr_bin + 1;
        end
    end

    assign empty = (rptr_gray == wptr_gray_rdclk);

    assign full  = (wptr_gray == {
                    ~rptr_gray_wrclk[ADDR_W:ADDR_W-1],
                     rptr_gray_wrclk[ADDR_W-2:0]
                   });

endmodule
