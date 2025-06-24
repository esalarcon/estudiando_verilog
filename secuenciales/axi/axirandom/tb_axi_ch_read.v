`timescale 1ns/1ps

module tb_axi_ch_read;

    reg clk;
    reg anreset;
    reg valid;
    wire ready;
    wire cs;

    // DUT
    axi_ch_read dut (
        .clk(clk),
        .anreset(anreset),
        .valid(valid),
        .ready(ready),
        .cs(cs)
    );

    // Clock: 10ns periodo
    initial clk = 0;
    always #5 clk = ~clk;

    // Estímulo
    initial begin
        $dumpfile("tb_axi_ch_read.vcd");
        $dumpvars(0, tb_axi_ch_read);

        anreset = 0;
        valid = 0;

        // Reset activo 2 ciclos
        #12 anreset = 1;

        // --- CASO 1: valid por 1 solo ciclo ---
        #10 valid = 1;
        #10 valid = 0;

        // Esperar 3 ciclos
        #30;

        // --- CASO 2: valid sostenido por 3 ciclos ---
        #10 valid = 1;
        #30 valid = 0;

        // Esperar 3 ciclos
        #30;

        // --- CASO 3: dos pulsos consecutivos (separados por solo 1 ciclo) ---
        #10 valid = 1;
        #10 valid = 0;
        #10 valid = 1;
        #10 valid = 0;

        // Esperar
        #50;

        $finish;
    end

endmodule
