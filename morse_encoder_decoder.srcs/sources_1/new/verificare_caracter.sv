`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 01:51:31 PM
// Design Name: 
// Module Name: verificare_caracter
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


module verificare_caracter(
    input logic [7:0]data,
    input logic rst,
    output logic reset_nou
    );
    
    logic out_space;
    logic out_0;
    logic out_9;
    logic out_A_maj;
    logic out_Z_maj;
    logic out_a_min;
    logic out_z_min;
    logic out_nor;
    
    comp_space comp_space(
    .data(data),
    .out_space(out_space)
    );
    
    comp_0 comp_0(
    .data(data),
    .out_0(out_0)
    );
    
    comp_9 comp_9(
    .data(data),
    .out_9(out_9)
    );
    
    comp_A_maj comp_A_maj(
    .data(data),
    .out_A_maj(out_A_maj)
    );
    
    comp_Z_maj comp_Z_maj(
    .data(data),
    .out_Z_maj(out_Z_maj)
    );
    
    comp_a_min comp_a_min(
    .data(data),
    .out_a_min(out_a_min)
    );
    
    comp_z_min comp_z_min(
    .data(data),
    .out_z_min(out_z_min)
    );
    
    nor_4b nor_4b(
    .in_space(out_space),
    .in_0(out_0),
    .in_9(out_9),
    .in_A_maj(out_A_maj),
    .in_Z_maj(out_Z_maj),
    .in_a_min(out_a_min),
    .in_z_min(out_z_min),
    .out(out_nor)
    );
    
    assign reset_nou = out_nor | rst;
     
endmodule
