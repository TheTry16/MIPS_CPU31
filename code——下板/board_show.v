`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 13:27:16
// Design Name: 
// Module Name: board_show
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


module board_show(
input clk_in,
input reset,

input result,

output [7:0] o_seg,
output [7:0] o_sel
    );
//---变量---
//Divider
wire clk_out;

//sccpu
wire [31:0] inst;
wire [31:0] pc;
wire [7:0] fall_num;
wire [7:0] eggs;
wire [7:0] broken;

//seg7x16
wire cs;
wire [31:0] i_data;

//---中间变量---
assign cs = 1;
assign i_data = result ? {8'h0, broken, eggs, fall_num} : pc;

//---模块---
Divider divider(
    .I_CLK(clk_in),
    .rst(reset),
    .O_CLK(clk_out)
);

//sccpu
sccomp_dataflow sccpu(
    .clk_in(clk_out),
    .reset(reset),
    .inst(inst),
    .pc(pc),
    .fall_num(fall_num),
    .eggs(eggs),
    .broken(broken)
);

//seg7x16
seg7x16 display7(
    .clk(clk_in),
    .reset(reset),
    .cs(cs),
    .i_data(i_data),
    .o_seg(o_seg),
    .o_sel(o_sel)
);
endmodule
