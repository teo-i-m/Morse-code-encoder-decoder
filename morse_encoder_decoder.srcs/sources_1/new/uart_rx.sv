`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 12:23:58 AM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx
#(
    parameter CLK_FREQ = 125_000_000,
    parameter BAUDRATE = 115200
)
(
    input logic clk,
    input logic rst,
    input logic rx,
    output logic [7:0]data_out,
    output logic data_valid
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
logic [2:0]  i;
logic [7:0]  rx_data;

always_ff @(posedge clk)
    begin
    
        if(rst)
            begin
                state <= STATE_IDLE;
                clk_count <= 0;
                i <= 0;
                rx_data <= 0;
                data_valid <= 0;
                data_out <= 0;
            end
        else
            begin
            
                data_valid <= 0;
    
                case(state)
    
                    STATE_IDLE:
                        begin
                            clk_count <= 0;
                            i <= 0;
                            if(rx == 0)
                                state <= STATE_START;
                        end
    
                    STATE_START:
                        begin
                            if(clk_count == (CLKS_PER_BIT/2))
                                begin
                                    if(rx == 0)
                                        begin
                                            clk_count <= 0;
                                            state <= STATE_DATA;
                                        end
                                    else
                                        state <= STATE_IDLE;
                                end
                            else
                                clk_count <= clk_count + 1;
                        end
    
                    STATE_DATA:
                        begin
                            if(clk_count == CLKS_PER_BIT-1)
                                begin
                                    clk_count <= 0;
                                    rx_data[i] <= rx;
    
                                    if(i == 7)
                                        begin
                                            i <= 0;
                                            state <= STATE_STOP;
                                        end
                                    else
                                        i <= i + 1;
                                end
                            else
                                clk_count <= clk_count + 1;
                        end
    
                    STATE_STOP:
                        begin
                            if(clk_count == CLKS_PER_BIT-1)
                                begin
                                    data_out <= rx_data;
                                    data_valid <= 1;
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