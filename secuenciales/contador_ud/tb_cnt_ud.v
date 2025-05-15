`timescale 1ns / 1ps

module test_cnt_ud;

    // Parámetro del ancho del contador
    localparam LEN = 4;

    // Señales
    reg clk;
    reg rst;
    reg u_dn;
    reg [LEN-1:0] d;
    wire [LEN-1:0] q;
    wire tc;

    // Instancia del módulo
    cnt_ud #(.LEN(LEN)) uut (
        .clk(clk),
        .rst(rst),
        .u_dn(u_dn),
        .d(d),
        .q(q),
        .tc(tc)
    );

    // Generador de clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("test_cnt_ud.vcd");
        $dumpvars(0, test_cnt_ud);

        clk = 0;
        rst = 1;
        u_dn = 0;
        d = 4'b1010;  // Valor a recargar (10 en decimal)

        #12 rst = 0;

        // --- Conteo descendente desde 3 ---
        d = 4'b0011;
        u_dn = 0;
        #100;

        // --- Conteo ascendente hasta 15 ---
        rst = 1;
        #10 rst = 0;
        d = 4'b0101;  // recarga con 5
        u_dn = 1;
        #200;

        $finish;
    end
endmodule
