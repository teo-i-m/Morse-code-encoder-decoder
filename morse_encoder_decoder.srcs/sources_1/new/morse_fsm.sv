`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 04:18:17 PM
// Design Name: 
// Module Name: morse_fsm
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

module morse_fsm(
    input logic clk,
    input logic rst,
    input logic [4:0] data_in,
    input logic [2:0] len,
    input logic fifo_empty,
    output logic out,
    output logic r_en_fsm
    );
    
    typedef enum logic [3:0] {
        STATE_TEST,
        STATE_START,
        STATE_0,
        STATE_1_1,
        STATE_1_2,
        STATE_1_3,
        STATE_SPACE_1,
        STATE_IDLE
    } stateFSM;
    
    stateFSM state, state_next;
    logic [2:0] i;
    logic [4:0] reg_data;
    logic [2:0] reg_len;
    
    assign r_en_fsm = (state == STATE_TEST) && (!fifo_empty);
    
    always_ff @(posedge clk) 
        begin
            if (rst) 
                begin
                    state <= STATE_TEST;
                    i <= 0;
                    reg_data <= 0;
                    reg_len <= 0;
                end 
            else 
                begin
                    state <= state_next;
                    if (state == STATE_TEST && !fifo_empty) 
                        begin
                            reg_data <= data_in;
                            reg_len <= len;
                        end
                    if (state == STATE_START) 
                        begin
                            i <= 0;
                        end 
                    else if (state == STATE_0 || state == STATE_1_1) 
                        begin
                            i <= i + 1;
                        end
                end
        end
    
    always_comb 
        begin
            state_next = state;
            out = 0;
            case(state)
            
                STATE_TEST: 
                    begin
                        if (fifo_empty)
                            state_next = STATE_TEST;
                        else
                            state_next = STATE_START; 
                    end
                
                STATE_START: 
                    begin
                        if (reg_len == 0 && reg_data == 5'b01110)
                            state_next = STATE_SPACE_1; 
                        else if (reg_len == 0)
                            state_next = STATE_TEST;
                        else if (reg_data[reg_len-1] == 0)
                            state_next = STATE_0;
                        else if (reg_data[reg_len-1] == 1)
                            state_next = STATE_1_1;
                    end
                
                STATE_0: 
                    begin
                        out = 1;
                        state_next = STATE_IDLE;
                    end
                
                STATE_1_1: 
                    begin
                        out = 1;
                        state_next = STATE_1_2;
                    end
                
                STATE_1_2: 
                    begin
                        out = 1;
                        state_next = STATE_1_3;
                    end
                
                STATE_1_3: 
                    begin
                        out = 1;
                        state_next = STATE_IDLE;
                    end
                
                STATE_SPACE_1: 
                    begin
                        state_next = STATE_IDLE;
                    end
                
                STATE_IDLE: 
                    begin
                        out = 0;
                        if (i == reg_len)
                            state_next = STATE_TEST;
                        else 
                            begin
                                if (reg_data[reg_len-i-1] == 0)
                                    state_next = STATE_0;
                                else
                                    state_next = STATE_1_1;
                            end
                    end
                
                default: state_next = STATE_TEST;
            endcase
        end
endmodule

