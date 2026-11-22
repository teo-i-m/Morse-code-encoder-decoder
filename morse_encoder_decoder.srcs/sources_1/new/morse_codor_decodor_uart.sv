`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/26/2026 12:12:53 PM
// Design Name: 
// Module Name: morse_codor_decodor_uart
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


module morse_codor_decodor_uart (
    input logic clk,
    input logic uart_rx,
    output logic uart_tx
    );

localparam CLK_FREQ = 125_000_000;
localparam BAUDRATE = 115200;

logic rst;
assign rst = 1'b0;

logic [7:0] rx_data;
logic rx_valid;
logic [7:0] tx_data;
logic tx_start;
logic tx_busy;

uart_rx #(.CLK_FREQ(CLK_FREQ), .BAUDRATE(BAUDRATE)) RX (
.clk(clk), .rst(rst), .rx(uart_rx),
.data_out(rx_data), .data_valid(rx_valid)
);

uart_tx #(.CLK_FREQ(CLK_FREQ), .BAUDRATE(BAUDRATE)) TX (
.clk(clk), .rst(rst), .data_in(tx_data),
.start(tx_start), .tx(uart_tx), .busy(tx_busy)
);

logic fifo_w_en, fifo_full, fifo_empty, r_en_fsm;
logic [7:0] fifo_r_data;
logic is_space;

assign is_space  = (rx_data == 8'h20);
assign fifo_w_en = rx_valid & !fifo_full & !is_space;

fifo FIFO (
.clk(clk),
.rst(rst),
.w_data(rx_data),
.w_en(fifo_w_en),
.r_en(r_en_fsm),
.r_data(fifo_r_data),
.full(fifo_full),
.empty(fifo_empty)
);

logic morse_bit;

top_verificare_codare CODOR (
.data_in(fifo_r_data),
.rst(rst),
.clk(clk),
.fifo_empty(fifo_empty),
.out(morse_bit),
.r_en_fsm(r_en_fsm)
);

logic [7:0] decoded_char;
logic decoded_valid;

fsm_decodare DECODOR (
.clk(clk),
.rst(rst),
.in(morse_bit),
.out(decoded_char),
.valid(decoded_valid)
);

logic rx_char_invalid;

verificare_caracter verificare_rx (
.data(rx_data),
.rst(rst),
.reset_nou(rx_char_invalid)
);

logic [7:0] echo_buf;
logic echo_pend;
logic [7:0] dec_buf;
logic dec_pend;

always_ff @(posedge clk) 
    begin
        tx_start <= 0;
        tx_data  <= 8'h00;
        
        if (rx_valid & is_space) 
            begin
                echo_buf  <= 32;
                echo_pend <= 1;
            end 
        else if (rx_valid & !is_space & !rx_char_invalid) 
            begin
                echo_buf  <= rx_data;
                echo_pend <= 1;
            end

        if (decoded_valid && decoded_char != 32) 
            begin
                dec_buf  <= decoded_char;
                dec_pend <= 1;
            end

        if (!tx_busy && !tx_start) 
            begin
                if (echo_pend) 
                    begin
                        tx_data   <= echo_buf;
                        tx_start  <= 1;
                        echo_pend <= 0;
                    end 
                else if (dec_pend) 
                    begin
                        tx_data  <= dec_buf;
                        tx_start <= 1;
                        dec_pend <= 0;
                    end
            end

        if (rst) 
            begin
                echo_buf <= 0;
                echo_pend <= 0;
                dec_buf <= 0;
                dec_pend <= 0;
            end
    end

endmodule