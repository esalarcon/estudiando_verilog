module sumador #(
    // Ancho de los operandos, por defecto 8 bits
    parameter N = 8  
)(
    input  [N-1:0] A,
    input  [N-1:0] B,
    input          Cin,
    output [N-1:0] S,
    output         Cout,
    output         V
);
    wire [N:0] resultado = A + B + Cin;
    assign S    = resultado[N-1:0];
    assign Cout = resultado[N];
    assign V    = ((A[N-1] == B[N-1]) && (S[N-1] != A[N-1]))?1'b1 : 1'b0;
endmodule

