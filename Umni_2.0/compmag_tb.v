`timescale 1ns/100ps

module compmag_tb;
    reg [6:0] a_tb, b_tb;
    wire aeqb_tb, agtb_tb, altb_tb;
    integer i, erros;

    compmag uut(.a(a_tb), .b(b_tb), .aeqb(aeqb_tb), .agtb(agtb_tb), .altb(altb_tb));

    initial begin
    a_tb <= 0;
    b_tb <= 0; /*setta os valores de a_tb e b_tb para 0*/
    erros = 0;

    $monitor ("A = %d B = %d IGUAL = %d MAIOR = %d MENOR = %d \n ERROS = %d", a_tb, b_tb, aeqb_tb, agtb_tb, altb_tb, erros);  /*printa os valores para o teste e para a análise*/

    /*loop para testes com valores aleatórios*/
        for (i = 0; i < 500; i = i+1) begin
            #5      /* "#" indica a passagem de 5ns - que é o primeiro argumento do timescale*/
            a_tb <= $random;
            b_tb <= $random;    /*gera valores aleatórios de A e B afim de comparacao*/
            
            if((a_tb > b_tb && altb_tb == 1) || (a_tb < b_tb && agtb_tb == 1) || (a_tb == b_tb && aeqb_tb == 0))  /*teste de erros*/
                erros = erros + 1;
        end
        
    end

endmodule