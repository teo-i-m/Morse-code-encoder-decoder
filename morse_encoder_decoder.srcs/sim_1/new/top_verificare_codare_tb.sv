`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 10:29:17 PM
// Design Name: 
// Module Name: top_verificare_codare_tb
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


module top_verificare_codare_tb();

logic [7:0]data_in;
logic reset;
logic clk;
logic out;

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end

initial begin

reset = 0;
data_in = "A";

#17
reset = 1;
//data_in = "B";
#1

reset = 0;
data_in = "B";
//data_in = "B";

//#5
//data_in = "B";

//#25
//data_in = "?";
end

initial begin
    #70 $stop();
end

top_verificare_codare DUT(
        .*
        );
endmodule
