`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 13:15:21
// Design Name: 
// Module Name: ALU
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


module ALU(
input [31:0] A,
input [31:0] B,
input [3:0] ALUC,

output [31:0] C,
output zero,
output carry,
output negative,
output overflow
    );
    parameter ADD = 4'b0000;
    parameter ADDU = 4'b0001;
    parameter SUB = 4'b0010;
    parameter SUBU = 4'b0011;
    parameter AND = 4'b0100;
    parameter OR = 4'b0101;
    parameter XOR = 4'b0110;
    parameter NOR = 4'b0111;
    parameter SLT = 4'b1000;
    parameter SLTU = 4'b1001;
    parameter SLL = 4'b1010;
    parameter SRL = 4'b1011;
    parameter SRA = 4'b1100;
    parameter LUI = 4'b1101;

    reg [32:0] result;
    wire signed [31:0] signed_A;
    wire signed [31:0] signed_B;
    
    assign signed_A = A;
    assign signed_B = B;
    assign C = result[31:0];
    assign zero = (result == 32'b0) ? 1 : 0;
    assign carry = result[32];
    assign negative = (ALUC == SLT ? (signed_A < signed_B) : ((ALUC == SLTU) ? (A < B) : 1'b0));
    assign overflow = result[32] ^ result[31];

    always @(*)
    begin
        case(ALUC)
            ADD: result <= signed_A + signed_B;
            ADDU: result <= A + B;
            SUB: result <= signed_A - signed_B;
            SUBU: result <= A - B;
            AND: result <= A & B;
            OR: result <= A | B;
            XOR: result <= A ^ B;
            NOR: result <= ~(A | B);
            SLT: result <= (signed_A < signed_B);
            SLTU: result <= (A < B);
            SLL: result <= B << A;
            SRL: result <= B >> A;
            SRA: result <= signed_B >>> A;
            LUI: result <= {B[15:0], 16'b0};
            default: result <= 32'b0;
        endcase
    end

endmodule

