module Decoder_Num (
    input I3, I2, I1, I0,
    output a, b, c, d, e, f, g
);

    wire nI3, nI2, nI1, nI0;
    
    not inv3 (nI3, I3);
    not inv2 (nI2, I2);
    not inv1 (nI1, I1);
    not inv0 (nI0, I0);

    wire w_a1, w_a2;
    and and_a1 (w_a1, nI3, nI2, nI1, I0);
    and and_a2 (w_a2, nI3, I2, nI1, nI0);
    or or_a (a, w_a1, w_a2);

    wire w_b1, w_b2;
    and and_b1 (w_b1, nI3, I2, nI1, I0);
    and and_b2 (w_b2, nI3, I2, I1, nI0);
    or or_b (b, w_b1, w_b2);

    and and_c1 (c, nI3, nI2, I1, nI0);

    wire w_d1, w_d2, w_d3;
    and and_d1 (w_d1, nI3, nI2, nI1, I0);
    and and_d2 (w_d2, nI3, I2, nI1, nI0);
    and and_d3 (w_d3, nI3, I2, I1, I0);
    or or_d (d, w_d1, w_d2, w_d3);

    wire w_e1, w_e2;
    and and_e1 (w_e1, nI3, I0);
    and and_e2 (w_e2, nI3, I2, nI1);
    or or_e (e, w_e1, w_e2);

    wire w_f1, w_f2, w_f3;
    and and_f1 (w_f1, nI3, nI2, I0);
    and and_f2 (w_f2, nI3, nI2, I1);
    and and_f3 (w_f3, nI3, I1, I0);
    or or_f (f, w_f1, w_f2, w_f3);

    wire w_g1, w_g2;
    and and_g1 (w_g1, nI3, nI2, nI1);
    and and_g2 (w_g2, nI3, I2, I1, I0);
    or or_g (g, w_g1, w_g2);

endmodule