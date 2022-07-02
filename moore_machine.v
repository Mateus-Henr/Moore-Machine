module moore_machine(entrada, clk, rst, saida);
    input clk, rst;

    // 8-bits input
    input [7:0] entrada;

    // 4-bits output
    output reg [3:0] saida;

    // Registrador de estado (Register)
    reg [3:0] state;

    // Characteres (Characters)
    parameter C0 = 8'b10000000,
              C1 = 8'b11111000,
              C2 = 8'b11000000,
              C3 = 8'b11011100,
              C4 = 8'b11101010,
              C5 = 8'b11001110,
              C6 = 8'b11110001,
              C7 = 8'b11010101,
              C8 = 8'b11100011;

    // Saídas - Estados (States)
    parameter S0 = 4'b0000,
              S1 = 4'b0001,
              S2 = 4'b0010,
              S3 = 4'b0011,
              S4 = 4'b0100,
              S5 = 4'b0101,
              S6 = 4'b1000,
              S7 = 4'b1001,
              S8 = 4'b1010;


    // Inicialização da máquina (Initialization)
    initial
    begin
        state <= S0;
    end


    // Primeiro procedimento - Próximo estado (First state)
    always @(posedge clk, posedge rst)
    begin
        if (rst) state <= S0;
        else
        begin
            case (state)
                S0:
                begin
                    if (entrada == C1) state <= S1;
                    if (entrada == C2) state <= S2;
                    if (entrada == C3) state <= S3;
                    if (entrada == C4) state <= S4;
                    if (entrada == C5) state <= S5;
                end
                
                S1:
                begin
                    if (entrada == C2) state <= S2;
                    if (entrada == C6) state <= S6;
                    if (entrada == C7 || entrada == C3 || entrada == C4 || entrada == C5) state <= S7;
                end

                S2:
                begin
                    if (entrada == C1) state <= S1;
                    if (entrada == C3) state <= S3;
                    if (entrada == C6) state <= S6;
                    if (entrada == C7 || entrada == C4 || entrada == C5) state <= S7;
                end

                S3:
                begin
                    if (entrada == C2) state <= S2;
                    if (entrada == C4) state <= S4;
                    if (entrada == C6) state <= S6;
                    if (entrada == C7 || entrada == C1 || entrada == C5) state <= S7;
                end

                S4:
                begin
                    if (entrada == C3) state <= S3;
                    if (entrada == C5) state <= S5;
                    if (entrada == C7 || entrada == C1 || entrada == C2) state <= S7;
                    if (entrada == C8) state <= S8;
                end

                S5:
                begin
                    if (entrada == C4) state <= S4;
                    if (entrada == C7 || entrada == C1 || entrada == C2 || entrada == C3) state <= S7;
                    if (entrada == C8) state <= S8;
                end
            endcase
        end
    end


    // Segundo procedimento - Saídas (Outputs)
    always @(state)
    begin
        case (state)
            S0: saida <= S0;
            S1: saida <= S1;
            S2: saida <= S2;
            S3: saida <= S3;
            S4: saida <= S4;
            S5: saida <= S5;
            S6: saida <= S6;
            S7: saida <= S7;
            S8: saida <= S8;
        endcase
    end

endmodule