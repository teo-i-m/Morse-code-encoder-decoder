`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 02:42:57 PM
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


module codare_afisare(
    input logic clk,
    input logic rst,
    input logic [4:0]morse_binar,
    input logic [2:0]len,
    input logic r_en_fsm,
    input logic tx_busy,
    output logic [7:0]tx_data,
    output logic tx_start
);
 
    typedef enum logic [2:0] {
        STATE_IDLE,
        STATE_DATA,
        STATE_BUILD,
        STATE_SEND,
        STATE_WAIT,
        STATE_GAP
    } state_t;
 
    state_t state;
 
    logic [7:0]buf_chars [0:15];
    logic [3:0]buf_len;
    logic [3:0]buf_idx;
    logic [4:0]reg_morse;
    logic [2:0]reg_len;
 
    always_ff @(posedge clk) 
        begin
            if (rst) 
                begin
                    state <= STATE_IDLE;
                    tx_start <= 0;
                    tx_data <= 0;
                    buf_len <= 0;
                    buf_idx <= 0;
                    reg_morse <= 0;
                    reg_len <= 0;
                end
            else 
                begin
                    tx_start <= 0;
 
                    case (state)
                        STATE_IDLE:  
                            if (r_en_fsm) 
                                state <= STATE_DATA;
 
                        STATE_DATA: 
                            begin
                                reg_morse <= morse_binar;
                                reg_len <= len;
                                state <= STATE_BUILD;
                            end
 
                        STATE_BUILD: 
                            begin
                                if (reg_len == 0) 
                                    begin
                                        buf_chars[0] <= "/";
                                        buf_chars[1] <= 8'h0D;
                                        buf_chars[2] <= 8'h0A; 
                                        buf_len <= 3;
                                    end 
                                else 
                                    begin
                                        buf_chars[0] <= (reg_morse[reg_len-1]==0) ? "." : "-";
                                        if (reg_len == 1) 
                                            begin
                                                buf_chars[1] <= 8'h0D; 
                                                buf_chars[2] <= 8'h0A;
                                                buf_len <= 3;
                                            end 
                                        else 
                                            begin
                                                buf_chars[1] <= 32;
                                                buf_chars[2] <= (reg_morse[reg_len - 2]== 0) ? "." : "-";
                                                if (reg_len == 2) 
                                                    begin
                                                        buf_chars[3] <= 8'h0D; buf_chars[4] <= 8'h0A;
                                                        buf_len <= 5;
                                                    end 
                                                else 
                                                    begin
                                                        buf_chars[3] <= 32;
                                                        buf_chars[4] <= (reg_morse[reg_len - 3]==0) ? "." : "-";
                                                        if (reg_len == 3) 
                                                            begin
                                                                buf_chars[5] <= 8'h0D;
                                                                buf_chars[6] <= 8'h0A;
                                                                buf_len <= 7;
                                                            end 
                                                        else 
                                                            begin
                                                                buf_chars[5] <= 32;
                                                                buf_chars[6] <= (reg_morse[reg_len - 4]==0) ? "." : "-";
                                                                if (reg_len == 4) 
                                                                    begin
                                                                        buf_chars[7] <= 8'h0D;
                                                                        buf_chars[8] <= 8'h0A;
                                                                        buf_len <= 9;
                                                                    end 
                                                                else 
                                                                    begin
                                                                        buf_chars[7] <= 32;
                                                                        buf_chars[8] <= (reg_morse[0]==0) ? "." : "-";
                                                                        buf_chars[9] <= 8'h0D;
                                                                        buf_chars[10] <= 8'h0A;
                                                                        buf_len <= 11;
                                                                    end
                                                            end
                                                    end
                                            end
                                    end
                                    buf_idx <= 0;
                                    state   <= STATE_SEND;
                            end
 
                        STATE_SEND: 
                            begin
                                if (!tx_busy) 
                                    begin
                                        tx_data  <= buf_chars[buf_idx];
                                        tx_start <= 1;
                                        state    <= STATE_WAIT;
                                    end
                            end
 
                        STATE_WAIT: 
                            state <= STATE_GAP;
 
                        STATE_GAP: 
                            begin
                                if (!tx_busy) 
                                    begin
                                        if (buf_idx + 1 >= buf_len)
                                            state <= STATE_IDLE;
                                        else 
                                            begin 
                                                buf_idx <= buf_idx + 1; 
                                                state <= STATE_SEND; end
                                            end
                                    end
 
                        default: state <= STATE_IDLE;
                    endcase
                end
        end
 
endmodule