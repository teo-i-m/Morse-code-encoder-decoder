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


module comp_A_maj(
    input logic [7:0]data,
    output logic out_A_maj
    );
    
    always_comb 
        begin
            if (data > 64 )
                out_A_maj = 1;
            else
                out_A_maj = 0;
        end
        
endmodule
