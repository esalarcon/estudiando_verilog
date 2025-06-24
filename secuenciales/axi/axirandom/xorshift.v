module xorshift(
    input  clk,                 //Señal de reloj
    input  arst,                //Señal de reset asíncrono (colocar el generador en 1)
    input  load,                //Señal de carga de seed
    input  en,                  //Señal de habilitación (genera un nuevo número aleatorio)
    input      [31:0]  seed,    //Semilla de entrada
    output reg [31:0]  random   //Número aleatorio generado
);
    reg[31:0] x;

    always @(*) begin : bloque_combinacional
        x = random;
        x = x ^ (x << 13);
        x = x ^ (x >> 17);
        x = x ^ (x << 5);

    end

    always @(posedge clk or posedge arst) begin : bloque_secuencial
        if (arst) begin
            random <= 32'h00000001;
        end else if (load) begin
            random <= seed;
        end else if (en) begin
            random <= x;
        end
    end
endmodule