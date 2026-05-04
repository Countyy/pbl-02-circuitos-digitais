module Div10 (
    input clk_in,
    output clk_out
);
    wire q0, q1, q2, q3;    
    wire nq3;             
    wire j1, j2, j3;        
    wire vcc;
    
    not porta_not1 (nq3, q3);
    and porta_and_j1 (j1, q0, nq3);
    and porta_and_j2 (j2, q0, q1);
    and porta_and_j3 (j3, j2, q2);
     
    or or1 (vcc, q3, nq3);
	 
    jk ff0 (
        .j(vcc), 
        .k(vcc), 
        .clk(clk_in), 
        .q(q0)
    );

    // Bit 1
    jk ff1 (
        .j(j1), 
        .k(q0), 
        .clk(clk_in), 
        .q(q1)
    );

    // Bit 2
    jk ff2 (
        .j(j2), 
        .k(j2), 
        .clk(clk_in), 
        .q(q2)
    );

    // Bit 3
    jk ff3 (
        .j(j3), 
        .k(q0), 
        .clk(clk_in), 
        .q(q3)
    );

    buf saida (clk_out, q3);
endmodule