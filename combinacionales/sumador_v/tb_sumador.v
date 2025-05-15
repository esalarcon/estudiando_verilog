`timescale 1ns/1ps

module tb_sumador;

    parameter N = 8;

    reg  [N-1:0] A, B;
    reg          Cin;
    wire [N-1:0] S;
    wire         Cout, V;

    // Instanciación del sumador
    sumador #(.N(N)) dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout),
        .V(V)
    );

    initial begin
        $dumpfile("tb_sumador.vcd");
        $dumpvars(0, tb_sumador);

        $display("Tiempo | A      B      Cin | S      Cout V");
        $monitor("%4dns | %b %b   %b   | %b   %b    %b", $time, A, B, Cin, S, Cout, V);

        // Casos de prueba
        A = 8'd50;   B = 8'd30;   Cin = 0; #10; // 50 + 30 = 80
        A = 8'd127;  B = 8'd1;    Cin = 0; #10; // 127 + 1 = -128 (overflow)
        A = -8'd60;  B = -8'd70;  Cin = 0; #10; // -60 + (-70) = -130 (overflow)
        A = 8'd100;  B = -8'd50;  Cin = 1; #10; // 100 - 50 + 1 = 51
        A = -8'd1;   B = -8'd1;   Cin = 1; #10; // -1 + (-1) + 1 = -1
        A = 8'd200;  B = 8'd100;  Cin = 0; #10; // 200 + 100 = 300 (con acarreo)

        $finish;
    end

endmodule