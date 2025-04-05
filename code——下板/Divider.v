`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 13:30:45
// Design Name: 
// Module Name: Divider
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


module Divider(
    input I_CLK, //����ʱ���źţ���������Ч
    input rst, //��λ�źţ��ߵ�ƽ��Ч
    output O_CLK //���ʱ��
    );
parameter N = 100000000;

reg [30:0] count = 0;
reg out = 0;
always @(posedge I_CLK)
if(rst)
    begin
        out <= 0;
        count <= 0;
    end
else
    if(count < N / 2 - 1)
        begin
            count <= count + 1;
            out <= out;
        end
    else
        begin
            count <= 0;
            out <= ~out;
         end     
assign O_CLK = out;
endmodule

