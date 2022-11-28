/*somador de 8 bits, S1 e S2 sao os sensores e a saída é a soma das suas leituras*/

module somador8Bits(S1, S2, C_in, C_out, resultado);

    input [6:0] S1, S2;
    input C_in;
    output [7:0] resultado;
    output C_out;

    wire fio_1, fio_2, fio_3, fio_4, fio_5, fio_6, fio_7;

    /*Apesar de que o circuito feito com somadores poderia ser substituido por um Carry Look-Ahead ou outros tipos
    de somadores, mas o Ripple-Carry pareceu mais simples para o proposto, pois os atrados das portas lógicas não
    implicariam num pior desempenho para o projeto como um todo.*/

    somador1Bit somador1 (.A(S1[0]), .B(S2[0]), .Carry_in(C_in), .soma(resultado[0]), .Carry_out(fio_1));
    somador1Bit somador2 (.A(S1[1]), .B(S2[1]), .Carry_in(fio_1), .soma(resultado[1]), .Carry_out(fio_2));
    somador1Bit somador3 (.A(S1[2]), .B(S2[2]), .Carry_in(fio_2), .soma(resultado[2]), .Carry_out(fio_3));
    somador1Bit somador4 (.A(S1[3]), .B(S2[3]), .Carry_in(fio_3), .soma(resultado[3]), .Carry_out(fio_4));
    somador1Bit somador5 (.A(S1[4]), .B(S2[4]), .Carry_in(fio_4), .soma(resultado[4]), .Carry_out(fio_5));
    somador1Bit somador6 (.A(S1[5]), .B(S2[5]), .Carry_in(fio_5), .soma(resultado[5]), .Carry_out(fio_6));
    somador1Bit somador7 (.A(S1[6]), .B(S2[6]), .Carry_in(fio_6), .soma(resultado[6]), .Carry_out(fio_7));
            assign resultado[7] = fio_7;
            assign C_out = 0;

    /*O somador feito foi de 8 Bits, pois como os sensores padrão para medida de umidade vão de 0 a 100 (valores em 7 Bits),
    a soma desses valores chegaria até no máximo 200, que é um valor abrangido por um número 8 Bits em binário*/

endmodule