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


module comp_z_min(
    input logic [7:0]data,
    output logic out_z_min
    );
    
    always_comb 
        begin
            if (data < 123 )
                out_z_min = 1;
            else
                out_z_min = 0;
        end
        
endmodule
