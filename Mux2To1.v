`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: Bradley Perritt (perritt.b@northeastern.edu)
//////////////////////////////////////////////////////////////////////////////////


module Mux2to1(input[8:0] data1, input[8:0] data2, input select, output reg[7:0] out);
    always @ (select, data1, data2) begin
        case (select)
            0 : out <= data1[7:0];
            1 : out <= data2[7:0];
        endcase   
    end     
endmodule
