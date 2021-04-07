`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 06:17:15 PM
// Design Name: 
// Module Name: Mux2To1
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


module Mux2to1(input[8:0] data1, input[8:0] data2, input select, output reg[7:0] out);
    always @ (select, data1, data2) begin
        case (select)
            0 : out <= data1[7:0];
            1 : out <= data2[7:0];
        endcase   
    end     
endmodule
