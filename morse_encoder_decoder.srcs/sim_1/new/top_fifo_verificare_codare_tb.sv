`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 08:44:32 PM
// Design Name: 
// Module Name: top_fifo_verificare_codare_tb
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


module top_fifo_verificare_codare_tb(

    );
    
    logic clk;
    logic rst;
    logic [7:0] w_data;
    logic w_en;
    logic [7:0] r_data;
    logic out;
//    logic full_o;
//    logic empty_o;
    logic r_en_fsm;
    logic full;
    
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
    
    rst = 1;
    #2
    rst = 0;
    @(negedge clk);
    w_en = 1;
    
    @(negedge clk);
    w_data = "A";
    @(negedge clk);
    w_data = "D";
//    @(negedge clk);
//    w_data = 32;
    @(negedge clk);
    w_data = "E";
    @(negedge clk);
    w_data = "H";
    @(negedge clk);
    w_data = "I";
    @(negedge clk);
    w_data = "N";
    @(negedge clk);
    w_data = "O";
    @(negedge clk);
    w_data = "R";
    @(negedge clk);
    w_data = "S";
    @(negedge clk);
    w_data = "T";
    #3
    
    @(negedge clk);
    w_en = 0;
    
    end

    initial begin
        #200 $stop();
    end
    
    top_fifo_verificare_codare encoder(
        .*
        );
        
endmodule
