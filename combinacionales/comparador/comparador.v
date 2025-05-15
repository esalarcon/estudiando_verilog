module comparador
(
    input [1:0] a,
    input [1:0] b,
    output aeqb    
);
    assign aeqb = (a == b) ? 1'b1 : 1'b0;
endmodule