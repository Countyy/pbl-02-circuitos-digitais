module Contador_Sensor (
    input sensor_in,       
    input reset,           
    output u3, u2, u1, u0, 
    output d1, d0,         
    output marcou_20
);

    wire vai_um;

    Div10 unidades (
        .clk_in(sensor_in),
        .rst_n(reset),
        .q3(u3), .q2(u2), .q1(u1), .q0(u0)
    );
    
    // DETECTOR DE BORDA DE DESCIDA DO Q3 (Quando cai de 1 para 0)
    // Isso garante que a dezena SÓ vai incrementar no final do ciclo da unidade
    detector_descida det_vai_um (
        .clk(sensor_in), // Usa o mesmo clock para sincronia
        .rst_n(reset),
        .entrada(u3),    // O MSB da unidade
        .saida(vai_um)
    );

    Div3 dezenas (
        .clk_in(vai_um), 
        .rst_n(reset),
        .q1(d1), .q0(d0),
        .clk_out(marcou_20) 
    );

endmodule