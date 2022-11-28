`timescale 10ns/100ps
module timer4seg_tb;

    reg clk_tb;
    wire clk_out_tb;
    integer counter;

    timer1seg timer (.clk(clk_tb),.clk_out(clk_out_tb));

    initial begin
        clk_tb <= 0;    /*Esse testbench funciona assim: a cada ciclo de 240 no contador, */
        counter = 1;    /*deve-se colocar uma borda de clock no timer, pois estipulou-se que um ciclo de clock do sistema correpsonderia a 1/240 segundos*/


        $monitor ("clock = %d \n clk_out = %d \n counter: %d",clk_tb,clk_out_tb, counter);
    end
    always #1 begin
        clk_tb = ~clk_tb;
        counter = counter +1;
    end

endmodule