`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/14 22:40:50
// Design Name: 
// Module Name: selector4
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


module selector4(
input [31:0] iC0, 
input [31:0] iC1, 
input [31:0] iC2, 
input [31:0] iC3, 
input [1:0] iS,
output reg [31:0] oZ 
    );
always @(*)
begin
    case(iS)
        2'b00:oZ <= iC0;
        2'b01:oZ <= iC1;
        2'b10:oZ <= iC2;
        2'b11:oZ <= iC3;
        default: oZ <= oZ;
    endcase
end 
endmodule