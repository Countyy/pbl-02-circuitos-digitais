module Mux (input e1, e2, e3, e4, M1, M0, output s);
	wire not_M1, not_M0;
	not (not_M1, M1);
	not (not_M0, M0);
	
	wire s1, s2, s3, s4;
	and and_1(s1, e1, not_M1, not_M0);
	and and_2(s2, e2, not_M1, M0);
	and and_3(s3, e3, M1, not_M0);
	and and_4(s4, e4, M1, M0);
	
	or or_s(s, s1, s2, s3, s4);
endmodule