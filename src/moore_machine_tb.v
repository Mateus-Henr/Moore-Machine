`timescale 1ns / 1ps
`include "moore_machine.v"

module moore_machine_tb;
    reg clk, rst;
    reg [7:0] entrada;
    wire [3:0] saida;

    parameter C0 = 8'b10000000,
              C1 = 8'b11111000,
              C2 = 8'b11000000,
              C3 = 8'b11011100,
              C4 = 8'b11101010,
              C5 = 8'b11001110,
              C6 = 8'b11110001,
              C7 = 8'b11010101,
              C8 = 8'b11100011;

    parameter S0 = 4'b0000,
              S1 = 4'b0001,
              S2 = 4'b0010,
              S3 = 4'b0011,
              S4 = 4'b0100,
              S5 = 4'b0101,
              S6 = 4'b1000,
              S7 = 4'b1001,
              S8 = 4'b1010;

    moore_machine machine(entrada, clk, rst, saida);

    //Inicialização do monitor
    initial
        $monitor("time = %d | Entrada: %b | Saida: %b", $time, entrada, saida);

    initial
    begin
        clk = 1'b1;
        forever #2.5 clk = ~clk;
    end

    initial
    begin
        rst = 1'b0;

        $display("Primeiro teste C0 -> C1 -> C2 -> C3 -> C4 -> C5 -> C8 (reset 0) == S8");

        #10 entrada = C0;

        #10 entrada = C1;

        #10 entrada = C2;

        #10 entrada = C3;

        #10 entrada = C4;

        #10 entrada = C5;

        #10 entrada = C8;

        #10 if (saida == S8) $display("PASSOU\n");


        // Resetando a máquina
        #10 rst = ~rst;
        #10 rst = ~rst;


        $display("\nSegundo Teste - C2 -> C3 -> C4 -> C8 (reset 0) == S8");

        #10 entrada = C2;

        #10 entrada = C3;

        #10 entrada = C4;

        #10 entrada = C8;

        #10 if (saida == S8) $display("PASSOU\n");


        // Resetando a máquina
        #10 rst = ~rst;
        #10 rst = ~rst;


        $display("\nSegundo Teste - C3 -> C6 (reset 0) == S6");

        #10 entrada = C3;

        #10 entrada = C6;

        #10 if (saida == S6) $display("PASSOU\n");


        // Resetando a máquina
        #10 rst = ~rst;
        #10 rst = ~rst;


        $display("\nTerceiro Teste - C1 -> C2 -> C5 (reset 0) == S7");
        
        #10 entrada = C1;

        #10 entrada = C2;

        #10 entrada = C5;

        #10 if (saida == S7) $display("PASSOU\n");


        // Setando reset como 1.
        #10 rst = ~rst;

        
        $display("\nQuarto Teste - C3 -> C4 -> C5 (reset 1) == S0");

        #10 entrada = C3;

        #10 entrada = C4;

        #10 entrada = C5;

        #10 if (saida == S0) $display("PASSOU\n");
        

        // Resetando a máquina com reset 1
        #10 rst = ~rst;
        #10 rst = ~rst;


        $display("\nQuinto Teste - C2 -> C3 -> C4 -> C6 (reset 1) == S0");

        #10 entrada = C2;

        #10 entrada = C3;

        #10 entrada = C4;

        #10 entrada = C6;

        #10 if (saida == S0) $display("PASSOU\n");


        $finish;
    end


endmodule