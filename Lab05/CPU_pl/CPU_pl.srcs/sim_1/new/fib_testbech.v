`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/28 17:46:07
// Design Name: 
// Module Name: fib_testbench
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


module fib_testbench();

reg clk;
reg [4:0] out0;
reg [4:0] in;
reg valid;
reg run;

Integration i(.clk(clk), .in(in), .valid(valid), .run(run));
initial begin
    clk = 0;
    run = 1;
    valid = 0;
    in = 1;
    #100 $finish;
end
always #1 clk = ~clk;
always #25 valid = ~valid;
endmodule
