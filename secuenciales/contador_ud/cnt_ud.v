module cnt_ud #(
    parameter LEN = 4
)(
    input clk,
    input rst,
    input u_dn,
    input [LEN-1:0] d,
    output reg [LEN-1:0] q,
    output reg tc
);
    localparam MAX = {LEN{1'b1}};
    localparam ZERO = {LEN{1'b0}};

    always @(posedge clk) begin
        if (rst) begin
            q <= ZERO;
            tc <= 1'b0;
        end else begin
            if (!u_dn) begin
                if (q == ZERO) begin
                    q <= d;
                    tc <= 1'b1;
                end else begin
                    q <= q - 1;
                    tc <= 1'b0;
                end
            end else begin
                if (q == MAX) begin
                    q <= d;
                    tc <= 1'b1;
                end else begin
                    q <= q + 1;
                    tc <= 1'b0;
                end
            end
        end
    end
endmodule
