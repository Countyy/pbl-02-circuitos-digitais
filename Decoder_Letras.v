module Decoder_Letras (
    input S1, S0,
    output a, b, c, d, e, f, g
);
<<<<<<< HEAD

=======
>>>>>>> 1fc15c7 (Trial Mode)
    wire not_S1, not_S0;
    
    not inv1 (not_S1, S1);
    not inv2 (not_S0, S0);

<<<<<<< HEAD
    and and_a (a, not_S1, not_S0);

    wire w_b1;
    and and_b1 (w_b1, not_S1, S0);
    not not_b (b, w_b1);

    buf buf_c (c, 1'b1);

    buf buf_d (d, S0);

    buf buf_e (e, 1'b0);
    buf buf_f (f, 1'b0);

    buf buf_g (g, not_S0);
=======
    // a = S0 (Apagado apenas no F e no P)
    buf buf_a (a, S0);

    // b = 1 no F(00), t(01) e L(11). 0 no P(10). Logo: b = ~(S1 AND ~S0)
    wire w_b;
    and and_b (w_b, S1, not_S0);
    not not_b (b, w_b);

    // c = 1 (O segmento 'c' fica apagado em todas essas letras)
    buf buf_c (c, 1'b1);

    // d = ~S0 (Apagado no t e no L)
    buf buf_d (d, not_S0);

    // e = 0 (O segmento 'e' fica aceso em todas as 4 letras!)
    buf buf_e (e, 1'b0);

    // f = 0 (O segmento 'f' também fica aceso em todas as 4 letras!)
    buf buf_f (f, 1'b0);

    // g = S1 AND S0 (Fica apagado no F, t, P e só apaga o LED no L)
    and and_g (g, S1, S0);
>>>>>>> 1fc15c7 (Trial Mode)

endmodule