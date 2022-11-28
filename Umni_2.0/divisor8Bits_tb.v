/*Assim como o codigo para o divisor foi simples, o seu testbench tambem sera. Ele gera valores aleatorios para a entrada e printa a saida*/

`timescale 1ns/100ps

module divisor8Bits_tb;

    reg [7:0] A;
    wire [6:0] A_div;

    divisor8Bits divisor (.A(A), .A_div(A_div));

    initial begin
        A <= 0;

        $monitor ("Valor de A: %d, Valor de A_div: %d", A, A_div);

    end

    always #5 A <= $random;

endmodule