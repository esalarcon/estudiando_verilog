`timescale 1ns / 1ps
module tb_genor;
    reg clk;
    reg rst_n;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // Instantiate the DUT
    genor sdut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        rst_n = 0; // Assert reset
        #10;
        rst_n = 1; // Deassert reset

        data_in = 8'hAA; // Test input data
        #10;

        data_in = 8'h55; // Another test input data
        #10;

        $stop; // Stop simulation
    end
endmodule