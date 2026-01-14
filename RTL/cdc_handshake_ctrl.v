module cdc_handshake_ctrl (
    input  wire src_clk,
    input  wire src_rst,
    input  wire src_req,
    output reg  src_ready,

    input  wire dst_clk,
    input  wire dst_rst,
    output reg  dst_valid,
    input  wire dst_done
);

    reg req_src;
    reg ack_dst;

    wire req_dst_sync;
    wire ack_src_sync;

    bit_sync sync_req (.clk(dst_clk), .rst(dst_rst), .d(req_src), .q(req_dst_sync));
    bit_sync sync_ack (.clk(src_clk), .rst(src_rst), .d(ack_dst), .q(ack_src_sync));

    // Source domain
    always @(posedge src_clk or posedge src_rst) begin
        if (src_rst) begin
            req_src   <= 1'b0;
            src_ready <= 1'b1;
        end else begin
            if (src_req && src_ready) begin
                req_src   <= 1'b1;
                src_ready <= 1'b0;
            end else if (ack_src_sync) begin
                req_src   <= 1'b0;
                src_ready <= 1'b1;
            end
        end
    end

    // Destination domain
    always @(posedge dst_clk or posedge dst_rst) begin
        if (dst_rst) begin
            dst_valid <= 1'b0;
            ack_dst   <= 1'b0;
        end else begin
            if (req_dst_sync && !dst_valid)
                dst_valid <= 1'b1;

            if (dst_valid && dst_done) begin
                dst_valid <= 1'b0;
                ack_dst   <= 1'b1;
            end else begin
                ack_dst <= 1'b0;
            end
        end
    end

endmodule
