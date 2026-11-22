`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 10:05:33 PM
// Design Name: 
// Module Name: top_verificare_codare
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


module top_verificare_codare(
    input logic [7:0]data_in,
    input logic rst,
    input logic clk,
    input logic fifo_empty,
    output logic out,
    output logic r_en_fsm
    );
    
    logic reset_nou;
    
    verificare_caracter verificare(
    .data(data_in),
    .rst(rst),
    .reset_nou(reset_nou)
    );
    
    codare codare(
    .data_in(data_in),
    .rst(reset_nou),
    .clk(clk),
    .fifo_empty(fifo_empty),
    .out(out),
    .r_en_fsm(r_en_fsm)
    );
    
endmodule