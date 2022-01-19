`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/27 18:58:07
// Design Name: 
// Module Name: reg_testbench
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


module reg_testbench();
reg[4:0] ra, wa;
reg[31:0] wd;
wire[31:0] rd;
reg we;
registers r(.ra0(ra), .rd0(rd), .wa(wa), .wd(wd), .we(we));
initial begin
    wa=0;wd=1;we=1;
    #5
    wa=1;wd=2;we=1;
    #5
    wa=2;wd=3;we=1;
    #5
    wa=3;wd=4;we=1;#2 wd=5;
    #5
    ra=0;
    #5
    ra=1;
    #5
    ra=2;
    #5
    $finish;
end
endmodule
