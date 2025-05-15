module genor(
    input  wire [3:0] entrada,
    output reg salida
);
    reg or_entrada;
    integer i;
    always @(entrada) begin
        or_entrada = 0;
        for(i=0; i<4; i=i+1) begin
            or_entrada = or_entrada | entrada[i];
        end
    end
endmodule
   