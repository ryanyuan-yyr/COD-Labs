`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 22:10:59
// Design Name: 
// Module Name: ALU6_test
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


module ALU6_test();
    reg clk,en;
    reg [1:0] sel;
    reg [5:0] d;
    wire [5:0] y;
    wire z;
    ALU6b ALU6b(.clk(clk),.en(en),.enSel(sel),.data(d),.outy(y),.outz(z));
    
    initial clk=0;
    always #5 clk=~clk;
    
    initial
    begin
        en=1'b0;
        #3 en=1'b1;
    end
    // always #1 en=~en;
    
    initial
    begin
            sel=2'b00;d=6'b01000;
        #100 sel=2'b01;d=6'b000111;
        #100 sel=2'b10;d=6'b000000;
        #100 d=6'b01;
        #100 d=6'b11;
        #100 $finish;
    end
endmodule

