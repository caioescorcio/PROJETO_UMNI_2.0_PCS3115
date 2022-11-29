/*Esse modulo de registrador eh bem padrao, existe uma entrada e uma saida, sempre que existe posedge no clock, o valor da saida atualiza para o da entrada
Para isso sao utilizadas duas variaveis auxiliares: valor_atual, que eh assinalado para a saida, e o valor_prox, que eh assinalado para o valor_atual no posedge*/

module registrador7Bits(entrada, clk, saida);

    input [6:0] entrada;
    input clk;
    output [6:0] saida;

    reg [6:0] valor_atual, valor_prox; /*Variaveis locais*/

    always @(posedge clk) begin /*Sempre que ha borda de subida no clock, o valor atual eh atualizado para o proximo valor*/
        valor_atual <= valor_prox;
    end

    always @(entrada)begin   /*sempre que houver algum valor na entrada valido*/
        valor_prox = entrada;
    end

    assign saida = valor_atual; /*no fim das operacoes o valor registrado (saida) eh o mesmo atual*/
endmodule