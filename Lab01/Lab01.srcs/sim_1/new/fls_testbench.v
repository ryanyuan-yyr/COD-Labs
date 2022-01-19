`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 09:22:03
// Design Name: 
// Module Name: fls_testbench
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


module fls_testbench();
    reg[6:0] data;
    reg clk,btn,rst;
    wire[6:0] out;
    fls fls(clk,rst,btn,data,out);
    initial clk = 0;
    always #1 clk=~clk;
        
    initial
    begin
        rst = 1; btn = 0;
    #5 rst = 0;
    #10 data = 7'd2;
    #5  btn = 1; #5  btn =0;
    #10 data = 7'd3;
    #5  btn = 1; #5  btn =0;
    #5  btn = 1; #5  btn =0;
    #5  btn = 1; #5  btn =0;
    #5  btn = 1; #5  btn =0;
    #5  btn = 1; #5  btn =0;
    #5  btn = 1; #5  btn =0;
    #5  btn = 1; #5  btn =0;
    #5 $finish;
    end
endmodule
