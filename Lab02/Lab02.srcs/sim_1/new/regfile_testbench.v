`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/08 21:26:48
// Design Name: 
// Module Name: regfile_testbench
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


module regfile_testbench();
    reg clk;
    reg [2:0] ra0;
    wire [3:0] rd0;
    reg [2:0] ra1;
    wire [3:0] rd1;
    reg [2:0] wa;
    reg we;
    reg [3:0] wd;

    register_file rf(clk, ra0, rd0, ra1, rd1, wa, we, wd);

    initial clk = 0;
    always #1 clk=~clk;

    initial begin
        wa = 3'd0; wd = 4'd1; we = 1; 
        #5 we = 0;
    #5  wa = 3'd1; wd = 4'd2; we = 1; 
        #5 we = 0;
    #5  wa = 3'd2; wd = 4'd3; we = 1; 
        #5 we = 0;
    #5  wa = 3'd3; wd = 4'd4; we = 1; 
        #5 we = 0;
    #5  wa = 3'd4; wd = 4'd5; we = 1; 
        #5 we = 0;
    #5  wa = 3'd5; wd = 4'd6; we = 1; 
        #5 we = 0;
    #5  ra0 = 3'd0; ra1 = 3'd1;
    #5  ra0 = 3'd2; ra1 = 3'd3;
    #5  ra0 = 3'd4; ra1 = 3'd5;
    $finish;
    end
endmodule
