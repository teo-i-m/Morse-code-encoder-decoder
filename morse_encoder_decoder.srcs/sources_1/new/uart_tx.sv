`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2026 09:22:50 AM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx
#(
    parameter CLK_FREQ = 125_000_000,
    parameter BAUDRATE = 115200
)
(
    input logic clk,
    input logic rst,
    input logic [7:0]data_in,
    input logic start,
    output logic tx,
    output logic busy
);

localparam integer CLKS_PER_BIT = CLK_FREQ / BAUDRATE;

typedef enum logic [2:0]
{
    STATE_IDLE,
    STATE_START,
    STATE_DATA,
    STATE_STOP
} state_t;

state_t state;

logic [15:0] clk_count;
logic [2:0] i;
logic [7:0] tx_data;

always_ff @(posedge clk)
    begin
    
        if(rst)
            begin
                state <= STATE_IDLE;
                tx <= 1;
                busy <= 0;
                clk_count <= 0;
                i <= 0;
                tx_data <= 0;
            end
        else
            begin
    
                case(state)
    
                    STATE_IDLE:
                        begin
                            tx <= 1;
                            busy <= 0;
    
                            if(start)
                                begin
                                    tx_data <= data_in;
                                    clk_count <= 0;
                                    state <= STATE_START;
                                    busy <= 1;
                                end
                        end
    
                    STATE_START:
                        begin
                            tx <= 0;
    
                            if(clk_count == CLKS_PER_BIT-1)
                                begin
                                    clk_count <= 0;
                                    i <= 0;
                                    state <= STATE_DATA;
                                end
                            else
                                clk_count <= clk_count + 1;
                        end
    
                    STATE_DATA:
                        begin
                            tx <= tx_data[i];
    
                            if(clk_count == CLKS_PER_BIT-1)
                                begin
                                    clk_count <= 0;
    
                                    if(i == 7)
                                        state <= STATE_STOP;
                                    else
                                        i <= i + 1;
                                end
                            else
                                clk_count <= clk_count + 1;
                        end
    
                    STATE_STOP:
                        begin
                            tx <= 1'b1;
    
                            if(clk_count == CLKS_PER_BIT-1)
                                begin
                                    clk_count <= 0;
                                    state <= STATE_IDLE;
                                end
                            else
                                clk_count <= clk_count + 1;
                        end
    
                    default:
                        state <= STATE_IDLE;
    
                endcase
            end
    end

endmodule