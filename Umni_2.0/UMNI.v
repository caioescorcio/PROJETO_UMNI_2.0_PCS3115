/*Para explicar esse circuito, temos o diagrama no relatório com tudo o que ele faz, mas basicamente, ele traca uma media atual, registra ela em 4s diferentes e depois faz uma media dessa media "temporal",
se ela estiver abaixo do desejado pelo usuario, - e o botao para ativar o umidificador ou a LED interna estiverem ON - ele ligara tais dispositivos. Alem disso, temos 3 displays de 7 segmentos que mostram
a media registrada em decimal (0 a 100)*/



module UMNI(sensor1, sensor2, sensor3, sensor4, umidadeRef, clock_geral, ajuste_de_modo, botao_LED, botao_on_off, pot_umidade, LED_func, LED_int, display1_final, display2_final, display3_final, umidificador_on_off, umidade_atual_media, umidade_atual_temporal,LED_int_ligada, umidificador_ligado);


    input [6:0] sensor1, sensor2, sensor3, sensor4, umidadeRef; /*input dos valores dos sensore e da umidade desejada*/
    input [6:0] ajuste_de_modo; /*input da potencia exercida pelo vaporizador*/
    input clock_geral, botao_LED, botao_on_off; /*input do clock do sistema e dos botoes para LED e para o funcionamento*/
    output [6:0] pot_umidade, display1_final, display2_final, display3_final, umidade_atual_media, umidade_atual_temporal;  /*output da potencia exercida pelo umidificador, dos displays e dos valores da umidade registrada e media (usados apenas para testbenchs)*/
    output LED_func, LED_int, umidificador_on_off, LED_int_ligada, umidificador_ligado; /*output das LED's e do estado atual do umidificador + condicoes de se o usuario atualmente quer ou nao que a LED e o umidificador estejam ligados*/

    wire [7:0] Soma1, Soma2, Soma_geral, Soma1_reg, Soma2_reg, Soma_geral_reg;  /*Fios internos, melhor explicados no diagrama*/
    wire [6:0] med1, med2, med_geral;
    wire [6:0] med1_reg, med2_reg, med_geral_reg;
    wire [6:0] umidade_atual, umidade_desejada;
    wire [6:0] reg1, reg2, reg3, reg4;
    wire [3:0] escolhe_reg;   
    wire clock_1s, clock_4s, cond_atual, LIGA_UMNI_FIO, LED_int_FIO;
    wire C_out_aux1, C_out_aux2, C_out_aux3, C_out_aux4, C_out_aux5, C_out_aux6, aeqb_comp, agtb_comp;  /*Fios auxiliares, para evitar dar erro nas funcoes*/

    and LIGA_LED (LED_int, cond_atual, LED_int_FIO);
    and LIGA_UMNI (umidificador_on_off, cond_atual, LIGA_UMNI_FIO); /*Portas AND's, explicadas no diagrama*/

    assign LED_func = cond_atual;
    assign pot_umidade = ajuste_de_modo;
    assign umidade_atual_media = med_geral;
    assign umidade_atual_temporal = umidade_atual;
    assign LED_int_ligada = LED_int_FIO;
    assign umidificador_ligado = LIGA_UMNI_FIO;     /*Alguns fios que servem de output para o testbench, nao estao no diagrama de quadros*/

    timer1seg timer1 (.clk(clock_geral), .clk_out(clock_1s));
    timer4seg timer4 (.clk(clock_geral), .clk_out(clock_4s));   /*circuitos dos timers*/

        mux escolhe_reg_mux (.clk(clock_1s), .saida(escolhe_reg));  /*circuito dos registradores/escolha dos registradores*/

    somador8Bits soma1(.S1(sensor1), .S2(sensor2), .C_in(1'b0), .C_out(C_out_aux1), .resultado(Soma1)); 
    somador8Bits soma2(.S1(sensor3), .S2(sensor4), .C_in(1'b0), .C_out(C_out_aux2), .resultado(Soma2)); /*somadores dos sensores*/
        divisor8Bits divisor1 (.A(Soma1), .A_div(med1));
        divisor8Bits divisor2 (.A(Soma2), .A_div(med2));    /*medias dos sensores*/

    somador8Bits soma_geral(.S1(med1), .S2(med2), .C_in(1'b0), .C_out(C_out_aux3), .resultado(Soma_geral)); /*soma geral*/
        divisor8Bits divisor_geral (.A(Soma_geral), .A_div(med_geral)); /*media geral*/

    somador8Bits soma1_reg(.S1(reg1), .S2(reg2), .C_in(1'b0), .C_out(C_out_aux4), .resultado(Soma1_reg));
    somador8Bits soma2_reg(.S1(reg3), .S2(reg4), .C_in(1'b0), .C_out(C_out_aux5), .resultado(Soma2_reg));   /*somas dos valores dos registradores*/
        divisor8Bits divisor1_reg (.A(Soma1_reg), .A_div(med1_reg));
        divisor8Bits divisor2_reg (.A(Soma2_reg), .A_div(med2_reg));    /*medias dos registradores*/

    somador8Bits soma_geral_reg(.S1(med1_reg), .S2(med2_reg), .C_in(1'b0), .C_out(C_out_aux6), .resultado(Soma_geral_reg)); /*soma geral registrada*/
        divisor8Bits divisor_geral_reg (.A(Soma_geral_reg), .A_div(med_geral_reg)); /*media geral registrada*/

    registrador7Bits registrador1 (.entrada(med_geral), .clk(escolhe_reg[0]), .saida(reg1));    /*registradores usados para as umidades medidas*/
    registrador7Bits registrador2 (.entrada(med_geral), .clk(escolhe_reg[1]), .saida(reg2));
    registrador7Bits registrador3 (.entrada(med_geral), .clk(escolhe_reg[2]), .saida(reg3));
    registrador7Bits registrador4 (.entrada(med_geral), .clk(escolhe_reg[3]), .saida(reg4));
    registrador7Bits registrador5 (.entrada(med_geral_reg), .clk(clock_4s), .saida(umidade_atual));
    
    registrador7Bits reg_umidade_referencia (.entrada(umidadeRef), .clk(clock_geral), .saida(umidade_desejada));    /*registrador para umidade referencia*/

    compmag comparador (.a(umidade_atual), .b(umidade_desejada), .aeqb(aeqb_comp), .agtb(agtb_comp), .altb(cond_atual));    /*comparador de umidades*/

    decoderbindec display (.bin(umidade_atual), .display1(display1_final), .display2(display2_final), .display3(display3_final)) ;  /*displays*/

    botao botao_do_LED (.clk(clock_geral), .press(botao_LED), .detect(LED_int_FIO));
    botao botoa_de_funcionamento (.clk(clock_geral), .press(botao_on_off), .detect(LIGA_UMNI_FIO)); /*botoes*/

endmodule