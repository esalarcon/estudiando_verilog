`timescale 1ns / 1ps
module tb_xorshift;
    reg clk;
    reg rst;
    reg load;
    wire en;
    wire [31:0] q;
    wire [31:0] s;
    
    xorshift modulo_bajo_ensayo(
    .clk(clk),
    .arst(rst),                
    .load(load),
    .en(en),
    .seed(s),
    .random(q));  

    assign en = 1;
    assign s = 32'h92D68CA2;

    // Genero el reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Cambia el reloj cada 5 ns
    end

    initial begin
        $dumpfile("xorshift.vcd");
        $dumpvars(0, tb_xorshift);
        $monitor("time=%0t ps, q=%h", $time,q);
        rst = 1; 
        load = 1;
        #20;
        rst = 0;
        #20;
        load = 0;
        #200
        $finish;
    end
endmodule