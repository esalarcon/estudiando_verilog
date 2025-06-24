module axi_ch_write(
    input  wire clk,
    input  wire anreset,   // reset activo en bajo
    input  wire ready,     // del maestro (señal de aceptación)
    input  wire en,        // trigger para iniciar la transferencia (desde el esclavo)
    output reg  valid,     // generado por el esclavo
    output wire cs         // pulso de transferencia efectiva
);

assign cs = valid & ready;

localparam IDLE     = 2'b00;
localparam VALID_ON = 2'b01;

reg [1:0] estado, estado_siguiente;

// FSM: registro de estado
always @(posedge clk or negedge anreset) begin
    if (!anreset)
        estado <= IDLE;
    else
        estado <= estado_siguiente;
end

// FSM: siguiente estado y control valid
always @(*) begin
    case (estado)
        IDLE: begin
            if (en)
                estado_siguiente = VALID_ON;
            else
                estado_siguiente = IDLE;
        end

        VALID_ON: begin
            // Esperar handshake para bajar valid
            if (ready)
                estado_siguiente = IDLE;
            else
                estado_siguiente = VALID_ON;
        end

        default: estado_siguiente = IDLE;
    endcase
end

// Control de valid
always @(*) begin
        case (estado)
            VALID_ON: valid <= 1;
            default:  valid <= 0;
        endcase
end

endmodule
