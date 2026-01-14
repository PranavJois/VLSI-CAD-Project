module apb_master (
    input  wire        clk,
    input  wire        rst,
    output reg  [31:0] paddr,
    output reg  [31:0] pwdata,
    output reg         pwrite,
    output reg         psel,
    output reg         penable,
    input  wire        pready,
    input  wire [31:0] prdata
);

    reg [1:0] state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state   <= 0;
            psel    <= 0;
            penable <= 0;
            pwrite  <= 0;
            paddr   <= 0;
            pwdata  <= 32'h12345678;
        end else begin
            case(state)
                0: begin psel<=1; penable<=0; pwrite<=1; paddr<=32'h0; state<=1; end
                1: begin penable<=1; if(pready) begin psel<=0; penable<=0; state<=2; end end
                2: begin psel<=1; penable<=0; pwrite<=0; state<=3; end
                3: begin penable<=1; if(pready) begin psel<=0; penable<=0; state<=3; end end
            endcase
        end
    end
endmodule
