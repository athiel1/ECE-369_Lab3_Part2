`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [5:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0

    /* Please fill in the implementation here... */

	// Add: add, addi, lw, sw, sb, lh, lb, sh
	// Subtract: sub, beq, bne, slt, slti
	// Multiply: mul
	// Branch if greater than or equal to zero: bgez
	// Branch on greater than zero: bgtz
	// Branch on less than or equal to zero: blez
	// Branch on less than zero: bltz
	// Logical ands: and, andi
	// Logical or: or, ori
	// Logical nor: nor
	// Logical xor: xor, xori
	// Shift left logical: sll
	// Shift right logical: srl


	always @(*) begin

		case (ALUControl)
			6'b100000: // ADD 
				ALUResult <= A + B;
			6'b100010: // SUB
				ALUResult <= A - B;  // might have to change
			6'b011000: // MUL
				ALUResult <= A * B;
			6'b100100: // AND
				ALUResult <= A & B;
			6'b100101: // OR
				ALUResult <= A | B;
			6'b100111: // NOR
				ALUResult <= ~(A | B);
			6'b100110: // XOR
				ALUResult <= A ^ B;
			6'b000000: // sll
				ALUResult <= A << (B[4:0]);
			6'b000010: // srl
				ALUResult <= A >> (B[4:0]);
			6'b101010: // slt
				ALUResult <= A < B;
			6'b101000: // Store byte
			  	ALUResult = A + B;
   		 	6'b100000: // Load byte
			  	ALUResult = A + B;
		  	6'b101001: // Store half
			  	ALUResult = A + B;
		  	6'b100001: // Load half
			  	ALUResult = A + B;

			//FIXME below
			6'b000001: // BGEZ
			  	ALUResult = (A >= 0) ? 32'b0 : 32'b1;
            		6'b000011: // BLTZ
			  	ALUResult = (A < 0) ? 32'b0 : 32'b1;
		  	6'b000100: // BEQ
				ALUResult = (A == B) ? 32'b0 : 32'b1;
		  	6'b000101: // BNE
				ALUResult = (A != B) ? 32'b0 : 32'b1;
		  	6'b000111: // BGTZ
				ALUResult = (A > 0) ? 32'b0 : 32'b1;
		  	6'b000110: // BLEZ
				ALUResult = (A <= 0) ? 32'b0 : 32'b1;

			//////This could be a fix?///////
			// 6'b000100: // BEQ
    			//	Zero <= (A == B) ? 1'b1 : 1'b0;
			// 6'b000101: // BNE
   			//	Zero <= (A != B) ? 1'b1 : 1'b0;
			// 6'b000111: // BGTZ
    			//	Zero <= (A > 0) ? 1'b1 : 1'b0;
			// 6'b000110: // BLEZ
    			//	Zero <= (A <= 0) ? 1'b1 : 1'b0;
			///////////////
			
		  	6'b000010: // J
			  	ALUResult = 0;
		  	6'b001000: // JR
			  	ALUResult = A;
		  	6'b000011: // JAL
			  	ALUResult = 0;
			default: begin
				ALUResult <= 32'b0;
				Zero <= 1'b1;
			end
		endcase
		if (ALUResult == 0) begin
		  Zero <= 1;
		end 
		else begin
		  Zero <= 0;
		end
	end


endmodule





			
