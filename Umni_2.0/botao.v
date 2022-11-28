/*Botoa da forma em maquina de estados, 4 estados:
1: saida 0, botao de 0 para 1
2: saida 1, botao de 0 para 1
3: saida 0, botao de 1 para 0
4: saida 1, botao de 1 para 0

funcimaneto se da por: se ele pressiona o botao, depois de uma borda de clock, a saida muda para o seu oposto*/

module botao (clk,press,detect);
    input clk, press;
    output reg detect;
    
    reg [1:0] estados;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    initial begin
        estados <= S0;
    end

    always @ (posedge clk) begin

        case(estados)

            S0: if(press == 1'b1) estados <= S1;
            S1: if(press == 1'b0) estados <= S2;
            S2: if(press == 1'b1) estados <= S3;
            S3: if(press == 1'b0) estados <= S0;

        endcase

    end

    always @ (estados) begin

        case (estados)

        S0, S3: detect = 1'b0;
        S1, S2: detect = 1'b1;

        endcase

    end   


endmodule


