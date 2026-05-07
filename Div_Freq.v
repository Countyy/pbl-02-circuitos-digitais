<<<<<<< HEAD
module Div_Freq(
    input clk_in,
    output clk_out
);
    wire sdiv1, sdiv2, sdiv3, sdiv4, sdiv5, sdiv6, sdiv7;

    Div10 div1 (.clk_in(clk_in), .clk_out(sdiv1));
    Div10 div2 (.clk_in(sdiv1), .clk_out(sdiv2));
    Div10 div3 (.clk_in(sdiv2), .clk_out(sdiv3));
    Div10 div4 (.clk_in(sdiv3), .clk_out(sdiv4));
    Div10 div5 (.clk_in(sdiv4), .clk_out(sdiv5));
    Div10 div6 (.clk_in(sdiv5), .clk_out(sdiv6));
    Div10 div7 (.clk_in(sdiv6), .clk_out(sdiv7));
    Div10 div8 (.clk_in(sdiv7), .clk_out(clk_out));
endmodule
=======
module Div_Freq (
    input  clk_in,
    input  rst_n,
    output clk_out,
	 output clk_50hz
);
    wire s1, s2, s3, s4, s5, s6, s7;
 
    Div10 d1 (.clk_in(clk_in), .rst_n(rst_n), .clk_out(s1));
    Div10 d2 (.clk_in(s1),     .rst_n(rst_n), .clk_out(s2));
    Div10 d3 (.clk_in(s2),     .rst_n(rst_n), .clk_out(s3));
    Div10 d4 (.clk_in(s3),     .rst_n(rst_n), .clk_out(s4));
    Div10 d5 (.clk_in(s4),     .rst_n(rst_n), .clk_out(s5));
    Div10 d6 (.clk_in(s5),     .rst_n(rst_n), .clk_out(s6));
    Div10 d7 (.clk_in(s6),     .rst_n(rst_n), .clk_out(s7));
    Div10 d8 (.clk_in(s7),     .rst_n(rst_n), .clk_out(clk_out));
	 
	 buf b_50hz (clk_50hz, s6);
endmodule
 
>>>>>>> 1fc15c7 (Trial Mode)
