/*Esse codigo em especifico esta mais complicado de se entender, mas ele compara digito a digito de A e B e depois compara as ordens de grandeza para achar aeqb (A equal to B)
agtb (A greater than B) e altb (A lower then B). Para isso eh usada uma sequencia de OR's e AND's relacionados as comparacoes individuais dos digitos x_n de A e B.*/

module compmag(a,b,aeqb,agtb,altb);
    input [6:0] a,b;
    output aeqb,agtb,altb;
    wire x_6 , x_5 , x_4 , x_3 , x_2 , x_1 , x_0;
    assign x_6 = ~(a[6] ^ b[6] );
    assign x_5 = ~(a[5] ^ b[5] );
    assign x_4 = ~(a[4] ^ b[4] );
    assign x_3 = ~(a[3] ^ b[3] );
    assign x_2 = ~(a[2] ^ b[2] );
    assign x_1 = ~(a[1] ^ b[1] );
    assign x_0 = ~(a[0] ^ b[0] );
    assign aeqb = x_6 & x_5 & x_4 & x_3 & x_2 & x_1 & x_0;
    assign agtb = a[6]&(~b[6]) | x_6&a[5]&(~b[5]) | x_6&x_5&a[4]&(~b[4]) | x_6&x_5&x_4&a[3]&(~b[3]) | x_6&x_5&x_4&x_3&a[2]&(~b[2]) | x_6&x_5&x_4&x_3&x_2&a[1]&(~b[1]) | x_6&x_5&x_4&x_3&x_2&x_1&a[0]&(~b[0]);
    assign altb = b[6]&(~a[6]) | x_6&b[5]&(~a[5]) | x_6&x_5&b[4]&(~a[4]) | x_6&x_5&x_4&b[3]&(~a[3]) | x_6&x_5&x_4&x_3&b[2]&(~a[2]) | x_6&x_5&x_4&x_3&x_2&b[1]&(~a[1]) | x_6&x_5&x_4&x_3&x_2&x_1&b[0]&(~a[0]);
endmodule