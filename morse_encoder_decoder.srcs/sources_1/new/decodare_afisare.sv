`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 02:40:21 PM
// Design Name: 
// Module Name: codare_afisare
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// morse_serializer.sv
// Modul NOU - nu modific? niciun modul existent
// Prime?te morse_binar + len de la modulul binar (via codare)
// ?i trimite reprezentarea ASCII ('.' '-' ' ') prin UART

module codare_afisare (
    input  logic        clk,
    input  logic        rst,
    // De la modulul binar (acelea?i semnale ca spre morse_fsm)
    input  logic [4:0]  morse_binar,
    input  logic [2:0]  len,
    // Trigger: pulseaz? 1 ciclu când morse_fsm cite?te un caracter nou din FIFO
    input  logic        r_en_fsm,
    // Spre uart_tx
    input  logic        tx_busy,
    output logic [7:0]  tx_data,
    output logic        tx_start
);

    // ?? St?ri FSM ??????????????????????????????????????????????????
    typedef enum logic [1:0] {
        S_IDLE,   // A?teapt? trigger
        S_BUILD,  // Construie?te bufferul de caractere ASCII
        S_SEND,   // Trimite caracterul curent
        S_GAP     // A?teapt? ca UART s? termine înainte de next
    } state_t;

    state_t state;

    // ?? Buffer intern ???????????????????????????????????????????????
    // Max 5 simboluri morse + separator între simboluri + '\r' + '\n'
    // Ex: "- . - .\r\n" ? max 12 caractere ? 16 e safe
    logic [7:0] buf_chars [0:15];
    logic [3:0] buf_len;    // câte caractere are bufferul
    logic [3:0] buf_idx;    // indexul caracterului curent de trimis

    // Capt?m morse_binar ?i len în momentul trigger-ului
    logic [4:0] reg_morse;
    logic [2:0] reg_len;

    // ?? FSM principal ???????????????????????????????????????????????
    always_ff @(posedge clk) begin
        if (rst) begin
            state    <= S_IDLE;
            tx_start <= 1'b0;
            tx_data  <= 8'h00;
            buf_len  <= 4'd0;
            buf_idx  <= 4'd0;
            reg_morse <= 5'd0;
            reg_len   <= 3'd0;
        end else begin
            tx_start <= 1'b0;   // implicit: nu trimitem

            case (state)

                S_IDLE: begin
                    if (r_en_fsm) begin
                        reg_morse <= morse_binar;
                        reg_len   <= len;
                        state     <= S_BUILD;
                    end
                end

                S_BUILD: begin
                    // Construim bufferul cu simbolurile morse
                    // Conven?iile de codare din modulul binar:
                    //   bit=0 ? '.'   bit=1 ? '-'
                    // Bitul MSB al simbolului este la indexul [len-1]
                    // (acela?i mod în care le cite?te morse_fsm)
                    //
                    // Caz special: space (len==0, morse_binar==5'b01110)
                    if (reg_len == 3'd0) begin
                        // Spa?iu între cuvinte ? trimitem "/ " (conven?ie vizual?)
                        buf_chars[0] <= 8'h2F;  // '/'
                        buf_chars[1] <= 8'h20;  // ' '
                        buf_chars[2] <= 8'h0D;  // '\r'
                        buf_chars[3] <= 8'h0A;  // '\n'
                        buf_len <= 4'd4;
                    end else begin
                        // Construim: simbol_0 ' ' simbol_1 ' ' ... simbol_n '\r' '\n'
                        // max: 5 simboluri × 2 (simbol+spa?iu) + 2 (CRLF) = 12 chars
                        logic [3:0] pos;
                        pos = 4'd0;
                        for (int i = 0; i < 5; i++) begin
                            if (i < reg_len) begin
                                // Bitul de la pozi?ia [reg_len-1-i]
                                if (reg_morse[reg_len - 1 - i] == 1'b0)
                                    buf_chars[pos] <= 8'h2E;  // '.'
                                else
                                    buf_chars[pos] <= 8'h2D;  // '-'
                                pos = pos + 4'd1;
                                // Spa?iu dup? fiecare simbol (op?ional, pt lizibilitate)
                                // îl omitem pe ultimul ca s? nu avem spa?iu în plus
                                if (i < reg_len - 1) begin
                                    buf_chars[pos] <= 8'h20;  // ' '
                                    pos = pos + 4'd1;
                                end
                            end
                        end
                        // CRLF la final
                        buf_chars[pos]   <= 8'h0D;  // '\r'
                        buf_chars[pos+1] <= 8'h0A;  // '\n'
                        buf_len <= pos + 4'd2;
                    end

                    buf_idx <= 4'd0;
                    state   <= S_SEND;
                end

                S_SEND: begin
                    if (!tx_busy) begin
                        tx_data  <= buf_chars[buf_idx];
                        tx_start <= 1'b1;
                        state    <= S_GAP;
                    end
                end

                S_GAP: begin
                    // A?tept?m ca tx_busy s? urce (UART a preluat datele)
                    // apoi s? coboare (UART a terminat)
                    if (!tx_busy) begin
                        if (buf_idx + 4'd1 >= buf_len) begin
                            // Am trimis tot bufferul
                            state <= S_IDLE;
                        end else begin
                            buf_idx <= buf_idx + 4'd1;
                            state   <= S_SEND;
                        end
                    end
                end

                default: state <= S_IDLE;

            endcase
        end
    end

endmodule
