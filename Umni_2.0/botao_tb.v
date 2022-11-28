`timescale 10ns/100ps
module botao_tb;
    reg clk_tb,press_tb;
    wire detect_tb;

    botao uut(.clk(clk_tb), .press(press_tb), .detect(detect_tb));

    initial begin
        clk_tb = 0;
        press_tb = 0;

        $monitor ("clock: %d\nBotao pressionado = %d Saida = %d",clk_tb,press_tb,detect_tb); /*Se o botao for pressionado a saida alterna o seu valor, depois da borda de clock */
    end

    always #5 clk_tb = ~clk_tb;
    always #20 press_tb = ~press_tb;    /*alternancia do clock e do valor do pressionar do botao*/

endmodule