module Seletor_Display (
    input  clk,
    input  rst_n,
    input  tick,
    input  trava,
    input  trava_s1,
    input  trava_s0,
    output s1,
    output s0
);
    wire n_trava, tick_livre;
    wire q0_count, q1_count; // Fios internos para a contagem giratória
 
    not u_ntrava (n_trava, trava);
 
    // O relógio só bate se o sistema não estiver travado
    and u_tick (tick_livre, tick, n_trava);
 
    // FF0 (Bit Menos Significativo): Alterna sempre que o tick bate
    jk ff0 (
        .j   (1'b1),
        .k   (1'b1),
        .clk (tick_livre),
        .rst_n(rst_n),
        .q   (q0_count)
    );
 
    // FF1 (Bit Mais Significativo): Contador síncrono (Só alterna se q0 for 1)
    jk ff1 (
        .j   (q0_count),
        .k   (q0_count),
        .clk (tick_livre),
        .rst_n(rst_n),
        .q   (q1_count)
    );

    // ========================================================
    // MULTIPLEXADORES ESTRUTURAIS DE SAÍDA
    // Define se a tela mostra a varredura normal ou o culpado
    // ========================================================

    // MUX para o bit s1
    wire w_s1_trava, w_s1_livre;
    and and_s1_t (w_s1_trava, trava, trava_s1);       // Se travado, deixa passar o trava_s1
    and and_s1_l (w_s1_livre, n_trava, q1_count);     // Se normal, deixa passar a contagem q1
    or  or_s1    (s1, w_s1_trava, w_s1_livre);

    // MUX para o bit s0
    wire w_s0_trava, w_s0_livre;
    and and_s0_t (w_s0_trava, trava, trava_s0);       // Se travado, deixa passar o trava_s0
    and and_s0_l (w_s0_livre, n_trava, q0_count);     // Se normal, deixa passar a contagem q0
    or  or_s0    (s0, w_s0_trava, w_s0_livre);

endmodule