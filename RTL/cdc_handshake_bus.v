module cdc_handshake_bus #(
    parameter WIDTH = 32
)(
    input  wire              src_clk,
    input  wire              src_rst,
    input  wire [WIDTH-1:0]  src_data,
    input  wire              src_valid,
    output reg               src_ready,

    input  wire              dst_clk,
    input  wire              dst_rst,
    output reg  [WIDTH-1:0]  dst_data,
    output reg               dst_valid,
    input  wire              dst_ready
);

    reg req_src, ack_dst;
    wire req_dst_sync, ack_src_sync;

    bit_sync sreq(.clk(dst_clk), .rst(dst_rst), .d(req_src), .q(req_dst_sync));
    bit_sync sack(.clk(src_clk), .rst(src_rst), .d(ack_dst), .q(ack_src_sync));

    reg [WIDTH-1:0] buf;

    always @(posedge src_clk or posedge src_rst) begin
        if (src_rst) begin
            req_src   <= 0;
            src_ready <= 1;
        end else begin
            if (src_valid && src_ready) begin
                buf <= src_data;
                req_src <= 1;
                src_ready <= 0;
            end else if (ack_src_sync) begin
                req_src <= 0;
                src_ready <= 1;
            end
        end
    end

    always @(posedge dst_clk or posedge dst_rst) begin
        if (dst_rst) begin
            dst_valid <= 0;
            ack_dst   <= 0;
        end else begin
            if (req_dst_sync && !dst_valid) begin
                dst_data <= buf;
                dst_valid <= 1;
            end
            if (dst_valid && dst_ready) begin
                dst_valid <= 0;
                ack_dst <= 1;
            end else begin
                ack_dst <= 0;
            end
        end
    end
endmodule
