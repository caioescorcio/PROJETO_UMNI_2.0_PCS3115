/*test bench do somador de 7 bits*/

`timescale 10ns/100ps   /*escala de tempo da passagem do circuito, valor usado no livro*/
module Somador8Bits_tb;

    reg [6:0] A, B;
    reg Carry_in;
    integer i;
    wire [7:0] SAIDA;
    wire Carry_out;

    /*settando as variáveis a serem usadas, reg's, que sao internas (manipuláveis) dentro do TB. Já os fios nao sao manipuláveis internamente, já que  sao funcoes dos reg's*/

    somador8Bits Soma (.S1(A), .S2(B), .C_in(Carry_in), .C_out(Carry_out), .resultado(SAIDA));  /*declara o somador de 7 bits como "Soma"*/

    initial begin
    A <= 0;
    B <= 0;
    Carry_in <= 0;  /*setta os valores de A, B e Carry_in para 0*/
    
    $monitor ("A = %d B = %d Carry_in = %d SAIDA = %d", A, B, Carry_in, SAIDA);  /*printa os valores para o teste, exceto o Carry_out, que nao faz diferenca no circuito como um todo*/
    
    /*loop para testes com valores aleatórios*/
        for (i = 0; i < 50; i = i+1) begin
            #5      /* "#" indica a passagem de 5ns - que é o primeiro argumento do timescale*/
            A <= $random;
            B <= $random;
            Carry_in <= $random;
        end
        
    end
    
endmodule/*test bench do somador de 7 bits*/

