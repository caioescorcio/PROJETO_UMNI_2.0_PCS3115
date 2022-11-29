

`timescale 1ns/100ps

module decoderbindec_tb;

    reg [6:0] numero;
    wire [6:0] seg1, seg2, seg3;
    integer i, erros;

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

    decoderbindec display_3_digitos (.bin(numero), .display1(seg1), .display2(seg2), .display3(seg3));

    initial begin

        numero <= 7'b0;
        erros = 0;

        $monitor ("DISPLAY 1 = %b  \nDISPLAY 2 = %b\nDISPLAY 3 = %b\nNUMERO EM DECIMAL = %d & ERROS = %d", seg1, seg2, seg3, numero, erros);  /*printa o que esta nos displays*/

        for(i = 0; i < 128; i = i + 1) begin

            #5  /*Esse if checa se o numero de cada segmento corresponde ao numero do valor de entrada*/
            if(((numero%10 == 0 && seg1 != ZERO) ||
               (numero%10 == 1 && seg1 != UM) ||
               (numero%10 == 2 && seg1 != DOIS) ||
               (numero%10 == 3 && seg1 != TRES) ||
               (numero%10 == 4 && seg1 != QUATRO) ||
               (numero%10 == 5 && seg1 != CINCO) ||
               (numero%10 == 6 && seg1 != SEIS) ||
               (numero%10 == 7 && seg1 != SETE) ||
               (numero%10 == 8 && seg1 != OITO) ||
               (numero%10 == 9 && seg1 != NOVE )) ||

               (((numero/10)%10 == 0 && seg2 != ZERO)||
               ((numero/10)%10 == 1 && seg2 != UM) ||
               ((numero/10)%10 == 2 && seg2 != DOIS) ||
               ((numero/10)%10 == 3 && seg2 != TRES) ||
               ((numero/10)%10 == 4 && seg2 != QUATRO) ||
               ((numero/10)%10 == 5 && seg2 != CINCO) ||
               ((numero/10)%10 == 6 && seg2 != SEIS) ||
               ((numero/10)%10 == 7 && seg2 != SETE) ||
               ((numero/10)%10 == 8 && seg2 != OITO) ||
               ((numero/10)%10 == 9 && seg2 != NOVE )) ||

               (((numero/100)%10 == 0 && seg3 != ZERO) ||
               ((numero/100)%10 == 1 && seg3 != UM) ||
               ((numero/100)%10 == 2 && seg3 != DOIS) ||
               ((numero/100)%10 == 3 && seg3 != TRES) ||
               ((numero/100)%10 == 4 && seg3 != QUATRO) ||
               ((numero/100)%10 == 5 && seg3 != CINCO) ||
               ((numero/100)%10 == 6 && seg3 != SEIS) ||
               ((numero/100)%10 == 7 && seg3 != SETE) ||
               ((numero/100)%10 == 8 && seg3 != OITO) ||
               ((numero/100)%10 == 9 && seg3 != NOVE) ))

               erros = erros + 1;

                numero <= i;

        end


    end
      
endmodule