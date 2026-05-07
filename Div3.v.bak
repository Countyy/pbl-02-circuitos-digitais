module Div3 (
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
endmodule