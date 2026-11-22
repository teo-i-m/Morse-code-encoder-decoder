`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2026 06:36:55 PM
// Design Name: 
// Module Name: fifo_tb
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


module fifo_tb();

logic clk;
logic rst;
logic [7:0] w_data;
logic w_en;
logic r_en;
logic [7:0] r_data;
logic full_o;
logic empty_o;

initial begin

    clk = 0;
    forever #1 clk = ~clk;

end

initial begin

    rst = 1;
    
    #5
    rst = 0;
    
    #10
    w_en = 1;
    
//    #1
    w_data = 1;
    
    #2
    w_data = 2;
    
    #2
    w_data = 3;
    
    #2
    w_data = 4;
    r_en = 1;
    
    
end


initial begin
    #70 $stop();
end


fifo fifo(
        .*
        );


endmodule
