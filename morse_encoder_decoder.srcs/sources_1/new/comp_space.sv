`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 07:32:15 AM
// Design Name: 
// Module Name: comp_space
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


module comp_space(
    input logic [7:0]data,
    output logic out_space
    );
    
    always_comb 
        begin
            if (data == 32)
                out_space = 1;
            else 
                out_space = 0; 
        end
        
endmodule
