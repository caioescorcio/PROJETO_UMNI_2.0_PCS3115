/*Nesse modulo, o multiplexador altera entre 4 saidas sempre que ha passagem de clock*/

module mux (clk, saida);

    input clk;
    output reg [3:0] saida;
    reg [1:0]count;
    
    initial begin 
        count <= 0; /*inicializa o contador*/
        saida <= 4'b0001;   
    end

    always @ (posedge clk) begin

        count = count + 1;
        if(count == 0) assign saida = 4'b0001;
        if(count == 1) assign saida = 4'b0010;
        if(count == 2) assign saida = 4'b0100;
        if(count == 3) assign saida = 4'b1000;  /*altera entre 4 fios dos registradores, cada fio corresponde a um clock de registrador*/

    end



endmodule