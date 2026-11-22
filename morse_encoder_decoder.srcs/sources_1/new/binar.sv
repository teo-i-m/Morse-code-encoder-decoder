`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 04:36:29 PM
// Design Name: 
// Module Name: binar
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


module binar(
    input logic [7:0]data_in,
    output logic [4:0]morse_binar,
    output logic [2:0]len
    );
    
    always_comb 
        begin
            case(data_in)
//                space
                32: begin
                        morse_binar = 5'b01110;  
                        len = 0;
                    end
//                0 = -----
                48:     begin  
                            morse_binar =5'b11111;  
                            len = 5;
                        end
//                1 = .----
                49:     begin
                            morse_binar =5'b01111;  
                            len = 5;
                        end
//                2 = ..---
                50:     begin
                            morse_binar =5'b00111;  
                            len = 5;
                        end
//                3 = ...--
                51:     begin
                            morse_binar =5'b00011;  
                            len = 5;
                        end
//                4 = ....-
                52:     begin
                            morse_binar =5'b00001;  
                            len = 5;
                        end
//                5 = .....
                53:     begin
                            morse_binar =5'b00000;  
                            len = 5;
                        end
//                6 = -....
                54:     begin
                            morse_binar =5'b10000;  
                            len = 5;
                        end
//                7 = --...
                55:     begin
                            morse_binar =5'b11000;  
                            len = 5;
                        end
//                8 = ---..
                56:     begin
                            morse_binar =5'b11100;  
                            len = 5;
                        end
//                9 = ----.
                57:     begin
                            morse_binar =5'b11110;  
                            len = 5;
                        end 
//                A = .-
                65:     begin 
                            morse_binar =5'b00001;  
                            len = 2;
                        end
//                B = -...
                66:     begin
                            morse_binar =5'b01000;  
                            len = 4;
                        end
//                C = -.-.
                67:     begin
                            morse_binar =5'b01010;  
                            len = 4;
                        end
//                D = -..
                68:     begin
                            morse_binar =5'b00100;  
                            len = 3;
                        end
//                E = .
                69:     begin
                            morse_binar =5'b00000;  
                            len = 1;
                        end
//                F = ..-.
                70:     begin  
                            morse_binar =5'b00010;  
                            len = 4;
                        end
//                G = --.
                71:     begin
                            morse_binar =5'b00110;  
                            len = 3;
                        end
//                H = ....
                72:     begin
                            morse_binar =5'b00000;  
                            len = 4;
                        end
//                I = ..
                73:     begin
                            morse_binar =5'b00000;  
                            len = 2;
                        end
//                J = .---
                74:     begin
                            morse_binar =5'b00111;  
                            len = 4;
                        end
//                K = -.-
                75:     begin
                            morse_binar =5'b00101;  
                            len = 3;
                        end
//                L = .-..
                76:     begin
                            morse_binar =5'b00100;  
                            len = 4;
                        end
//                M = --
                77:     begin
                            morse_binar =5'b00011;  
                            len = 2;
                        end
//                N = -.
                78:     begin
                            morse_binar =5'b00010;  
                            len = 2;
                        end
//                O = ---
                79:     begin
                            morse_binar =5'b00111;  
                            len = 3;
                        end 
//                P = .--.
                80:     begin 
                            morse_binar =5'b00110;  
                            len = 4;
                        end
//                Q = --.-
                81:     begin
                            morse_binar =5'b01101;  
                            len = 4;
                        end
//                R = .-.
                82:     begin
                            morse_binar =5'b00010;  
                            len = 3;
                        end
//                S = ...
                83:     begin
                            morse_binar =5'b00000;  
                            len = 3;
                        end
//                T = -
                84:     begin
                            morse_binar =5'b00001;  
                            len = 1;
                        end
//                U = ..-
                85:     begin
                            morse_binar =5'b00001;  
                            len = 3;
                        end
//                V = ...-
                86:     begin
                            morse_binar =5'b00001;  
                            len = 4;
                        end 
//                W = .--
                87:     begin
                            morse_binar =5'b00011;  
                            len = 3;
                        end
//                X = -..-
                88:     begin
                            morse_binar =5'b01001;  
                            len = 4;
                        end
//                Y = -.--
                89:     begin
                            morse_binar =5'b01011;  
                            len = 4;
                        end
//                Z = --..
                90:     begin
                            morse_binar =5'b01100;  
                            len = 4;
                        end
            endcase
        end
        
endmodule
