module Contador_Sensor (
<<<<<<< HEAD
	input sensor_in,       
   input reset,           
   output u3, u2, u1, u0, 
   output d1, d0,         
   output marcou_20
);

	 wire vai_um;

    Div10 unidades (
        .clk_in(sensor_in),
        .q3(u3), .q2(u2), .q1(u1), .q0(u0)
    );
=======
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
    

>>>>>>> 1fc15c7 (Trial Mode)
    and and_vai_um (vai_um, u3, u0);

    Div3 dezenas (
        .clk_in(vai_um), 
<<<<<<< HEAD
        .reset(reset),
=======
        .rst_n(reset),
>>>>>>> 1fc15c7 (Trial Mode)
        .q1(d1), .q0(d0),
        .clk_out(marcou_20) 
    );

endmodule