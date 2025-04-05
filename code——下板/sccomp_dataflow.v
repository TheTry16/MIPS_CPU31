`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/11 21:55:50
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
input clk_in,
input reset,
output [31:0] inst,
output [31:0] pc,

output [7:0] fall_num,      
output [7:0] eggs,          
output [7:0] broken
    );
//CPU
wire [31:0] pc_out;
wire [31:0] dmem_addr_out;

//IMEM
wire [31:0] imem_addr;
wire [31:0] imem_data;

//DMEM
wire dmem_ena;
wire dmem_w;
wire dmem_r;
wire [31:0] dmem_addr;
wire [31:0] dmem_wdata;
wire [31:0] dmem_rdata;

//---中间变量---
assign imem_addr = (pc_out - 32'h00400000) / 4;

assign dmem_addr = (dmem_addr_out - 32'h10010000) / 4;

//---模块---
//CPU31
CPU31 sccpu(
    .clk(clk_in),
    .rst(reset),
    .ena(1'b1),
    .IR(imem_data),
    .dmem_rdata(dmem_rdata),
    .dmem_ena(dmem_ena),
    .dmem_w(dmem_w),
    .dmem_r(dmem_r),
    .dmem_addr(dmem_addr_out),
    .dmem_wdata(dmem_wdata),
    .PC(pc_out),
    .fall_num(fall_num),
    .eggs(eggs),
    .broken(broken)
);

//IMEM
IMEM imem(
    .IM_addr(imem_addr[10:0]),
    .IM_data(imem_data)
);
 //DMEM
DMEM dmem(
    .clk(clk_in),
    .ena(dmem_ena),
    .DM_w(dmem_w),
    .DM_r(dmem_r),
    .DM_addr(dmem_addr),
    .DM_wdata(dmem_wdata),
    .DM_rdata(dmem_rdata)
);

//---输出---
assign inst = imem_data;

assign pc = pc_out;
endmodule