`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 04:31:59 PM
// Design Name: 
// Module Name: mux_2b
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


module mux_2b(
    input logic [7:0]data_in0,
    input logic [7:0]data_in1,
    input logic sel,
    output logic [7:0]data_out
    );
    
    always_comb 
        begin
            case(sel)
                0: data_out = data_in0;
                1: data_out = data_in1;
            endcase
        end
        
endmodule
