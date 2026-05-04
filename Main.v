module Main (
    input Fumaca, Luz, Presenca, Calor, M1, M0, clk_50MHz, rst_n,
    
    output a, b, c, d, e, f, g, L1, L2, L3, L4, Lclk, 
    
    output [6:0] hex0, 
    output [6:0] hex1, 
    output [6:0] hex2, 
    output [6:0] hex3, 
    output trava_led   
);

    supply1 vcc; 
    supply0 gnd; 

    wire clk_50Hz; 
    wire tick_2s;
    
    Div_Freq gerador_clocks (
        .clk_in(clk_50MHz), 
        .rst_n(rst_n), 
        .clk_out(tick_2s),       
        .clk_50hz(clk_50Hz) 
    );

    wire not_Luz, not_Presenca;
    not (not_Luz, Luz);
    not (not_Presenca, Presenca);
    
    wire a_mn, b_mn, c_mn, d_mn, e_mn, f_mn, g_mn, L1_mn, L2_mn, L3_mn;
    wire a_md, b_md, c_md, d_md, e_md, f_md, g_md, L1_md, L2_md, L3_md, L4_md;
    wire a_mm, b_mm, c_mm, d_mm, e_mm, f_mm, g_mm, L1_mm, L2_mm, L3_mm, L4_mm;
    wire a_ef, b_ef, c_ef, d_ef, e_ef, f_ef, g_ef, L1_ef, L2_ef, L3_ef, L4_ef;

    decNormal modo_normal (
        .F(Fumaca), .L(not_Luz), .P(not_Presenca), .C(Calor),
        .a(a_mn), .b(b_mn), .c(c_mn), .d(d_mn), .e(e_mn), .f(f_mn), .g(g_mn),
        .L1(L1_mn), .L2(L2_mn), .L3(L3_mn)
    );
    buf (L4_mn, gnd); 

    decDiag modo_diagnostico (
        .F(Fumaca), .L(not_Luz), .P(not_Presenca), .C(Calor),
        .a(a_md), .b(b_md), .c(c_md), .d(d_md), .e(e_md), .f(f_md), .g(g_md),
        .la(L3_md), .lb(L2_md), .lc(L1_md), .ld(L4_md)
    );

    decManu modo_manutencao (
        .a(a_mm), .b(b_mm), .c(c_mm), .d(d_mm), .e(e_mm), .f(f_mm), .g(g_mm),
        .la(L1_mm), .lb(L2_mm), .lc(L3_mm), .ld(L4_mm)
    );

    decEmer modo_emergencia (
        .a(a_ef), .b(b_ef), .c(c_ef), .d(d_ef), .e(e_ef), .f(f_ef), .g(g_ef),
        .la(L1_ef), .lb(L2_ef), .lc(L3_ef), .ld(L4_ef)
    );

    Mux mux_a (.e1(a_mn), .e2(a_md), .e3(a_mm), .e4(a_ef), .M1(M1), .M0(M0), .s(a));
    Mux mux_b (.e1(b_mn), .e2(b_md), .e3(b_mm), .e4(b_ef), .M1(M1), .M0(M0), .s(b));
    Mux mux_c (.e1(c_mn), .e2(c_md), .e3(c_mm), .e4(c_ef), .M1(M1), .M0(M0), .s(c));
    Mux mux_d (.e1(d_mn), .e2(d_md), .e3(d_mm), .e4(d_ef), .M1(M1), .M0(M0), .s(d));
    Mux mux_e (.e1(e_mn), .e2(e_md), .e3(e_mm), .e4(e_ef), .M1(M1), .M0(M0), .s(e));
    Mux mux_f (.e1(f_mn), .e2(f_md), .e3(f_mm), .e4(f_ef), .M1(M1), .M0(M0), .s(f));
    Mux mux_g (.e1(g_mn), .e2(g_md), .e3(g_mm), .e4(g_ef), .M1(M1), .M0(M0), .s(g));

    Mux mux_L1 (.e1(L1_mn), .e2(L1_md), .e3(L1_mm), .e4(L1_ef), .M1(M1), .M0(M0), .s(L1));
    Mux mux_L2 (.e1(L2_mn), .e2(L2_md), .e3(L2_mm), .e4(L2_ef), .M1(M1), .M0(M0), .s(L2));
    Mux mux_L3 (.e1(L3_mn), .e2(L3_md), .e3(L3_mm), .e4(L3_ef), .M1(M1), .M0(M0), .s(L3));
    Mux mux_L4 (.e1(L4_mn), .e2(L4_md), .e3(L4_mm), .e4(L4_ef), .M1(M1), .M0(M0), .s(L4));


    // =========================================================
    // 3. PIPELINES DO PBL 2 (DEBOUNCE -> BORDA -> CONTA)
    // =========================================================
    
    // --- SENSOR F ---
    wire F_limpo, F_pulso, marcou_F;
    wire [3:0] uni_F; wire [1:0] dez_F;
    debouncer deb_F (.clk(clk_50Hz), .rst_n(rst_n), .ruidoso(Fumaca), .filtrado(F_limpo));
    detector_subida det_F (.clk(clk_50Hz), .rst_n(rst_n), .entrada(F_limpo), .saida(F_pulso));
    Contador_Sensor cont_F (.sensor_in(F_pulso), .reset(rst_n), .u3(uni_F[3]), .u2(uni_F[2]), .u1(uni_F[1]), .u0(uni_F[0]), .d1(dez_F[1]), .d0(dez_F[0]), .marcou_20(marcou_F));

    // --- SENSOR T ---
    wire T_limpo, T_pulso, marcou_T;
    wire [3:0] uni_T; wire [1:0] dez_T;
    debouncer deb_T (.clk(clk_50Hz), .rst_n(rst_n), .ruidoso(Calor), .filtrado(T_limpo));
    detector_subida det_T (.clk(clk_50Hz), .rst_n(rst_n), .entrada(T_limpo), .saida(T_pulso));
    Contador_Sensor cont_T (.sensor_in(T_pulso), .reset(rst_n), .u3(uni_T[3]), .u2(uni_T[2]), .u1(uni_T[1]), .u0(uni_T[0]), .d1(dez_T[1]), .d0(dez_T[0]), .marcou_20(marcou_T));

    // --- SENSOR P ---
    wire P_limpo, P_pulso, marcou_P;
    wire [3:0] uni_P; wire [1:0] dez_P;
    debouncer deb_P (.clk(clk_50Hz), .rst_n(rst_n), .ruidoso(Presenca), .filtrado(P_limpo));
    detector_subida det_P (.clk(clk_50Hz), .rst_n(rst_n), .entrada(P_limpo), .saida(P_pulso));
    Contador_Sensor cont_P (.sensor_in(P_pulso), .reset(rst_n), .u3(uni_P[3]), .u2(uni_P[2]), .u1(uni_P[1]), .u0(uni_P[0]), .d1(dez_P[1]), .d0(dez_P[0]), .marcou_20(marcou_P));

    // --- SENSOR L ---
    wire L_limpo, L_pulso, marcou_L;
    wire [3:0] uni_L; wire [1:0] dez_L;
    debouncer deb_L (.clk(clk_50Hz), .rst_n(rst_n), .ruidoso(Luz), .filtrado(L_limpo));
    detector_subida det_L (.clk(clk_50Hz), .rst_n(rst_n), .entrada(L_limpo), .saida(L_pulso));
    Contador_Sensor cont_L (.sensor_in(L_pulso), .reset(rst_n), .u3(uni_L[3]), .u2(uni_L[2]), .u1(uni_L[1]), .u0(uni_L[0]), .d1(dez_L[1]), .d0(dez_L[0]), .marcou_20(marcou_L));


    // =========================================================
    // 4. TRAVAMENTO E SELEÇÃO DE TELA
    // =========================================================
    wire trava_ativa, trava_s1, trava_s0;
    wire tela_s1, tela_s0;

    Reg_Trava modulo_trava (
        .clk(clk_50Hz), .rst_n(rst_n), 
        .marcou_F(marcou_F), .marcou_T(marcou_T), .marcou_P(marcou_P), .marcou_L(marcou_L), 
        .trava_ativa(trava_ativa), .s1_trava(trava_s1), .s0_trava(trava_s0)
    );

    Seletor_Display controlador_tela (
        .clk(clk_50Hz), .rst_n(rst_n), .tick(tick_2s), 
        .trava(1'b1), .trava_s1(M1), .trava_s0(M0), 
        .s1(tela_s1), .s0(tela_s0)
    );


    // =========================================================
    // 5. MUX DE DADOS E DISPLAYS (ESTRUTURAL)
    // =========================================================
	 wire [3:0] display_uni;
    wire [1:0] display_dez;

    // CORREÇÃO: Ordem mapeada -> e0=L(00), e1=P(01), e2=T(10), e3=F(11)
    
    // MUX das Unidades
    Mux_Contador mux_u0 (.s1(tela_s1), .s0(tela_s0), .e0(uni_L[0]), .e1(uni_P[0]), .e2(uni_T[0]), .e3(uni_F[0]), .saida(display_uni[0]));
    Mux_Contador mux_u1 (.s1(tela_s1), .s0(tela_s0), .e0(uni_L[1]), .e1(uni_P[1]), .e2(uni_T[1]), .e3(uni_F[1]), .saida(display_uni[1]));
    Mux_Contador mux_u2 (.s1(tela_s1), .s0(tela_s0), .e0(uni_L[2]), .e1(uni_P[2]), .e2(uni_T[2]), .e3(uni_F[2]), .saida(display_uni[2]));
    Mux_Contador mux_u3 (.s1(tela_s1), .s0(tela_s0), .e0(uni_L[3]), .e1(uni_P[3]), .e2(uni_T[3]), .e3(uni_F[3]), .saida(display_uni[3]));

    // MUX das Dezenas
    Mux_Contador mux_d0 (.s1(tela_s1), .s0(tela_s0), .e0(dez_L[0]), .e1(dez_P[0]), .e2(dez_T[0]), .e3(dez_F[0]), .saida(display_dez[0]));
    Mux_Contador mux_d1 (.s1(tela_s1), .s0(tela_s0), .e0(dez_L[1]), .e1(dez_P[1]), .e2(dez_T[1]), .e3(dez_F[1]), .saida(display_dez[1]));

    // HEX2: Letra do Sensor (F, C, P ou L)
    Decoder_Letras dec_letra (
        .S1(tela_s1), .S0(tela_s0), 
        .a(hex2[0]), .b(hex2[1]), .c(hex2[2]), .d(hex2[3]), .e(hex2[4]), .f(hex2[5]), .g(hex2[6])
    );

    // HEX0: Valor da Unidade
    Decoder_Num dec_un (
        .I3(display_uni[3]), .I2(display_uni[2]), .I1(display_uni[1]), .I0(display_uni[0]), 
        .a(hex0[0]), .b(hex0[1]), .c(hex0[2]), .d(hex0[3]), .e(hex0[4]), .f(hex0[5]), .g(hex0[6])
    );
    
    // HEX1: Valor da Dezena
    wire [3:0] dez_4bits;
    buf b_d0 (dez_4bits[0], display_dez[0]);
    buf b_d1 (dez_4bits[1], display_dez[1]);
    buf b_d2 (dez_4bits[2], gnd); 
    buf b_d3 (dez_4bits[3], gnd); 
    Decoder_Num dec_dz (
        .I3(dez_4bits[3]), .I2(dez_4bits[2]), .I1(dez_4bits[1]), .I0(dez_4bits[0]), 
        .a(hex1[0]), .b(hex1[1]), .c(hex1[2]), .d(hex1[3]), .e(hex1[4]), .f(hex1[5]), .g(hex1[6])
    );

    // HEX3: Letra "C" (Fixa)
    buf b_c0(hex3[0], gnd); buf b_c1(hex3[1], vcc); buf b_c2(hex3[2], vcc); 
    buf b_c3(hex3[3], gnd); buf b_c4(hex3[4], gnd); buf b_c5(hex3[5], gnd); 
    buf b_c6(hex3[6], vcc);

    // Alarme Visual
    buf b_led_trava (trava_led, trava_ativa);
endmodule