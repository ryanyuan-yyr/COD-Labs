`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 16:31:36
// Design Name: 
// Module Name: attempt_testbench
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


module attempt_testbench();
    reg clk;
    reg rst;
    wire txd;
    wire led_0;
    echo a(.clk(clk)
    // , .rst(rst)
    , .tx(txd)
    , .led_0(led_0)
    );
    initial begin
        clk = 0;
    //     rst = 0;
    // #1 rst = 1; 
    // #1 rst = 0;
    #100 $finish;
    end
    always #1 clk = ~clk;
endmodule
