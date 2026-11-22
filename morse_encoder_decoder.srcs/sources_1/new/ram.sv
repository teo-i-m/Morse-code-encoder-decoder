`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 11:24:08 PM
// Design Name: 
// Module Name: ram
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


module ram(
    input logic clk,
    input logic [7:0]data_in,
    input logic write_enable,
    input logic [16:0]write_address_in,
    input logic read_enable,
    input logic len,
    output logic [7:0]data_out,
    output logic [16:0]write_address_out,
    output logic read_address  
    );
    
    logic[7:0]mem[0:16];
    logic [4:0]len;
    
    assign write_address_out = 0;
    
    always@(posedge clk) 
    begin
        if (write_enable)
            begin
                mem[write_address_in] <=data_in;
//                assign write_address_out = write_address_out + 1;
                ++write_address_out;
                ++len;
                assign data_out = data_in;
            end
        else if(read_enable)
            begin
                assign data_out = mem[write_address_in-len];
                --len;
            end
    end
    
endmodule
