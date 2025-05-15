`timescale 1ns / 1ps
module tb_cnt;
    reg clk;
    reg rst;
    reg en;
    wire [2:0] cnt;

    // Instantiate the counter module
    cnt #(.LEN(3))  uut (        
        .clk(clk),
        .rst(rst),
        .en(en),
        .q(cnt)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin        
        forever begin
            en = 0; #10;    
            en = 1; #10;    
        end 
    end

    // Test sequence
    initial begin
        $dumpfile("tb_cnt.vcd");
        $dumpvars(0, tb_cnt);   
        $monitor("Time: %0t | clk: %b | rst: %b | en: %b | cnt: %b", $time, clk, rst, en, cnt);
        rst = 1; 
        #10;
        rst = 0; 
        #200; 
        $finish;
    end
endmodule