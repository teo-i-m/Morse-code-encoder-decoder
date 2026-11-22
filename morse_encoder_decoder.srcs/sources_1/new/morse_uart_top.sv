`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 12:29:47 AM
// Design Name: 
// Module Name: morse_uart_top
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


module morse_uart_top (
    input  logic clk,
    input  logic sw0,
    input  logic sw1,
    input  logic uart_rx,
    output logic uart_tx,
    output logic led0,
    output logic led1
);
 
    localparam CLK_FREQ = 125_000_000;
    localparam BAUDRATE = 115200;
 
    logic rst;
    assign rst = 0;
 
    logic [7:0]rx_data;
    logic rx_valid;
    logic [7:0]tx_data;
    logic tx_start;
    logic tx_busy;
 
    uart_rx #(.CLK_FREQ(CLK_FREQ), .BAUDRATE(BAUDRATE)) RX (
    .clk(clk),
    .rst(rst),
    .rx(uart_rx),
    .data_out(rx_data),
    .data_valid(rx_valid)
    );
 
    uart_tx #(.CLK_FREQ(CLK_FREQ), .BAUDRATE(BAUDRATE)) TX (
    .clk(clk),
    .rst(rst),
    .data_in(tx_data),
    .start(tx_start),
    .tx(uart_tx),
    .busy(tx_busy)
    );
 
    logic fifo_w_en,fifo_full, fifo_empty, r_en_fsm;
    logic [7:0]fifo_r_data;
    logic morse_out_bit;
 
    assign fifo_w_en = sw0 & rx_valid & !fifo_full;
 
    fifo fifo(
    .clk(clk),
    .rst(rst | sw1),
    .w_data(rx_data),
    .w_en(fifo_w_en),
    .r_en(r_en_fsm),
    .r_data(fifo_r_data),
    .full(fifo_full),
    .empty(fifo_empty)
    );
 
    top_verificare_codare top_verificare_codare(
    .data_in(fifo_r_data),
    .rst(rst | sw1),
    .clk(clk),
    .fifo_empty(fifo_empty),
    .out(morse_out_bit),
    .r_en_fsm(r_en_fsm)
    );
 
    logic [7:0]fifo_r_data_norm;
    logic l_minuscula;
    assign l_minuscula = (fifo_r_data > 96) && (fifo_r_data < 123);
    assign fifo_r_data_norm = l_minuscula ? (fifo_r_data - 32) : fifo_r_data;
 
    logic [4:0] morse_binar_top;
    logic [2:0] len_top;
 
    binar binar_uart(
    .data_in(fifo_r_data_norm),
    .morse_binar(morse_binar_top),
    .len(len_top)
    );
 
    logic [7:0]ser_tx_data;
    logic ser_tx_start;
 
    codare_afisare codare_afisare(
    .clk(clk),
    .rst(rst | sw1),
    .morse_binar(morse_binar_top),
    .len(len_top),
    .r_en_fsm(r_en_fsm),
    .tx_busy(tx_busy),
    .tx_data(ser_tx_data),
    .tx_start(ser_tx_start)
    );
 
    logic morse_pulse;
    logic decoder_rst_pulse;
    logic space_valid;
    logic [7:0]decoded_char;
    logic decoded_valid;
 
    morse_ascii_to_pulse morse_ascii_to_pulse(
    .clk(clk),
    .rst(rst | sw0),
    .rx_data(rx_data),
    .rx_valid(rx_valid & sw1 & !sw0),
    .in_decode(morse_pulse),
    .reset_decoder(decoder_rst_pulse),
    .space_valid(space_valid)
    );
 
    fsm_decodare fsm_decodare(
    .clk(clk),
    .rst(rst | sw0 | decoder_rst_pulse),
    .in(morse_pulse),
    .out(decoded_char),
    .valid(decoded_valid)
    );
 
    always_ff @(posedge clk) 
        begin
            tx_start <= 0;
            tx_data <= 0;
 
            if (sw0 & !sw1) 
                begin
                    tx_data  <= ser_tx_data;
                    tx_start <= ser_tx_start;
 
                end 
            else if(sw1 & !sw0) 
                begin
                    if (!tx_busy) 
                        begin
                            if (decoded_valid) 
                                begin
                                    tx_data  <= decoded_char;
                                    tx_start <= 1;
                                end 
                            else if (space_valid) 
                                begin
                                    tx_data  <= 32;
                                    tx_start <= 1;
                                end
                        end
                end
        end
 
    assign led0 = sw0;
    assign led1 = sw1;
 
endmodule