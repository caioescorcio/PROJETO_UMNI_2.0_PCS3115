/*Esse testbench recebe valores aleatorios de umidade, um clock, um botoa para ligar o LED e outro para ligar o Umidificador (que se alteram em determinados ciclos de clock
A partir dai, printa-se:

1: as umidade medidas e a sua media
2: a umidade registrada media (que eh a media das medias registradas nos "ultimos 4s")
3: baseado nessa umidade registrada, se ela estiver abaixo do parametro estabelecido - "UMIDADE_DESEJADA", que viria de um circuito externo, possivelmente uma database futuramente -
o umidificador e a LED interna deveriam ligar caso o usuario tenha apertado o botao de modo a liga-los. EX: desejado: 75, registrado: 67 => se eh para ligar o umidificador, o botao
para ligar deve ser pressionado (caso o umidificador esteja desligado) ou deve nao ser pressionado (caso o umidificador ja esteja ligado).
4: printa o que eh mostrado nos displays de 7 segmentos (cuja a traducao esta nos parametros abaixo)*/

`timescale 1ns/100ps

module UMNI_tb;

    parameter UMIDADE_DESEJADA = 70;    /*umidade desejada pelo usuario*/
    parameter POTENCIA_VAPORIZADOR = 90;    /*potencia concebida ao umidificador*/

    /*traducao para os displays*/
    parameter ZERO = 7'b1111110;
    parameter UM = 7'b0110000;
    parameter DOIS = 7'b1101101;
    parameter TRES = 7'b1111001;
    parameter QUATRO = 7'b0110011;
    parameter CINCO = 7'b1011011;
    parameter SEIS = 7'b0011111;
    parameter SETE = 7'b1110000;
    parameter OITO = 7'b1111111;
    parameter NOVE = 7'b1110011;

    reg [6:0] sensor1, sensor2, sensor3, sensor4, umidadeRef;
    reg [6:0] ajuste_de_modo;
    reg clk_geral, botao_LED, botao_on_off_tb;
    wire [6:0] pot_umidade, display1, display2, display3, med_atual, med_temp;
    wire LED_func, LED_int, umidificador_on_off, LED_int_ON, UMNI_ON;
    integer erros;

        UMNI circuito (.sensor1(sensor1), .sensor2(sensor2), .sensor3(sensor3), .sensor4(sensor4), .umidadeRef(umidadeRef), .clock_geral(clk_geral), 
        .ajuste_de_modo(ajuste_de_modo), .botao_LED(botao_LED), .botao_on_off(botao_on_off_tb), .pot_umidade(pot_umidade), .LED_func(LED_func), 
        .LED_int(LED_int), .display1_final(display1), .display2_final(display2), .display3_final(display3), .umidificador_on_off(umidificador_on_off),
         .umidade_atual_media(med_atual), .umidade_atual_temporal(med_temp), .LED_int_ligada(LED_int_ON), .umidificador_ligado(UMNI_ON));

    initial begin   /*imicia as variaveis*/

        clk_geral <= 0;
        botao_LED <= 0;
        botao_on_off_tb <= 0;
        erros = 0;
        
        umidadeRef <= UMIDADE_DESEJADA;
        ajuste_de_modo <= POTENCIA_VAPORIZADOR;
        
    end


    always #60 begin
        $monitor ("Sensores: %d %d %d %d\nMedia das ultimas 4 medias: %d,\n\n\nUmidade Registrada: %d, Umidade Desejada: %d\n\nPRESSIONOU Umidificador? %d, Liga umidificador: %d Umidificador Ligado? %d, com potencia %d\nPRESSIONOU LED? = %d, Liga LED: %d, LED interna Ligada: %d\n\nTUDO FUNCIONANDO? = %d\nDisplays: %b %b %b\n\nErros: %d\n\n\n", 
        sensor1, sensor2, sensor3, sensor4, med_atual, med_temp, umidadeRef, botao_on_off_tb, UMNI_ON, umidificador_on_off, pot_umidade, botao_LED, LED_int_ON, LED_int, LED_func, display3, display2, display1, erros);
        /*print para checkagem*/
        sensor1 = $random;
        sensor2 = $random;
        sensor3 = $random;
        sensor4 = $random;

        if(clk_geral == 1 && (((LED_int_ON == 1 && med_temp < umidadeRef && LED_int == 0) || (UMNI_ON == 1 && med_temp < umidadeRef && umidificador_on_off == 0) )) ||
                            (((LED_int_ON == 0 && med_temp < umidadeRef && LED_int == 1) || (UMNI_ON == 0 && med_temp < umidadeRef && umidificador_on_off == 1) )) ||
                            (((med_temp > umidadeRef && LED_int == 1) || (med_temp > umidadeRef && umidificador_on_off == 1) )))                                  /*Se a umidade atual for menor q a ideal (condicao para ligar a LED e o vaporizador) e o clock atualizar e o botao mandar essas duas */
            erros = erros+1;                                                                                                                                        /*funcionalidades nao ligarem, significa um erro*/
    end

    always #1 clk_geral = ~clk_geral;
    always #60 botao_LED = ~botao_LED;
    always #70 botao_on_off_tb = ~botao_on_off_tb;  /*alternancia entre os botoes e entre os clocks*/
endmodule
