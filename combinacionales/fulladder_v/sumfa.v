module sumfa (
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] s,
    output      cout
);
    wire    [4:0] c;
    assign c[0] = 1'b0;
    assign cout = c[4];

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) 
            begin : fa_loop
                fa fa_i (.a(a[i]), .b(b[i]), .cin(c[i]), .s(s[i]), .cout(c[i+1]));
        end
    endgenerate
endmodule //sumfa