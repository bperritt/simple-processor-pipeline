`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Bradley Perritt (perritt.b@northeastern.edu)
//////////////////////////////////////////////////////////////////////////////////


module inst_decoder(input [15:0] instruction,
output [3:0] opcode,
output [1:0] rs_addr,
output [1:0] rt_addr,
output reg [1:0] rd_addr,
output reg [7:0] immediate,
output reg RegDst,
output reg RegWrite,
output reg ALUSrc1,
output reg ALUSrc2,
output reg [2:0] ALUOp,
output reg MemWrite,
output reg MemToReg);

    assign opcode = instruction[15:12]; 
    assign rs_addr = instruction [11:10];
    assign rt_addr = instruction [9:8];
    
    always @(opcode) begin             
        rd_addr <= 2'bxx;
        immediate <= 8'bxxxxxxxx;
        RegDst <= 1'bx; 
        RegWrite <= 1'bx;
        ALUSrc1 <= 1'bx;
        ALUSrc2 <= 1'bx;
        ALUOp[2:0] <= 3'bxxx;
        MemWrite <= 1'bx;
        MemToReg <= 1'bx;
        case (opcode)
           0:
           begin               
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'b0; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1;
               ALUOp[2:0] <= 3'b000;
               MemWrite <= 1'b0;
               MemToReg <= 1'b1;
           end
           1:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'bx; 
               RegWrite <= 1'b0;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1;
               ALUOp[2:0] <=  3'b000;
               MemWrite <= 1'b1;
               MemToReg <= 1'bx;
           end
           2:
           begin
               rd_addr <= instruction [7:6];
               immediate <= 6'b0;
               RegDst <= 1'b1; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0;
               ALUOp[2:0] <= 3'b000;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           3:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'b0; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1;
               ALUOp[2:0] <= 3'b000;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           4:
           begin
               rd_addr <= instruction [7:6];
               immediate <= 6'b0;
               RegDst <= 1'b1; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b1;
               ALUSrc2 <= 1'b0;
               ALUOp[2:0] <= 3'b001;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           5:
           begin
               rd_addr <= instruction [7:6];
               immediate <= 6'b0;
               RegDst <= 1'b1; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0;
               ALUOp[2:0] <= 3'b010;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           6:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'b0; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1;
               ALUOp[2:0] <= 3'b010;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           7: 
           begin
               rd_addr <= instruction [7:6];
               immediate <= 6'b0;
               RegDst <= 1'b1; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0;
               ALUOp[2:0] <= 3'b011;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           8:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'b0; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1;
               ALUOp[2:0] <= 3'b011;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           9:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'b0; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1;
               ALUOp[2:0] <= 3'b100;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           10:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'b0; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1;
               ALUOp[2:0] <= 3'b101;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
           11:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'bx; 
               RegWrite <= 1'b0;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0;
               ALUOp[2:0] <= 3'b110;
               MemWrite <= 1'b0;
               MemToReg <= 1'bx;
           end
           12:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'bx; 
               RegWrite <= 1'b0;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0;
               ALUOp[2:0] <= 3'b111;
               MemWrite <= 1'b0;
               MemToReg <= 1'bx;
           end
           13:
           begin
               rd_addr <= 2'b0;
               immediate <= instruction [7:0];
               RegDst <= 1'b0; 
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b1;
               ALUSrc2 <= 1'b0;
               ALUOp[2:0] <= 3'b010;
               MemWrite <= 1'b0;
               MemToReg <= 1'b0;
           end
      endcase    
    end
endmodule
