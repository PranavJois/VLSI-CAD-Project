module apb_slave (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] paddr,
    input  wire [31:0] pwdata,
    input  wire        pwrite,
    input  wire        psel,
    input  wire        penable,
    output reg  [31:0] prdata,
    output reg         pready
);

    reg [31:0] reg0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg0 <= 0;
            pready <= 0;
        end else begin
            pready <= 0;
            if (psel && penable) begin
                pready <= 1;
                if (pwrite) reg0 <= pwdata;
                else prdata <= reg0;
            end
        end
    end
endmodule
