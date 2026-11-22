`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 01:24:45 PM
// Design Name: 
// Module Name: comp_0
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


module nor_4b(
    input logic in_space,
    input logic in_0,
    input logic in_9,
    input logic in_A_maj,
    input logic in_Z_maj,
    input logic in_a_min,
    input logic in_z_min,
    output logic out
    );
    
    assign out =~(in_space | in_0 & in_9 | in_A_maj & in_Z_maj | in_a_min & in_z_min);
    
endmodule
