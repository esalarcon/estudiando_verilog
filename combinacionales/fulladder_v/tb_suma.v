`timescale 1ns/1ps
module tb_suma;
//Señales
reg [3:0] a, b;      // Entradas de 4 bits
reg [3:0] s;        // Salida de 4 bits
reg cout;           // Salida de acarreo

// Testbench for the 4-bit adder
sumfa uut (
    .a(a),
    .b(b),
    .s(s),
    .cout(cout)
);

initial begin
    $dumpfile("suma.vcd");
    $dumpvars(0, tb_suma);
    $monitor("a=%b b=%b s=%b cout=%b", a, b, s, cout);

    // Initialize inputs
    a = 4'b0000;
    b = 4'b0000;

    // Test case 1: 0 + 0
    #10;
    a = 4'b0000; b = 4'b0000;
    #10;

    // Test case 2: 1 + 1
    #10;
    a = 4'b0001; b = 4'b0001;
    #10;

    // Test case 3: 2 + 2
    #10;
    a = 4'b0010; b = 4'b0010;
    #10;

    // Test case 4: 7 + 11
    #10;
    a = 4'b0111; b = 4'b1011;
    #10;

    $finish;
end
endmodule