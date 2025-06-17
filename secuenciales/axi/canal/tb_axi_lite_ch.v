`timescale 1ns / 1ps
module tb_axi_lite_ch;
    reg clk;
    reg anreset;
    reg valid;
    wire ready;
    wire cs;

    // Instancia del DUT (Device Under Test)
    axi_lite_ch dut (
        .clk(clk),
        .anreset(anreset),
        .valid(valid),
        .ready(ready),
        .cs(cs)
    );

    // Clock: 10ns periodo (100MHz)
    always #5 clk = ~clk;

    // Simulación
    initial begin
        // Inicialización
        $dumpfile("tb_axi_lite.vcd");
        $dumpvars(0, tb_axi_lite_ch);

        clk     = 0;
        anreset = 0;
        valid   = 0;

        // Mantener reset unos ciclos
        #12;
        anreset = 1;
        #10;

        // Primer handshake: valid en alto un ciclo
        @(posedge clk);
        valid = 1;
        @(posedge clk);
        valid = 0;

        // Esperar unos ciclos
        repeat(3) @(posedge clk);

        // Segundo handshake: valid en alto varios ciclos
        valid = 1;
        repeat(3) @(posedge clk);
        valid = 0;

        // Esperar
        repeat(5) @(posedge clk);

        // Finalizar simulación
        $finish;
    end

endmodule
