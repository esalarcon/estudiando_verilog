module anillo #(parameter N = 4) (
    input clk,
    input rst,
    input en,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (rst) 
            q <= 1;
        else if (en) 
            q <= {q[N-2:0], q[N-1]};
    end
endmodule