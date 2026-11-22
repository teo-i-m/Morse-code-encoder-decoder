`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2026 07:03:29 PM
// Design Name: 
// Module Name: fifo
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


module fifo(
    input logic clk,
    input logic rst,
    input logic [7:0] w_data,
    input logic w_en,
    input logic r_en,
    output logic [7:0] r_data,
    output logic full,
    output logic empty
    );

    localparam ADDR_WIDTH = $clog2(64);
    logic [ADDR_WIDTH-1:0]r_addr,w_addr;
    logic last_was_read;
    logic [7:0]mem[0:63];

    always_ff @(posedge clk)
        begin
            if(rst)
                begin
                    w_addr <= 0;
                end
            else
                begin
                    if(w_en && !full)
                        begin 
                            mem[w_addr] <= w_data;
                            w_addr <= w_addr +1; 
                        end
                end
        end
        
    always_ff @(posedge clk)
        begin
            if(rst)
                begin
                    r_addr <=0;
                end
            else
                begin
                    if(r_en && !empty)
                        begin
                            r_addr <= r_addr+1;
                        end
                end
        end

assign r_data = mem[r_addr];

    always_ff @(posedge clk)
        begin
            if(rst)
                begin
                    last_was_read <= 1;
                end
            else
                begin 
                    if(r_en && !empty)
                        begin
                            last_was_read <= 1;
                        end
                    else if(w_en && !full)
                        begin
                            last_was_read <= 0;
                        end
                end
        end            

    assign full = (w_addr == r_addr) && !last_was_read; 
    assign empty = (w_addr == r_addr) && last_was_read;
    
endmodule