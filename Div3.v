module Div3 (
<<<<<<< HEAD
    input clk_in,
    input reset,
    output q1,      
    output q0,      
    output clk_out  
);
    wire not_q1;
    not inv_q1 (not_q1, q1);
    
    jk ff0 (
        .j(not_q1), 
        .k(1'b1), 
        .clk(clk_in), 
        .q(q0), 
        .rst_n(reset)
    );

    jk ff1 (
        .j(q0), 
        .k(1'b1), 
        .clk(clk_in), 
        .q(q1), 
        .rst_n(reset)
    );

    buf saida_trava (clk_out, q1);
=======
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
>>>>>>> 1fc15c7 (Trial Mode)
endmodule