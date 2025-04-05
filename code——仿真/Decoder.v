`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 00:50:22
// Design Name: 
// Module Name: Decoder
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


module Decoder(
input [31:0] IR,
//R-type
output Add,
output Addu,
output Sub,
output Subu,
output And,
output Or,
output Xor,
output Nor,
output Slt,
output Sltu,
output Sll,
output Srl,
output Sra,
output Sllv,
output Srlv,
output Srav,
output Jr,
//I-type
output Addi,
output Addiu,
output Andi,
output Ori,
output Xori,
output Lw,
output Sw,
output Beq,
output Bne,
output Slti,
output Sltiu,
output Lui,
//J-type
output J,
output Jal,

output [4:0] rsc,
output [4:0] rtc,
output [4:0] rdc,

output [4:0] shamt,
output [15:0] immediate,
output [25:0] index
    );
    //op均为000000，靠func区分
    parameter OP0        = 6'b000000;

    parameter ADD_FUNC  = 6'b100000;
    parameter ADDU_FUNC = 6'b100001;
    parameter SUB_FUNC  = 6'b100010;
    parameter SUBU_FUNC = 6'b100011;
    parameter AND_FUNC  = 6'b100100;
    parameter OR_FUNC   = 6'b100101;
    parameter XOR_FUNC  = 6'b100110;
    parameter NOR_FUNC  = 6'b100111;
    parameter SLT_FUNC  = 6'b101010;
    parameter SLTU_FUNC = 6'b101011;
    parameter SLL_FUNC  = 6'b000000;
    parameter SRL_FUNC  = 6'b000010;
    parameter SRA_FUNC  = 6'b000011;
    parameter SLLV_FUNC = 6'b000100;
    parameter SRLV_FUNC = 6'b000110;
    parameter SRAV_FUNC = 6'b000111;
    parameter JR_FUNC   = 6'b001000;
    //op不同，靠op来区分
    parameter ADDI_OP   = 6'b001000;
    parameter ADDIU_OP  = 6'b001001;
    parameter ANDI_OP   = 6'b001100;
    parameter ORI_OP    = 6'b001101;
    parameter XORI_OP   = 6'b001110;
    parameter LW_OP     = 6'b100011;
    parameter SW_OP     = 6'b101011;
    parameter BEQ_OP    = 6'b000100;
    parameter BNE_OP    = 6'b000101;
    parameter SLTI_OP   = 6'b001010;
    parameter SLTIU_OP  = 6'b001011;
    parameter LUI_OP    = 6'b001111;

    parameter J_OP      = 6'b000010;
    parameter JAL_OP    = 6'b000011;

    assign Add = ((IR[31:26] == OP0) && (IR[5:0] == ADD_FUNC)) ? 1'b1 : 1'b0;
    assign Addu = ((IR[31:26] == OP0) && (IR[5:0] == ADDU_FUNC)) ? 1'b1 : 1'b0;
    assign Sub = ((IR[31:26] == OP0) && (IR[5:0] == SUB_FUNC)) ? 1'b1 : 1'b0;
    assign Subu = ((IR[31:26] == OP0) && (IR[5:0] == SUBU_FUNC)) ? 1'b1 : 1'b0;
    assign And = ((IR[31:26] == OP0) && (IR[5:0] == AND_FUNC)) ? 1'b1 : 1'b0;
    assign Or = ((IR[31:26] == OP0) && (IR[5:0] == OR_FUNC)) ? 1'b1 : 1'b0;
    assign Xor = ((IR[31:26] == OP0) && (IR[5:0] == XOR_FUNC)) ? 1'b1 : 1'b0;
    assign Nor = ((IR[31:26] == OP0) && (IR[5:0] == NOR_FUNC)) ? 1'b1 : 1'b0;
    assign Slt = ((IR[31:26] == OP0) && (IR[5:0] == SLT_FUNC)) ? 1'b1 : 1'b0;
    assign Sltu = ((IR[31:26] == OP0) && (IR[5:0] == SLTU_FUNC)) ? 1'b1 : 1'b0;
    assign Sll = ((IR[31:26] == OP0) && (IR[5:0] == SLL_FUNC)) ? 1'b1 : 1'b0;
    assign Srl = ((IR[31:26] == OP0) && (IR[5:0] == SRL_FUNC)) ? 1'b1 : 1'b0;
    assign Sra = ((IR[31:26] == OP0) && (IR[5:0] == SRA_FUNC)) ? 1'b1 : 1'b0;
    assign Sllv = ((IR[31:26] == OP0) && (IR[5:0] == SLLV_FUNC)) ? 1'b1 : 1'b0;
    assign Srlv = ((IR[31:26] == OP0) && (IR[5:0] == SRLV_FUNC)) ? 1'b1 : 1'b0;
    assign Srav = ((IR[31:26] == OP0) && (IR[5:0] == SRAV_FUNC)) ? 1'b1 : 1'b0;
    assign Jr = ((IR[31:26] == OP0) && (IR[5:0] == JR_FUNC)) ? 1'b1 : 1'b0;

    assign Addi = (IR[31:26] == ADDI_OP) ? 1'b1 : 1'b0;
    assign Addiu = (IR[31:26] == ADDIU_OP) ? 1'b1 : 1'b0;
    assign Andi = (IR[31:26] == ANDI_OP) ? 1'b1 : 1'b0;
    assign Ori = ((IR[31:26] == ORI_OP)) ? 1'b1 : 1'b0;
    assign Xori = ((IR[31:26] == XORI_OP)) ? 1'b1 : 1'b0;
    assign Lw = (IR[31:26] == LW_OP) ? 1'b1 : 1'b0;
    assign Sw = (IR[31:26] == SW_OP) ? 1'b1 : 1'b0;
    assign Beq = (IR[31:26] == BEQ_OP) ? 1'b1 : 1'b0;
    assign Bne = ((IR[31:26] == BNE_OP)) ? 1'b1 : 1'b0;
    assign Slti = ((IR[31:26] ==  SLTI_OP)) ? 1'b1 : 1'b0;
    assign Sltiu = ((IR[31:26] == SLTIU_OP)) ? 1'b1 : 1'b0;
    assign Lui = (IR[31:26] == LUI_OP) ? 1'b1 : 1'b0;

    assign J = (IR[31:26] == J_OP) ? 1'b1 : 1'b0;
    assign Jal = (IR[31:26] == JAL_OP) ? 1'b1 : 1'b0;

    assign rsc = (Add || Addu || Sub || Subu || And || Or ||
                    Xor || Nor || Slt || Sltu || Sllv || Srlv ||
                    Srav || Jr || Addi || Addiu || Andi || Ori ||
                    Xori || Lw || Sw || Beq || Bne || Slti || 
                    Sltiu) ? IR[25:21] : 5'bz;

    assign rtc = (Add || Addu || Sub || Subu || And || Or ||
                    Xor || Nor || Slt || Sltu || Sll || Srl ||
                    Sra || Sllv || Srlv || Srav || Sw || Beq || 
                    Bne || Slti || Sltiu) ? IR[20:16] : 5'bz;

    assign rdc = (Add || Addu || Sub || Subu || And || Or ||
                    Xor || Nor || Slt || Sltu || Sll || Srl ||
                    Sra || Sllv || Srlv || Srav) ? IR[15:11] : 
                    ((Addi || Addiu || Andi || Ori || Xori ||
                    Lw || Slti || Sltiu || Lui) ? IR[20:16] :
                    (Jal ? 5'd31 : 5'bz));

    assign shamt = (Sll || Srl || Sra) ? IR[10:6] : 5'bz;

    assign immediate = (Addi || Addiu || Andi || Ori || Xori ||
                        Lw || Sw || Beq || Bne || Slti || Sltiu ||
                        Lui) ? IR[15:0] : 16'bz;
    
    assign index = (J || Jal) ? IR[25:0] : 26'bz;
endmodule
