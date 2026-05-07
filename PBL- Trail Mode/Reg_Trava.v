module Reg_Trava (
    input  clk,
    input  rst_n,
    input  marcou_F,
    input  marcou_T,
    input  marcou_P,
    input  marcou_L,
    output trava_ativa,
    output s1_trava,
    output s0_trava
);
    // trava_ativa: OR de todos os marcou_20, latched com JK SR
    // Uma vez ativo, permanece até reset
    wire qualquer_estouro;
    or u_or (qualquer_estouro, marcou_F, marcou_T, marcou_P, marcou_L);
 
    // FF JK como SR latch síncrono: J=estouro, K=0 => set e segura
    jk ff_trava (
        .j    (qualquer_estouro),
        .k    (1'b0),
        .clk  (clk),
        .rst_n(rst_n),
        .q    (trava_ativa)
    );
 
    // s1_trava: 1 se o sensor que estourou é P(10) ou L(11)
    // Codificação: F=00, T=01, P=10, L=11
    // s1=1 para P e L; s0=1 para T e L
    // Captura s1_trava com JK: J = marcou_P OR marcou_L, K = NOT(J)
    wire j_s1, k_s1, nj_s1;
    or  u_j_s1 (j_s1, marcou_P, marcou_L);
    not u_k_s1 (k_s1, j_s1);
    jk ff_s1 (
        .j    (j_s1),
        .k    (k_s1),
        .clk  (clk),
        .rst_n(rst_n),
        .q    (s1_trava)
    );
 
    // s0_trava: 1 se o sensor que estourou é T(01) ou L(11)
    wire j_s0, k_s0, nj_s0;
    or  u_j_s0 (j_s0, marcou_T, marcou_L);
    not u_k_s0 (k_s0, j_s0);
    jk ff_s0 (
        .j    (j_s0),
        .k    (k_s0),
        .clk  (clk),
        .rst_n(rst_n),
        .q    (s0_trava)
    );
endmodule