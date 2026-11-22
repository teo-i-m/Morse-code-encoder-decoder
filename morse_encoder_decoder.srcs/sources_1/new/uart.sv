`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2026 09:23:33 AM
// Design Name: 
// Module Name: uart_top
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


module uart(
    input clk,
    input uart_rx,
    output uart_tx
);

logic rst;
assign rst = 1'b0;

logic [7:0] rx_data;
logic       rx_valid;
logic       tx_busy;
logic       tx_start;

logic [7:0] tx_data;

uart_rx RX
(
    .clk(clk),
    .rst(rst),
    .rx(uart_rx),
    .data_out(rx_data),
    .data_valid(rx_valid)
);

uart_tx TX
(
    .clk(clk),
    .rst(rst),
    .data_in(tx_data),
    .start(tx_start),
    .tx(uart_tx),
    .busy(tx_busy)
);

always_ff @(posedge clk)
    begin
        if(rst)
        begin
            tx_start <= 0;
            tx_data <= 0;
        end
        else
            begin
                tx_start <= 1'b0;
                    if(rx_valid && !tx_busy)
                        begin
                            tx_data <= rx_data;
                            tx_start <= 1'b1;
                        end
            end
    end

endmodule