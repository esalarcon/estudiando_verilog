module lfsr (
    input clk,
    input rst,
    input en,
    output reg [3:0] q
);
    //LFSR de 4 bits con polinomio máximo 
    //(x^4 + x^3 + 1)

    always @(posedge clk) begin :etiqueta
        if (rst) 
            //No puede iniciar en 0
            q <= 4'b0001;
        else if (en) 
            q <= {q[2:0], q[3] ^ q[2]};
    end
endmodule
