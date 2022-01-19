`timescale 1ns / 1ps

module control_testbench();
reg clk;
wire [7:0]io_addr;
wire [31:0]io_dout;
wire io_we;
Control c(.clk(clk), .io_addr(io_addr), .io_dout(io_dout), .io_we(io_we));
initial clk = 0;
always #1 clk=~clk;
endmodule
