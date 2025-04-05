`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/12 23:20:19
// Design Name: 
// Module Name: DMEM
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


module DMEM(
input clk,
input ena,
input DM_w,
input DM_r,
input [31:0] DM_addr,
input [31:0] DM_wdata,
output [31:0] DM_rdata
    );
reg [31:0] DMEM[1023:0];

assign DM_rdata = (ena && DM_r) ? DMEM[DM_addr] : 32'bz;

always @(posedge clk)
begin
    if(ena && DM_w)
        DMEM[DM_addr] <= DM_wdata;
end
endmodule
