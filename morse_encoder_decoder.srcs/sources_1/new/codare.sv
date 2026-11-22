`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 05:20:58 PM
// Design Name: 
// Module Name: codare
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


module codare(
    input logic [7:0]data_in,
    input logic rst,
    input logic clk,
    input logic fifo_empty,
    output logic out,
    output logic r_en_fsm
    );
    
    logic [7:0] scazator_out,mux_out;
    logic out_96, out_123;
    logic [4:0] morse_binar;
    logic [2:0] len;
    
    scazator_32 scazator(
    .data_in(data_in),
    .data_out(scazator_out)
    );
    
    comp_a_min comp_96(
    .data(data_in),
    .out_a_min(out_96)
    );
    
    comp_z_min comp_123(
    .data(data_in),
    .out_z_min(out_123)
    );
    
    mux_2b mux(
    .data_in0(data_in),
    .data_in1(scazator_out),
    .sel(out_96 & out_123),
    .data_out(mux_out)
    );
    
    binar binar(
    .data_in(mux_out),
    .morse_binar(morse_binar),
    .len(len)
    );
    
    morse_fsm fsm(
    .clk(clk),
    .rst(rst),
    .data_in(morse_binar),
    .len(len),
    .fifo_empty(fifo_empty),
    .out(out),
    .r_en_fsm(r_en_fsm)
    );
      
endmodule