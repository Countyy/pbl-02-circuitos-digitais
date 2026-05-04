module Mux_Contador (
	 input e0, e1, e2, e3, s1, s0,
    output saida
);
	 wire not_s1, not_s0;
    wire w0, w1, w2, w3;

    not (not_s1, s1);
    not (not_s0, s0);

    and (w0, e0, not_s1, not_s0); // 00
    and (w1, e1, not_s1, s0);     // 01
    and (w2, e2, s1, not_s0);     // 10
    and (w3, e3, s1, s0);         // 11

    or (saida, w0, w1, w2, w3);
endmodule