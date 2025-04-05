`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 13:13:25
// Design Name: 
// Module Name: CPU31
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


module CPU31(
input clk,                  //CPU时钟
input rst,                  //复位
input ena,                  //使能
input [31:0] IR,            //指令
input [31:0] dmem_rdata,    //从DMEM读取的数据(MDR)

output dmem_ena,            //DMEM使能
output dmem_w,              //DMEM写信号
output dmem_r,              //DMEM读信号
output [31:0] dmem_addr,    //DMEM地址(MAR)
output [31:0] dmem_wdata,   //写进DMEM数据
output [31:0] PC,           //PC

output [7:0] fall_num,      //摔的总次数
output [7:0] eggs,          //摔的总鸡蛋数
output [7:0] broken         //最后是否摔碎
    );
//---变量---
//Decoder
wire Add,Addu,Sub,Subu,And,Or,Xor,Nor;
wire Slt,Sltu,Sll,Stl,Sta,Sllv,Srlv,Srav,Jr;
wire Addi,Addiu,Andi,Ori,Xori,Lw,Sw;
wire Beq,Bne,Slit,Sltiu,Lui;
wire J,Jal;
wire [4:0] shamt;
wire [15:0] immediate;
wire [25:0] index;

//extend
wire [31:0] ext5;
wire ext16_sign;
wire [31:0] ext16;
wire [31:0] ext18;
wire [31:0] ext18_add;
wire [31:0] concat;

//Controller
wire [1:0] mux_A;
wire [1:0] mux_B;
wire [1:0] mux_PC;

//ALU
wire [31:0] A;
wire [31:0] B;
wire [3:0] ALUC;
wire [31:0] C;
wire zero;
wire carry;
wire negative;
wire overflow;

//PC
wire PC_ena;
wire [31:0] PC_in;
wire [31:0] PC_out;

wire [31:0] NPC;

//Regfiles
wire Reg_ena;
wire we;
wire [4:0] rsc;
wire [4:0] rtc;
wire [4:0] rdc;
wire [31:0] rs;
wire [31:0] rt;
wire [31:0] rd;

//---中间变量---
//PC
assign NPC = PC_out + 32'd4;
assign PC_ena = ena;

//extend
assign ext5 = {27'b0, shamt};
assign ext16_sign  = (Andi || Ori || Xori || Lui) ? 1'b0 : immediate[15];
assign ext16 = {{16{ext16_sign}}, immediate};
assign ext18 = {{14{immediate[15]}}, immediate, 2'b0};
assign ext18_add = ext18 + NPC;
assign concat   = {NPC[31:28], index, 2'b0};

//selector
selector4 selector_A(
    .iC0(rs),
    .iC1(ext5),
    .iC2(PC_in),
    .iS(mux_A),
    .oZ(A)
);

selector4 selector_B(
    .iC0(rt),
    .iC1(ext16),
    .iC2(32'd4),
    .iS(mux_B),
    .oZ(B)
);

selector4 selector_PC(
    .iC0(NPC),
    .iC1(rs),
    .iC2(ext18_add),
    .iC3(concat),
    .iS(mux_PC),
    .oZ(PC_in)
);

//Regfiles
assign Reg_ena = !J;
assign rd = Lw ? dmem_rdata : C;

//---模块---
//Decoder
Decoder decoder(
    .IR(IR),
    .Add(Add),
    .Addu(Addu),
    .Sub(Sub),
    .Subu(Subu),
    .And(And),
    .Or(Or),
    .Xor(Xor),
    .Nor(Nor),
    .Slt(Slt),
    .Sltu(Sltu),
    .Sll(Sll),
    .Srl(Srl),
    .Sra(Sra),
    .Sllv(Sllv),
    .Srlv(Srlv),
    .Srav(Srav),
    .Jr(Jr),
    .Addi(Addi),
    .Addiu(Addiu),
    .Andi(Andi),
    .Ori(Ori),
    .Xori(Xori),
    .Lw(Lw),
    .Sw(Sw),
    .Beq(Beq),
    .Bne(Bne),
    .Slti(Slti),
    .Sltiu(Sltiu),
    .Lui(Lui),
    .J(J),
    .Jal(Jal),
    .rsc(rsc),
    .rtc(rtc),
    .rdc(rdc),
    .shamt(shamt),
    .immediate(immediate),
    .index(index)
);

//Controller
Controller controller(
    .Add(Add),
    .Addu(Addu),
    .Sub(Sub),
    .Subu(Subu),
    .And(And),
    .Or(Or),
    .Xor(Xor),
    .Nor(Nor),
    .Slt(Slt),
    .Sltu(Sltu),
    .Sll(Sll),
    .Srl(Srl),
    .Sra(Sra),
    .Sllv(Sllv),
    .Srlv(Srlv),
    .Srav(Srav),
    .Jr(Jr),
    .Addi(Addi),
    .Addiu(Addiu),
    .Andi(Andi),
    .Ori(Ori),
    .Xori(Xori),
    .Lw(Lw),
    .Sw(Sw),
    .Beq(Beq),
    .Bne(Bne),
    .Slti(Slti),
    .Sltiu(Sltiu),
    .Lui(Lui),
    .J(J),
    .Jal(Jal),
    .zero(zero),
    .we(we),
    .mux_A(mux_A),
    .mux_B(mux_B),
    .ALUC(ALUC),
    .DM_w(dmem_w),
    .DM_r(dmem_r),
    .mux_PC(mux_PC)
);

//ALU
ALU alu(
    .A(A),
    .B(B),
    .ALUC(ALUC),
    .C(C),
    .zero(zero),
    .carry(carry),
    .negative(negative),
    .overflow(overflow)
);

//PC
PCreg pcreg(
    .clk(clk),
    .rst(rst),
    .ena(PC_ena),
    .PC_in(PC_in),
    .PC_out(PC_out)
);

//Regfiles
Regfiles cpu_ref(
    .clk(clk),
    .rst(rst),
    .ena(Reg_ena),
    .we(we),
    .rsc(rsc),
    .rtc(rtc),
    .rdc(rdc),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .s5(fall_num),
    .t2(eggs),
    .s6(broken)
);

//---输出---
assign dmem_ena = (dmem_r || dmem_w);
assign dmem_addr = C;
assign dmem_wdata = rt;

assign PC = PC_out;

endmodule
