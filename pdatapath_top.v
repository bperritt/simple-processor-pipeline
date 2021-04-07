`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Majid Sabbagh (sabbagh.m@husky.neu.edu)
// Modified by: Bradley Perritt (perritt.b@northeastern.edu)
//////////////////////////////////////////////////////////////////////////////////
module pdatapath_top(
		input wire clk,				// General clock input
		input wire top_pb_clk,		// PBN1 clock input
        input wire rst_general,		// PBN0 clock reset for memory blocks
		output [7:0] led,			// add-on board led[5:0], + LD0, LD1
		output wire ovf_ctrl,    	// LD3 for overflow
		output [3:0] disp_en,		// 7-Segment display enable
		output [6:0] seg7_output	// 7-segment display output
    );
	
	// ALU inteface
    wire [7:0] alu_input1, alu_input2;
    wire [7:0] alu_output;
    wire [2:0] ALUOp;
    wire       alu_ovf;
    wire       take_branch;
    
    wire [15:0] instruction;
    //insturction fields
    wire [3:0] opcode;
    wire [1:0] rs_addr;
    wire [1:0] rt_addr;
    wire [1:0] rd_addr;
    wire [7:0] immediate;
    //control signals
    wire RegDst;
    wire RegWrite;
    wire ALUSrc1;
    wire ALUSrc2;
    wire MemWrite;
    wire MemToReg;

    wire [1:0] regfile_WriteAddress;//destination register address
    wire [8:0] regfile_WriteData;//result data
    wire [8:0] regfile_ReadData1;//source register1 data
    wire [8:0] regfile_ReadData2;//source register2 data

    wire [8:0] alu_result;
    wire [8:0] Data_Mem_Out;
	wire [7:0] zero_register;
	
	// PC and debouce clock
	wire [7:0] pc;
	wire pb_clk_debounced;

	assign zero_register = 8'b0;	//ZERO constant
	assign alu_result = {alu_ovf, alu_output};
	
	// Assign LEDs
    assign led = alu_output;
	assign ovf_ctrl = alu_ovf;
	// Debounce circuit
    debounce debounce_clk(
        .clk_in(clk),
        .rst_in(rst_general),
        .sig_in(top_pb_clk),
        .sig_debounced_out(pb_clk_debounced)
    );	
	// 7-Segment display module
	Adaptor_display display(
		.clk(clk), 					// system clock
		.input_value(alu_output),	// 8-bit input [7:0] value to display
		.disp_en(disp_en),			// output [3:0] 7 segment display enable
		.seg7_output(seg7_output)	// output [6:0] 7 segment signals
	);
    //Instantiate Your PC Register here
    program_counter counter(pb_clk_debounced, rst_general, pc); 
	//Instantiate Your instruction Memory here
    instr_mem instr_memory(.a(pc), .spo(instruction));
	//Instantiate Your instruction decoder here
    inst_decoder decoder(instruction,
        opcode,
        rs_addr,
        rt_addr,
        rd_addr,
        immediate,
        RegDst,
        RegWrite,
        ALUSrc1,
        ALUSrc2,
        ALUOp,
        MemWrite,
        MemToReg);         
	//Instantiate Your alu-regfile here
	eightbit_alu alu(alu_input1, alu_input2, ALUOp, alu_output, alu_ovf, take_branch);
    reg_file register(rst_general, pb_clk_debounced, RegWrite, 
        rs_addr, 
        rt_addr, 
        regfile_WriteAddress, 
        regfile_WriteData, 
        regfile_ReadData1, 
        regfile_ReadData2);
 	//Instantiate Your data memory here
	data_memory ram(.clk(pb_clk_debounced),
        .we(MemWrite),
        .a(alu_output),
        .d(regfile_ReadData2),
        .spo(Data_Mem_Out));
	//Mux for regfile_writedata
	Mux2to1 mux1(regfile_ReadData1, zero_register, ALUSrc1, alu_input1);
    Mux2to1 mux2(regfile_ReadData2, immediate, ALUSrc2, alu_input2);  
    Mux2to1 mux3(alu_result, Data_Mem_Out, MemToReg, regfile_WriteData);
	//Mux for RegDST
    Mux2to1 mux4(rt_addr, rd_addr, RegDst, regfile_WriteAddress);
	//Instantiate Your VIO core here
	vio_0 vio (
          .clk(clk),                // input wire clk
          .probe_in0(alu_output),    
          .probe_in1(alu_ovf),   
          .probe_in2(take_branch), 
          .probe_in3(regfile_ReadData1),
          .probe_in4(regfile_ReadData2),
          .probe_in5(alu_input1),
          .probe_in6(alu_input2),
          .probe_in7(regfile_WriteData),
          .probe_in8(Data_Mem_Out),
          .probe_in9(opcode),  // output wire [7 : 0] probe_out0
          .probe_in10(rs_addr),
	      .probe_in11(rt_addr),
	      .probe_in12(rd_addr),
	      .probe_in13(immediate),
	      .probe_in14(RegDst),
	      .probe_in15(RegWrite),
	      .probe_in16(ALUSrc1),
	      .probe_in17(ALUSrc2),
	      .probe_in18(ALUOp),
	      .probe_in19(MemWrite),
	      .probe_in20(MemToReg),
	      .probe_in21(pc),
	      .probe_in22(instruction));		
endmodule
