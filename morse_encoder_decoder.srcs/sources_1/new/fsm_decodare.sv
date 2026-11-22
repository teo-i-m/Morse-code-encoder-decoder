`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 04:20:21 PM
// Design Name: 
// Module Name: fsm_mare
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

module fsm_decodare (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic [7:0] out,
    output logic valid
);

    typedef enum logic [2:0] {
        STATE_START,
        STATE_HIGH,
        STATE_LOW
    } stateFSM;

    stateFSM state;

    logic [3:0] high;
    logic [4:0] low;
    logic [4:0] decodare;
    logic [2:0] len;

    always_ff @(posedge clk or posedge rst) 
        begin
            if (rst) 
                begin
                    state <= STATE_START;
                    high <= 0;
                    low <= 0;
                    len <= 0;
                    valid <= 0;
                    out <= 0;
                end 
            else 
                begin
                    valid <= 0;
                    case (state)

                        STATE_START: 
                            begin
                                low <= 0;
                                high  <= 0;
                                len <= 0;
                                if (in) 
                                    begin
                                        state <= STATE_HIGH;
                                        high <= 1;
                                    end
                            end

                        STATE_HIGH: 
                            begin
                                if (in) 
                                    begin
                                        high <= high + 1;
                                    end 
                                 else 
                                    begin
                                        low <= 1;
                                        state <= STATE_LOW;
                                        if (high == 1)
                                            decodare[len] <= 0;
                                        else 
                                            if (high == 3)
                                                decodare[len] <= 1;
                                        len <= len + 1;
                                    end
                             end

                        STATE_LOW: 
                            begin
                                if (!in) 
                                    begin
                                        low <= low + 1;
                                    end 
                                else
                                    begin
                                        low <= 0;
                                        state <= STATE_HIGH;
                                        high <= 1;
                                    end

                                if (low == 2) 
                                    begin
//                                        A = .-
                                        if (len==2 && decodare[0]==0 && decodare[1]==1) 
                                            out = "A";

//                                        B = -...
                                        else if (len==4 && decodare[0]==1 && decodare[1]==0 && decodare[2]==0 && decodare[3]==0) 
                                            out = "B";

//                                        C = -.-.
                                        else if (len==4 && decodare[0]==1 && decodare[1]==0 && decodare[2]==1 && decodare[3]==0) 
                                            out = "C";

//                                        D = -..
                                        else if (len==3 && decodare[0]==1 && decodare[1]==0 && decodare[2]==0) 
                                            out = "D";

//                                        E = .
                                        else if (len==1 && decodare[0]==0) 
                                            out = "E";

//                                        F = ..-.
                                        else if (len==4 && decodare[0]==0 && decodare[1]==0 && decodare[2]==1 && decodare[3]==0) 
                                            out = "F";

//                                        G = --.
                                        else if (len==3 && decodare[0]==1 && decodare[1]==1 && decodare[2]==0) 
                                            out = "G";

//                                        H = ....
                                        else if (len==4 && decodare[0]==0 && decodare[1]==0 && decodare[2]==0 && decodare[3]==0) 
                                            out = "H";

//                                        I = ..
                                        else if (len==2 && decodare[0]==0 && decodare[1]==0) 
                                            out = "I";

//                                        J = .---
                                        else if (len==4 && decodare[0]==0 && decodare[1]==1 && decodare[2]==1 && decodare[3]==1) 
                                            out = "J";

//                                        K = -.-
                                        else if (len==3 && decodare[0]==1 && decodare[1]==0 && decodare[2]==1) 
                                            out = "K";

//                                        L = .-..
                                        else if (len==4 && decodare[0]==0 && decodare[1]==1 && decodare[2]==0 && decodare[3]==0) 
                                            out = "L";

//                                        M = --
                                        else if (len==2 && decodare[0]==1 && decodare[1]==1)   
                                            out = "M";

//                                        N = -.
                                        else if (len==2 && decodare[0]==1 && decodare[1]==0) 
                                            out = "N";

//                                        O = ---
                                        else if (len==3 && decodare[0]==1 && decodare[1]==1 && decodare[2]==1) 
                                            out = "O";

//                                        P = .--.
                                        else if (len==4 && decodare[0]==0 && decodare[1]==1 && decodare[2]==1 && decodare[3]==0) 
                                            out = "P";

//                                        Q = --.-
                                        else if (len==4 && decodare[0]==1 && decodare[1]==1 && decodare[2]==0 && decodare[3]==1) 
                                            out = "Q";

//                                        R = .-.
                                        else if (len==3 && decodare[0]==0 && decodare[1]==1 && decodare[2]==0) 
                                            out = "R";

//                                        S = ...
                                        else if (len==3 && decodare[0]==0 && decodare[1]==0 && decodare[2]==0) 
                                            out = "S";

//                                        T = -
                                        else if (len==1 && decodare[0]==1) 
                                            out = "T";

//                                        U = ..-
                                        else if (len==3 && decodare[0]==0 && decodare[1]==0 && decodare[2]==1) 
                                            out = "U";

//                                        V = ...-
                                        else if (len==4 && decodare[0]==0 && decodare[1]==0 && decodare[2]==0 && decodare[3]==1) 
                                            out = "V";

//                                        W = .--
                                        else if (len==3 && decodare[0]==0 && decodare[1]==1 && decodare[2]==1) 
                                            out = "W";

//                                        X = -..-
                                        else if (len==4 && decodare[0]==1 && decodare[1]==0 && decodare[2]==0 && decodare[3]==1) 
                                            out = "X";

//                                        Y = -.--
                                        else if (len==4 && decodare[0]==1 && decodare[1]==0 && decodare[2]==1 && decodare[3]==1) 
                                            out = "Y";

//                                        Z = --..
                                        else if (len==4 && decodare[0]==1 && decodare[1]==1 && decodare[2]==0 && decodare[3]==0) 
                                            out = "Z";
                                            
//                                        1 = .----
                                        else if (len==5 && decodare[0]==0 && decodare[1]==1 && decodare[2]==1 && decodare[3]==1 && decodare[4]==1) 
                                            out = "1";
                                            
//                                        2 = ..---
                                        else if (len==5 && decodare[0]==0 && decodare[1]==0 && decodare[2]==1 && decodare[3]==1 && decodare[4]==1) 
                                            out = "2";
                                            
//                                        3 = ...--
                                        else if (len==5 && decodare[0]==0 && decodare[1]==0 && decodare[2]==0 && decodare[3]==1 && decodare[4]==1) 
                                            out = "3";
                                            
//                                        4 = ....-
                                        else if (len==5 && decodare[0]==0 && decodare[1]==0 && decodare[2]==0 && decodare[3]==0 && decodare[4]==1) 
                                            out = "4";
                                               
//                                        5 = .....
                                        else if (len==5 && decodare[0]==0 && decodare[1]==0 && decodare[2]==0 && decodare[3]==0 && decodare[4]==0) 
                                            out = "5";
                                            
//                                        6 = -....
                                        else if (len==5 && decodare[0]==1 && decodare[1]==0 && decodare[2]==0 && decodare[3]==0 && decodare[4]==0) 
                                            out = "6";
                                            
//                                        7 = --...
                                        else if (len==5 && decodare[0]==1 && decodare[1]==1 && decodare[2]==0 && decodare[3]==0 && decodare[4]==0) 
                                            out = "7";
                                            
//                                        8 = ---..
                                        else if (len==5 && decodare[0]==1 && decodare[1]==1 && decodare[2]==1 && decodare[3]==0 && decodare[4]==0) 
                                            out = "8";
                                            
//                                        9 = ----.
                                        else if (len==5 && decodare[0]==1 && decodare[1]==1 && decodare[2]==1 && decodare[3]==1 && decodare[4]==0) 
                                            out = "9";
                                            
//                                        0 = -----
                                        else if (len==5 && decodare[0]==1 && decodare[1]==1 && decodare[2]==1 && decodare[3]==1 && decodare[4]==1) 
                                            out = "0";
                                                                                                                                                                                                                                                                                                                  
                                        valid <= 1;
                                        len <= 0;
                                    end
                                else if (low == 6)
                                    begin
                                        out <= " "; 
                                        valid <= 1;
                                        len <= 0;
                                        high <= 0;
                                        low <= 0;
                                        state <= STATE_START;
                                    end
                            end
                    endcase
            end
        end

endmodule