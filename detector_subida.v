module detector_subida (
    input  clk,
    input  rst_n,
    input  entrada,
    output saida
);
    wire q, nq, nentrada;
 
    not u_nq      (nq,      q);
    not u_nentrada(nentrada, entrada);
 
    // FF JK armazena o valor atual de 'entrada'
    // J=entrada, K=nentrada => comporta-se como D flip-flop
    jk ff (.j(entrada), .k(nentrada), .clk(clk), .rst_n(rst_n), .q(q));
 
    // saida = entrada AND NOT(q_anterior) = borda de subida
    and u_and (saida, entrada, nq);
endmodule