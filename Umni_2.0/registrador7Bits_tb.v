`timescale 1ns/100ps

module registrador7Bits_tb;

    reg [6:0] A;
    wire [6:0] B;
    integer i;
    reg clock;

    registrador7Bits registrador (.entrada(A), .clk(clock), .saida(B));

    initial begin
        
        A <= 0;
        clock <= 0;

        $monitor ("Valor atual: %d, Valor Registrador: %d, CLOCK: %d", A, B, clock);    /*Para verificar se o registrador esta funcionando, sempre que o clock for de 0 para 1*/
                                                                                        /*o valor de B deveria ser o valor anterior de A*/
        for(i = 0; i < 128; i = i+1)begin
            #5
            A <= $random;   /*Cria um valor aleatorio para o A*/

        end
    end

    
    always #5 clock = ~clock;   /*Cria uma alternancia de clocks*/


endmodule