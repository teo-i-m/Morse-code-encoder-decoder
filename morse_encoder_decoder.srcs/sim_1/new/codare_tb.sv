`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 06:57:18 PM
// Design Name: 
// Module Name: codare_tb
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


module codare_tb();

logic [7:0]data_in;
logic clk,reset;
logic out;

initial begin
    clk = 0;
    forever #1 clk =~clk;
end

initial begin
reset = 0;
data_in = 64;

//#5 
//data = 65;

#50
reset = 1;
#2
reset = 0;
data_in = 84;
#30 $stop;

end

codare DUT( 
        .*
        );
        
endmodule
