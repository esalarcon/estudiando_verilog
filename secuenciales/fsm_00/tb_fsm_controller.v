`timescale 1ns/1ps

module tb_fsm_controller;

  // Señales de prueba
  reg clk;
  reg reset;
  reg start;
  reg done;
  wire busy;
  wire ready;

  // Instancia de la FSM
  fsm_controller dut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .done(done),
    .busy(busy),
    .ready(ready)
  );

  // Generación del clock (período = 10ns)
  always #5 clk = ~clk;

  // Proceso de prueba
  initial begin
    // Inicialización
    clk = 0;
    reset = 1;
    start = 0;
    done = 0;

    // Mantener reset por unos ciclos
    #12;
    reset = 0;

    // Espera en IDLE
    #10;

    // Enviar pulso de start
    start = 1;
    #10;
    start = 0;

    // FSM debería ir a WORK
    #30;

    // Enviar pulso de done
    done = 1;
    #10;
    done = 0;

    // FSM debería ir a DONE y luego volver a IDLE
    #30;

    // Fin de simulación
    $finish;
  end

  // Monitor para mostrar señales
  initial begin
    $dumpfile("fsm_controller_tb.vcd");
    $dumpvars(0, tb_fsm_controller);
    $display("Time\tclk reset start done | state busy ready");
    $monitor("%4t\t%b    %b     %b     %b    |   %b    %b",
             $time, clk, reset, start, done, busy, ready);
  end

endmodule
