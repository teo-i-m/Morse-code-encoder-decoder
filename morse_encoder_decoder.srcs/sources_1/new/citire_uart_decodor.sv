`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/25/2026 01:17:36 AM
// Design Name: 
// Module Name: citire_uart_decodor
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


module morse_ascii_to_pulse (
    input logic clk,
    input logic rst,
    input logic [7:0]rx_data,
    input logic rx_valid,
    output logic in_decode,
    output logic reset_decoder,
    output logic space_valid
);
 
    typedef enum logic [2:0] {
        STATE_COLLECT,
        STATE_HIGH,
        STATE_GAP,
        STATE_END_GAP,
        STATE_RESET_PULSE
    } state_t;
 
    state_t state;
 
    logic [4:0] cod;
    logic [2:0] buf_len;
    logic [2:0] sym_idx;
    logic [1:0] high_cnt;
    logic [1:0] low_cnt;
 
    assign in_decode = (state == STATE_HIGH);
 
    always_ff @(posedge clk) begin
        if (rst) begin
            state         <= STATE_COLLECT;
            cod           <= 5'b0;
            buf_len       <= 3'd0;
            sym_idx       <= 3'd0;
            high_cnt      <= 2'd0;
            low_cnt       <= 2'd0;
            reset_decoder <= 1'b0;
            space_valid   <= 1'b0;
        end else begin
            reset_decoder <= 1'b0;
            space_valid   <= 1'b0;
 
            case (state)
 
                STATE_COLLECT: begin
                    if (rx_valid) begin
                        case (rx_data)
 
                            8'h2E: begin
                                if (buf_len < 3'd5) begin
                                    cod[buf_len] <= 1'b0;
                                    buf_len      <= buf_len + 3'd1;
                                end
                            end
 
                            8'h2D: begin  
                                if (buf_len < 3'd5) begin
                                    cod[buf_len] <= 1'b1;
                                    buf_len      <= buf_len + 3'd1;
                                end
                            end
 
                            8'h20, 8'h0D, 8'h0A: begin  
                                if (buf_len > 3'd0) begin
                                    sym_idx  <= 3'd0;
                                    high_cnt <= cod[0] ? 2'd3 : 2'd1;
                                    state    <= STATE_HIGH;
                                end
                            end
 
                            8'h2F: begin
                                if (buf_len == 3'd0)
                                    space_valid <= 1'b1;
                            end
 
                            default: ; 
 
                        endcase
                    end
                end
 
                STATE_HIGH: begin
                    if (high_cnt == 2'd1) begin
                        if (sym_idx + 3'd1 < buf_len) begin
                            sym_idx  <= sym_idx + 3'd1;
                            high_cnt <= cod[sym_idx + 3'd1] ? 2'd3 : 2'd1;
                            state    <= STATE_GAP;
                        end else begin
                            low_cnt <= 2'd0;
                            state   <= STATE_END_GAP;
                        end
                    end else begin
                        high_cnt <= high_cnt - 2'd1;
                    end
                end
 
                STATE_GAP: begin
                    state <= STATE_HIGH;
                end
 
                STATE_END_GAP: begin
                    if (low_cnt == 2'd3)
                        state <= STATE_RESET_PULSE;
                    else
                        low_cnt <= low_cnt + 2'd1;
                end

                STATE_RESET_PULSE: begin
                    reset_decoder <= 1'b1;
                    buf_len       <= 3'd0;
                    sym_idx       <= 3'd0;
                    state         <= STATE_COLLECT;
                end
 
                default: state <= STATE_COLLECT;
 
            endcase
        end
    end
 
endmodule
