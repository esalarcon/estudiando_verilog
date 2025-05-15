`timescale 1ns/1ps      //declarando la unidad de tiempo y la precision
module tb_comparador;   //definiendo el modulo de prueba

//Declaro señales para simular.
reg [3:0] cnt;
wire [1:0] a;
wire [1:0] b;
wire aeqb;

//instanciando el modulo a probar
comparador uut ( 
    .a(a), 
    .b(b), 
    .aeqb(aeqb) 
);

assign a = cnt[3:2]; 
assign b = cnt[1:0]; 

//Genero el chequeo de la salida.
function automatic chequea_salida;
    input [1:0] a;
    input [1:0] b;  
    if (a == b)
        chequea_salida = 1'b1; //si son iguales devuelve 1
    else 
        chequea_salida = 1'b0; //si son diferentes devuelve 0
endfunction

// Genero la secuencia de estímulos
integer i;
initial begin
    $dumpfile("comparador.vcd");
    $dumpvars(0, tb_comparador);
    $monitor("cnt = %b, a = %b, b = %b, aeqb = %b", cnt, a, b, aeqb);
    cnt = 0;
    for (i = 0; i < 2**4; i = i + 1) begin        
        cnt = i;
        #10;
        // Aserción que verifica el comportamiento
        if (aeqb !== chequea_salida(a, b)) begin
            $error("Error en tiempo %t: a=%b, b=%b, aeqb=%b (esperado %b)",
                   $time, a, b, aeqb, chequea_salida(a, b));
            $finish;
        end
    end
    $display("¡Todas las pruebas pasaron exitosamente!");
    $finish;
end
endmodule