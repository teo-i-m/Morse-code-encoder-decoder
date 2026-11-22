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


module comp_a_min(
    input logic [7:0]data,
    output logic out_a_min
    );
    
    always_comb 
        begin
            if (data > 96 )
                out_a_min = 1;
            else
                out_a_min = 0;
        end
        
endmodule
