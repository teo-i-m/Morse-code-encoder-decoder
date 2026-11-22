`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 08:29:25 PM
// Design Name: 
// Module Name: top_fifo_verificare_codare
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


module top_fifo_verificare_codare(
    input logic clk,
    input logic rst,
    input logic [7:0] w_data,
    input logic w_en,
    output logic out,
    output logic r_en_fsm,
    output logic full
    );
    
    logic [7:0] r_data;
    logic empty;
    
    fifo fifo(
    .clk(clk),
    .rst(rst),
    .w_data(w_data),
    .w_en(w_en),
    .r_en(r_en_fsm),
    .r_data(r_data),
    .full(full),
    .empty(empty)
    );
    
    top_verificare_codare top_verificare_codare(
    .data_in(r_data),
    .rst(rst),
    .clk(clk),
    .fifo_empty(empty),
    .out(out),
    .r_en_fsm(r_en_fsm)
    );
    
endmodule
