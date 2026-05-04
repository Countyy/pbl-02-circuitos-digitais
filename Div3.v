module Div3 (
    input  clk_in,
    input  rst_n,
    output q0,
    output q1,
    output clk_out
);
    wire not_q1;
    not u_inv (not_q1, q1);
 
    jk ff0 (.j(not_q1), .k(1'b1), .clk(clk_in), .rst_n(rst_n), .q(q0));
    jk ff1 (.j(q0),     .k(1'b1), .clk(clk_in), .rst_n(rst_n), .q(q1));
 
    buf u_out (clk_out, q1);
endmodule