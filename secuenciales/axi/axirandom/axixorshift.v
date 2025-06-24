module axixorshift(
    input  clk,                 //Señal de reloj
    input  anrst,               //Señal de reset asíncrono activo en bajo

    //Canal de escritura (desde el punto de vista del master)
    //la semilla del xor shift
    input wire [31:0] wdata,
    input wire wdatavalid,
    output wire wdataready,

    //Canal de lectura (desde el punto de vista del master)
    output wire [31:0] rdata,
    output wire rdatavalid,
    input wire rdataready
);

    wire rst;
    wire load;
    wire en;

    assign rst = ~anrst;

    xorshift generador_aleatorio(
    .clk(clk),
    .arst(rst),                
    .load(load),
    .en(en),
    .seed(wdata),
    .random(rdata));  

    axi_ch_read canal_escritura (
        .clk(clk),
        .anreset(anreset),
        .valid(wdatavalid),
        .ready(wdataready),
        .cs(load)
    );

    axi_ch_write canal_lectura (
        .clk(clk),
        .anreset(anreset),
        .ready(rdataready),
        .en(1'b1),
        .valid(rdatavalid),
        .cs(en)
    );


endmodule