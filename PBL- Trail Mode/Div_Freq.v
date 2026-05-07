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
 