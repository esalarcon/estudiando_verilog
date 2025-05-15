module cnt #(
    parameter LEN = 4
)(
    input clk, 
    input rst,
    input en,
    output reg [LEN-1:0] q        
);
    //Contador ascendente con rst
    //sincrónico.
    always @(posedge clk) begin
        if (rst) begin
            q <= {LEN{1'b0}};
        end else if (en) begin
            q <= q + 1'b1;
        end
    end
endmodule