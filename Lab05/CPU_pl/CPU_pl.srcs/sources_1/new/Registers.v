`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/27 18:14:34
// Design Name: 
// Module Name: registers
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


module Registers
(
input clk,
input [4:0] ra0,
output reg [31:0] rd0,
input [4:0] ra1,
output reg [31:0] rd1,
input [4:0] wa,
input we,
input [31:0] wd,

// Debug IO
input [4:0] debug_addr,
output reg [31:0] debug_data
    );
    reg[31:0] regfile[0:31];
    initial begin
        regfile[0]=32'b0;
    end
    always@(*)begin
        if(ra0 == wa)
            rd0 = wd;
        else
            rd0 = regfile[ra0];

        if(ra1 == wa)
            rd1 = wd;
        else
            rd1 = regfile[ra1];

        if(debug_addr == wa)
            debug_data = wd;
        else
            debug_data = regfile[debug_addr];
    end
    always @(posedge clk) begin
        if(we && wa!=5'b0)
            regfile[wa] <= wd;
    end
endmodule