`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 20:59:59
// Design Name: 
// Module Name: ALU
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


module ALU #(
parameter WIDTH = 32 	//数据宽度
)(
input [WIDTH-1:0] a, b,	//两操作数
input [2:0] f,			//操作功能
output [WIDTH-1:0] y, 	//运算结果
output z 			    //零标志
);

reg [WIDTH-1:0] res;

assign y = res;
assign z = y == 32'b0 ? 1:0;

always @(*) begin
    case (f)
    3'b000: res = a + b;
    3'b001: res = a - b;
    3'b010: res = a & b;
    3'b011: res = a | b;
    3'b100: res = a ^ b;
    default: res = 0;
    endcase
end
endmodule
