`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 03:53:42 PM
// Design Name: 
// Module Name: eightbit_alu
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


module eightbit_alu(input[7:0] a,
input [7:0] b,
input [2:0] s,
output reg [7:0] f,
output reg ovf,
output reg take_branch);
wire signed [7:0] in = a;
    always @(a, b, s)
    begin
        case(s)
            0 : begin
                f = a + b;
                ovf = (a[7] & b[7] & !f[7]) | (!a[7] & !b[7] & f[7]);
                take_branch = 1'b0;
                end
            1 : begin
                f = ~b;
                ovf = 0;
                take_branch = 1'b0;
                end
            2 : begin
                f = a & b;
                ovf = 0;
                take_branch = 1'b0;
                end
            3 : begin
                f = a | b;
                ovf = 0;
                take_branch = 1'b0;
                end
            4: begin
                f = in >>> 1; 
                ovf = 0;
                take_branch = 1'b0;
                end
            5: begin
                f = a << 1;
                ovf = 0;
                take_branch = 1'b0;
                end
            6: begin
                f = 0;               
                if (a == b)
                    take_branch = 1'b1;
                else 
                   take_branch = 1'b0;     
                ovf = 0;
                end 
            7: begin
                f = 0;
                if (a != b)
                    take_branch = 1'b1;
                else 
                    take_branch = 1'b0;    
                ovf = 0;
                end                     
            default : begin
                    f = 0;
                    ovf = 0;
                    take_branch = 1'b0;
                    end
         endcase
    end 
endmodule
