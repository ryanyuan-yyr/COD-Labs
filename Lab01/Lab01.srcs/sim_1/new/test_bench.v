`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 21:12:54
// Design Name: 
// Module Name: test_bench
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


module test_bench();
reg [31:0] a,b;
reg [2:0] f;
wire [31:0] y;
wire z;
ALU alu(.a(a),.b(b),.f(f),.y(y),.z(z));
initial begin
        a = 32'd5; b = 32'd6; f = 3'b000;
    #20 a = 32'd2;
    #20 a = 32'd43;
    #20 f = 3'b001;
    #20 a = 32'd6;
    #20 f = 3'b010;
    #20 f = 3'b011;
    #20 f = 3'b100;
    #20 $finish;
end
endmodule
