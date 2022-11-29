/*somador completo de 1 bit. Esse arquivo nao possui testbench pois seu teste eh realizado pelo somador de 8 bits*/

module somador1Bit(A, B, Carry_in, Carry_out, soma);

input A, B, Carry_in;
output Carry_out, soma;

wire w1, w2, w3;

xor u0 (w1, A, B);
xor u1 (soma, w1, Carry_in);
and u2 (w2, Carry_in, w1);
and u3 (w3, A, B);
or u4 (Carry_out, w2, w3); 


endmodule
