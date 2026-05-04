module debouncer (
    input  clk,       // Aqui deve entrar o clock RÁPIDO (ex: 50 Hz)
    input  rst_n,
    input  ruidoso,
    output filtrado
);
    wire q1, q2, q3;
    wire n_ruidoso, nq1, nq2;
 
    // Inversores ligados nas ENTRADAS, não nas saídas!
    not u1 (n_ruidoso, ruidoso); 
    not u2 (nq1, q1);            
    not u3 (nq2, q2);            
 
    // J recebe o sinal, K recebe o sinal invertido
    jk ff1 (.j(ruidoso), .k(n_ruidoso), .clk(clk), .rst_n(rst_n), .q(q1));
    jk ff2 (.j(q1),      .k(nq1),       .clk(clk), .rst_n(rst_n), .q(q2));
    jk ff3 (.j(q2),      .k(nq2),       .clk(clk), .rst_n(rst_n), .q(q3));
 
    // Consenso final
    and u_and (filtrado, q1, q2, q3);
endmodule