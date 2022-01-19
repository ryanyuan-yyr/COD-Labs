`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/27 20:45:52
// Design Name: 
// Module Name: mmu_testbench
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


module mmu_testbench();
reg [10:0]a;
reg [31:0]io_din;
reg [31:0]d;
reg we;
reg clk;
wire [7:0] io_addr;
wire [31:0] io_dout;
wire [31:0] out;
data_mem_mmu dmm(.io_dout(io_dout), .io_addr(io_addr),.clk(clk), .we(we), .d(d), .a(a),.spo(out), .io_din(io_din));

// read
initial begin
    a=11'h40C;io_din=2;
    #5 
    a=11'h400;d=3;we=1;clk=1;
    #5
    $finish;
end
endmodule
