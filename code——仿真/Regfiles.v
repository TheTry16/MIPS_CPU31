`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/13 22:27:25
// Design Name: 
// Module Name: Regfiles
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


module Regfiles(
input clk,
input rst,
input ena,
input we,
input [4:0] rsc,
input [4:0] rtc,
input [4:0] rdc,

output [31:0] rs,
output [31:0] rt,
input [31:0] rd
    );
reg [31:0] array_reg[31:0];
integer i;

assign rs = ena ? array_reg[rsc] : 32'bz;
assign rt = ena ? array_reg[rtc] : 32'bz;

always @(negedge clk or posedge rst)
begin
    if(rst)
    begin
        for(i = 0; i < 32; i = i + 1)
            array_reg[i] <= 32'b0;
    end
    else if(ena && we && (rdc != 5'b0)) //0号寄存器只能为0，不能修改
        array_reg[rdc] <= rd;
end

endmodule
