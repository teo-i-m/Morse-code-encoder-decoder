`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 04:30:23 PM
// Design Name: 
// Module Name: scazator_32
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


module scazator_32(
    input logic [7:0]data_in,
    output logic [7:0]data_out
    );
    
    assign data_out = data_in - 32;
    
endmodule
