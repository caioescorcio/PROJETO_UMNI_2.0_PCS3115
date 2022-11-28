/*Esse timer funciona da seguinte maneira: considerando que um periodo de ciclo corresponde a 1/10 de segundo, a cada mudanca de valor do clock
a variavel counter aumenta em 1. Assim quando chega a 10/10 ciclos (1s) ele libera um sinal de clock para o circuito*/

module timer1seg(clk,clk_out);
    input clk;
    output reg clk_out;
    integer counter = 0;

always @(posedge clk) begin
       
    counter = counter + 1;

    case (counter)

        10 : clk_out = 1;
        default: clk_out = 0;
        
    endcase

    if(counter == 10)
        counter = 0;

end


endmodule