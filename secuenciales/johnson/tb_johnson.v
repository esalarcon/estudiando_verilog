`timescale 1ns / 1ps
module tb_johnson;
    reg clk;
    reg rst;
    wire en;
    wire [3:0] q;

    // Genero la instancia del modulo 
    johnson #(4) uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .q(q)
    );

    assign en = 1;

    // Genero el reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Cambia el reloj cada 5 ns
    end

    initial begin
        $dumpfile("johnson.vcd");
        $dumpvars(0, tb_johnson);
        $monitor("time=%0t ps, q=%b", $time,q);
        rst = 1; 
        #10;
        rst = 0;
        #110
        $finish;
    end
endmodule