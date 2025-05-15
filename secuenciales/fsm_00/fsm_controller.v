module fsm_controller (
    input  wire clk,
    input  wire reset,     // reset síncrono
    input  wire start,
    input  wire done,
    output reg  busy,
    output reg  ready
);

// 1. Definición de estados
parameter[1:0] IDLE = 2'b00;
parameter[1:0] WORK = 2'b01;
parameter[1:0] DONE = 2'b10;
reg[1:0] state, next_state;

// 2. Registro del estado actual (se actualiza en flanco ascendente del reloj)
always @(posedge clk) begin : fsm_memoria
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// 3. Lógica de transición de estado (combinacional)
always @(*) begin : fsm_estado_futuro
    next_state = state; // Valor por defecto para evitar latches
    case (state)
        IDLE: begin
            if (start)
                next_state = WORK;
        end
        WORK: begin
            if (done)
                next_state = DONE;
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// 4. Lógica de salida (combinacional en base al estado actual)
always @(*) begin : fsm_salida
    // Valores por defecto
    busy  = 0;
    ready = 0;
    case (state)
        IDLE: begin
            busy  = 0;
            ready = 1;
        end
        WORK: begin
            busy  = 1;
            ready = 0;
        end
        DONE: begin
            busy  = 0;
            ready = 0;
        end
        default: begin
            busy  = 0;
            ready = 0;
        end
    endcase
end
endmodule
