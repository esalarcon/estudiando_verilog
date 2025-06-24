module axi_ch_read(
    input  wire clk,
    input  wire anreset,
    input  wire valid,
    output reg  ready,
    output wire cs
);

reg valid_d;  // valid del ciclo anterior

assign cs = valid & ready;  // pulso de transferencia efectiva

// Detector de flanco
wire valid_rise = valid & ~valid_d;

// Registro del valid anterior
always @(posedge clk or negedge anreset) begin
    if (!anreset)
        valid_d <= 0;
    else
        valid_d <= valid;
end

// Lógica de salida
always @(posedge clk or negedge anreset) begin
    if (!anreset)
        ready <= 0;
    else
        ready <= valid_rise;
end

endmodule
