module ffd_ays (
    input wire clk,
    input wire rst,
    input wire d,
    output reg q_async,
    output reg q_sync
);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q_async <= 1'b0;
        end else begin
            q_async <= d;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            q_sync <= 1'b0;
        end else begin
            q_sync <= d;
        end
    end
endmodule