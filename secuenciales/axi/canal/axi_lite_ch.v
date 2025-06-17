module axi_lite_ch (
    input  wire clk,
    input  wire anreset,  // reset activo en bajo
    input  wire valid,    // viene del maestro AXI
    output reg  ready,    // señal al maestro: estoy listo
    output reg  cs        // pulso de transferencia efectiva
);

    // Estados
    localparam IDLE       = 2'b00;
    localparam WAIT_VALID = 2'b01;
    localparam TRANSFER   = 2'b10;

    reg [1:0] estado_actual, estado_siguiente;

    // Transición de estado
    always @(posedge clk or negedge anreset) begin
        if (!anreset)
            estado_actual <= IDLE;
        else
            estado_actual <= estado_siguiente;
    end

    // Lógica de siguiente estado
    always @(*) begin
        case (estado_actual)
            IDLE: begin
                if (valid)
                    estado_siguiente = TRANSFER;  // directamente a transferencia
                else
                    estado_siguiente = WAIT_VALID;
            end
            WAIT_VALID: begin
                if (valid)
                    estado_siguiente = TRANSFER;
                else
                    estado_siguiente = WAIT_VALID;
            end
            TRANSFER: begin
                estado_siguiente = IDLE;
            end
            default: estado_siguiente = IDLE;
        endcase
    end

    // Lógica de salida secuencial
    always @(posedge clk or negedge anreset) begin
        if (!anreset) begin
            ready <= 0;
            cs    <= 0;
        end else begin
            case (estado_siguiente)
                IDLE: begin
                    ready <= 1;
                    cs    <= 0;
                end
                WAIT_VALID: begin
                    ready <= 1;
                    cs    <= 0;
                end
                TRANSFER: begin
                    ready <= 0;
                    cs    <= 1;  // pulso de un ciclo
                end
            endcase
        end
    end

endmodule


