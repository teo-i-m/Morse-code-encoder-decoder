`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 07:43:40 PM
// Design Name: 
// Module Name: fsm_tb
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


module fsm_tb();

logic [4:0]data_in;
logic [2:0]len;
logic reset,clk;
logic out;
    
initial begin
    clk = 0;
    forever #1 clk = ~clk;
end    
 
initial begin
reset = 0;
data_in = 5'b00111;
len = 4;
#35
reset = 1;
#3
reset = 0;
data_in = 5'b00000;
len = 4;
#50 $stop();
end    
morse_fsm DUT(
        .*
        );
      
endmodule
