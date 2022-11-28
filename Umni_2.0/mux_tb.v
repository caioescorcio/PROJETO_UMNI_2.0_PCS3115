/*Esse testbench valida a saida do multiplexador em uso com o timer*/

`timescale 1ns/100ps

module mux_tb;

    reg clk_tb;
    wire clk_timer;
    wire [3:0] saida_mux;
    integer counter = 1;

    timer1seg timer (.clk(clk_tb), .clk_out(clk_timer));
    mux uut (.clk(clk_timer), .saida(saida_mux));

    initial begin
        clk_tb <= 0;
        $monitor ("Saida multiplexador: %b, Tempo: %1d", saida_mux, counter); /*printa qual a saida do multiplexador a cada ciclo de tempo*/

    end

    always #1 begin
        clk_tb = ~clk_tb;
        counter = counter + 1;
    end

endmodule