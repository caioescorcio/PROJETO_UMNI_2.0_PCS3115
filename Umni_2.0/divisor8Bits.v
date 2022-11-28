/*Nesse circuito, por motivos de tempo e espaço, optou-se por nao implementar um circuito de divisao binaria completo, pois sua complexidade demandaria um tempo muito grande
e, como as provas estao chegando, nossa equipe nao conseguiu elaborar um circuito completo para divisao de 8 bits*/

module divisor8Bits(A, A_div);

    input [7:0] A;
    output [6:0] A_div;

    assign A_div = A/2'b10; /*divide A/2*/

endmodule