/*Nesse código temos uma estrutura que usa 3 displays de 7 segmentos para registrar os números da umidade de 0 a 100*/
/*Para isso, usamos o código padrão do display de 7 segmentos, mas aplicado a 3 saídas e com uma entrada de 7 bits.*/
module decoderbindec(bin, display1, display2, display3);

    input [6:0] bin;
    output reg [6:0] display1, display2, display3;
    
    integer digito1;
    integer digito2;
    integer digito3; /*Divisao das unidades do numero em binario*/

    /*nos parametros: a, b, c, d, e, f, g sao representados nessa ordem em binario*/

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

     always @(bin) begin

    digito1 = bin%10;
    digito2 = (bin/10)%10;
    digito3 = (bin/100)%10; 

           case (digito3)

            4'b0000: display3 = ZERO;
            4'b0001: display3 = UM;
            4'b0010: display3 = DOIS;
            4'b0011: display3 = TRES;
            4'b0100: display3 = QUATRO;
            4'b0101: display3 = CINCO;
            4'b0110: display3 = SEIS;
            4'b0111: display3 = SETE;
            4'b1000: display3 = OITO;
            4'b1001: display3 = NOVE;  /*Numeros da casa das Unidades*/

            default : display3 = ZERO;
           endcase

           case (digito2)

            4'b0000: display2 = ZERO;
            4'b0001: display2 = UM;
            4'b0010: display2 = DOIS;
            4'b0011: display2 = TRES;
            4'b0100: display2 = QUATRO;
            4'b0101: display2 = CINCO;
            4'b0110: display2 = SEIS;
            4'b0111: display2 = SETE;
            4'b1000: display2 = OITO;
            4'b1001: display2 = NOVE;  /*Numeros da casa das Dezenas*/

            default : display2 = ZERO;
           endcase

           case (digito1)

            4'b0000: display1 = ZERO;
            4'b0001: display1 = UM;
            4'b0010: display1 = DOIS;
            4'b0011: display1 = TRES;
            4'b0100: display1 = QUATRO;
            4'b0101: display1 = CINCO;
            4'b0110: display1 = SEIS;
            4'b0111: display1 = SETE;
            4'b1000: display1 = OITO;
            4'b1001: display1 = NOVE;  /*Numeros da casa das Centenas*/

            default : display1 = ZERO;
           endcase

    end     
                
endmodule