// Conta eventos de 0 a 20.
// u3..u0 : digito das unidades (BCD via Div10, conta 0-9)
// d1..d0 : digito das dezenas (conta 0-2 via Div3)
// marcou_20: ativo quando dezena=2 E unidade=0 (exatamente no 20)
//
// vai_um: a descida de clk_out do Div10 (q3 indo 1->0) marca virada 9->0.
// NOT(clk_out) faz a borda de subida coincidir com esse momento.
module Contador_Sensor (
    input  sensor_in,
    input  reset,
    output u3, u2, u1, u0,
    output d1, d0,
    output marcou_20
);
    wire clk_out_unidades;
    wire clk_dez;
    wire nd0, nu0, nu1, nu2, nu3;
 
    Div10 unidades (
        .clk_in (sensor_in),
        .rst_n  (reset),
        .clk_out(clk_out_unidades),
        .q3(u3), .q2(u2), .q1(u1), .q0(u0)
    );
 
    not inv_carry (clk_dez, clk_out_unidades);
 
    Div3 dezenas (
        .clk_in (clk_dez),
        .rst_n  (reset),
        .q1(d1), .q0(d0)
    );
 
    not nd0_inv (nd0, d0);
    not nu0_inv (nu0, u0);
    not nu1_inv (nu1, u1);
    not nu2_inv (nu2, u2);
    not nu3_inv (nu3, u3);
 
    and u_m20 (marcou_20, d1, nd0, nu3, nu2, nu1, nu0);
 
endmodule