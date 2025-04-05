`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 00:45:31
// Design Name: 
// Module Name: Controller
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


module Controller(
input Add,
input Addu,
input Sub,
input Subu,
input And,
input Or,
input Xor,
input Nor,
input Slt,
input Sltu,
input Sll,
input Srl,
input Sra,
input Sllv,
input Srlv,
input Srav,
input Jr,
//I-type
input Addi,
input Addiu,
input Andi,
input Ori,
input Xori,
input Lw,
input Sw,
input Beq,
input Bne,
input Slti,
input Sltiu,
input Lui,
//J-type
input J,
input Jal,

input zero,

output we,
output [1:0] mux_A,
output [1:0] mux_B,
output [3:0] ALUC,
output DM_w,
output DM_r,
output [1:0] mux_PC
    );
assign we = (!(Jr || Sw || Beq || Bne || J)) ? 1'b1 : 1'b0;

assign mux_A[0] = Sll || Srl || Sra;
assign mux_A[1] = Jal;

assign mux_B[0] = Addi || Addiu || Andi || Ori || Xori || 
                Lw || Sw || Slti || Sltiu || Lui;
assign mux_B[1] = Jal;

assign ALUC[3] = Slt || Sltu || Sll || Srl || Sra || Lui ||
                Slti || Sltiu || Sllv || Srlv || Srav;
assign ALUC[2] = And || Or || Xor || Nor || Sra || Lui ||
                Andi || Ori || Xori || Srav;
assign ALUC[1] = Sub || Subu || Xor || Nor || Sll || Srl ||
                Xori || Sllv || Srlv || Beq || Bne;
assign ALUC[0] = Addu || Subu || Or || Nor || Sltu || Srl || Lui ||
                Addiu || Ori || Sltiu || Srlv || Beq || Bne;

assign DM_r = Lw;
assign DM_w = Sw;

assign mux_PC[0] = Jr || J || Jal;
assign mux_PC[1] = (Beq && zero) || (Bne && ~zero) || J || Jal;


endmodule
