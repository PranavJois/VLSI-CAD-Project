`timescale 1ns/1ps

module tb_top;

    // =========================================================
    // Clocks and reset
    // =========================================================
    reg clk_a = 0;
    reg clk_b = 0;
    reg rst   = 1;

    // Parameterized half periods (ns)
    parameter integer T_A = 5;   // 100 MHz
    parameter integer T_B = 7;   // ~71 MHz

    always #T_A clk_a = ~clk_a;
    always #T_B clk_b = ~clk_b;

    // =========================================================
    // Instantiate DUT
    // =========================================================
    top dut (
        .clk_a(clk_a),
        .clk_b(clk_b),
        .rst  (rst)
    );

    // =========================================================
    // Simulation control
    // =========================================================
    initial begin
        // Dump waveform
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_top);

        // Reset pulse
        #50;
        rst = 0;
        $display("Reset deasserted");

        // Run simulation
        #15000;

        $display("Simulation finished normally.");
        $finish;
    end

    // =========================================================
    // Safety timeout
    // =========================================================
    initial begin
        #30000;
        $display("ERROR: Simulation timeout!");
        $finish;
    end

endmodule
