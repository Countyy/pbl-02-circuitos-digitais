module Timer_2s (
    input  clk_50MHz,
    input  rst_n,
    output tick_2s
);
    Div_Freq div (
        .clk_in (clk_50MHz),
        .rst_n  (rst_n),
        .clk_out(tick_2s)
    );
endmodule