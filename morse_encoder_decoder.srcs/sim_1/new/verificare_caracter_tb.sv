`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 02:35:40 PM
// Design Name: 
// Module Name: verificare_caracter_tb
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


module verificare_caracter_tb();

logic [7:0]data;
logic reset;
logic reset_nou;

initial begin

data = 0;
reset = 0;

#5
data = 32;

#5 
data = 40;

#5 
data = 48;

#5 
data = 57;

#5 
data = 60;

#5 
data = 65; 

#5 
data = 90;

#5 
data = 93;

#5 
data = 97;

#5 
data = 122;

#10
$stop();
end

verificare_caracter DUT(
    .*
    );
endmodule
