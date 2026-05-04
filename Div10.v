module Div10 (
    input  clk_in,
    input  rst_n,
    output clk_out,
    output q0,
    output q1,
    output q2,
    output q3
);
    wire nq3;
    wire j1, j2, j3;
    wire vcc;
 
    not  u_not  (nq3, q3);
    and  u_j1   (j1,  q0,  nq3);
    and  u_j2   (j2,  q0,  q1);
    and  u_j3   (j3,  j2,  q2);
    or   u_vcc  (vcc, q3,  nq3);
 
    jk ff0 (.j(vcc), .k(vcc), .clk(clk_in), .rst_n(rst_n), .q(q0));
    jk ff1 (.j(j1),  .k(q0),  .clk(clk_in), .rst_n(rst_n), .q(q1));
    jk ff2 (.j(j2),  .k(j2),  .clk(clk_in), .rst_n(rst_n), .q(q2));
    jk ff3 (.j(j3),  .k(q0),  .clk(clk_in), .rst_n(rst_n), .q(q3));
 
    buf u_out (clk_out, q3);
endmodule