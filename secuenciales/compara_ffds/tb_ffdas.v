`timescale 1ns / 1ps
module test_ffd_ays;
    // Entradas
    reg clk;
    reg rst;
    reg d;
    // Salidas
    wire q_async;
    wire q_sync;
    // Instancia del módulo bajo prueba
    ffd_ays uut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q_async(q_async),
        .q_sync(q_sync)
    );
    // Generador de clock
    always #5 clk = ~clk;

    
    initial begin
        // Inicialización
        $dumpfile("test_ffd_ays.vcd");
        $dumpvars(0, test_ffd_ays);

        clk = 0;
        rst = 0;
        d = 0;

        #3  rst = 1;  // Reset asíncrono será efectivo inmediatamente
        #4  d = 1;    // d cambia pero no afecta aún

        #5  rst = 0;  // Se desactiva el reset
        #10 d = 0;
        #10 d = 1;
        #10 d = 0;

        // Reset dentro de un flanco de reloj (efectivo para reset síncrono)
        #6  rst = 1;  // q_async se resetea enseguida, q_sync esperará al clk
        #10 rst = 0;
        #20 $finish;
    end
endmodule
