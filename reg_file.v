`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Bradley Perritt (perritt.b@northeastern.edu)
//////////////////////////////////////////////////////////////////////////////////


module reg_file(input rst, input clk, input wr_en, 
input[1:0] rd0_addr, 
input[1:0] rd1_addr, 
input[1:0] wr_addr, 
input[8:0] wr_data, 
output [8:0] rd0_data, 
output [8:0] rd1_data);
    reg [8:0] storage [0:3]; 
    
    always@(posedge clk, posedge rst) begin
        if (rst) begin
            storage[0] <= 8'b0;     
            storage[1] <= 8'b0; 
            storage[2] <= 8'b0; 
            storage[3] <= 8'b0;
        end
        else begin    
            if (wr_en)
                storage[wr_addr] <= wr_data;  
        end                
    end     
        
    assign rd0_data = storage[rd0_addr];    
    assign rd1_data = storage[rd1_addr];  
    
endmodule
