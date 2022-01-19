`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/09 21:57:34
// Design Name: 
// Module Name: mem_testbench
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


module mem_testbench();
    reg clk;
    reg we;

    reg [3:0] dis_a;
    reg [7:0] dis_d;
    wire [7:0] disOut;

    reg [3:0] blk_addra;
    reg [7:0] blk_dina;
    wire [7:0]blkOut;

    dist_mem_gen_0 dmg(.a(dis_a), .d(dis_d), .clk(clk), .we(we), .spo(disOut));

    blk_mem_gen_0 bmg(.addra(blk_addra), .clka(clk), .dina(blk_dina), .douta(blkOut), .ena(1), .wea(we));

    initial clk = 0;
    always #1 clk=~clk;

    initial begin
        dis_a = 4'd0; blk_addra = 4'd0; dis_d = 4'd5; blk_dina = 4'd5; #5 we = 1; #5 we = 0;

    #5  dis_a = 4'd1; blk_addra = 4'd1; dis_d = 4'd6; blk_dina = 4'd6; #5 we = 1; #5 we = 0;

    #5  dis_a = 4'd2; blk_addra = 4'd2; dis_d = 4'd7; blk_dina = 4'd7; #5 we = 1; #5 we = 0;

    #5  dis_a = 4'd3; blk_addra = 4'd3; dis_d = 4'd8; blk_dina = 4'd8; #5 we = 1; #5 we = 0;

    #5  dis_a = 4'd4; blk_addra = 4'd4; dis_d = 4'd9; blk_dina = 4'd9; #5 we = 1; #5 we = 0;


    #10 dis_a = 4'd5;  blk_addra = 4'd5; 
    #5  dis_a = 4'd0;  blk_addra = 4'd0;
    #5  dis_a = 4'd1;  blk_addra = 4'd1;
    #5  dis_a = 4'd2;  blk_addra = 4'd2;
    #5  dis_a = 4'd3;  blk_addra = 4'd3;
    #5  dis_a = 4'd4;  blk_addra = 4'd4;
    #5  dis_a = 4'd5;  blk_addra = 4'd5;
    #5  dis_a = 4'd6;  blk_addra = 4'd6;
    #5  dis_a = 4'd7;  blk_addra = 4'd7;
    #5  dis_a = 4'd8;  blk_addra = 4'd8;
    #5  dis_a = 4'd9;  blk_addra = 4'd9;
    #5  dis_a = 4'd10; blk_addra = 4'd10;
    #5  $finish;
    end
endmodule
