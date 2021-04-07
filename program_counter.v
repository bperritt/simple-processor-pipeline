`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Bradley Perritt (perritt.b@northeastern.edu)
//////////////////////////////////////////////////////////////////////////////////


module program_counter(input clk, input rst, output reg [7:0] count);

    always @(posedge clk, posedge rst) begin
        if (rst)
            count = 0;
        else 
            count = count + 1;
    end
        
endmodule
