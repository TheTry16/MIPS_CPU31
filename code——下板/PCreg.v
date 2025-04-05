`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/13 21:37:37
// Design Name: 
// Module Name: PCreg
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


module PCreg(
input clk,
input rst,
input ena,
input [31:0] PC_in,
output reg [31:0] PC_out
    );
always @(posedge clk or posedge rst)
begin
    if(rst)
        PC_out <= 32'h00400000;
    else if(ena)
        PC_out <= PC_in;
end
endmodule
