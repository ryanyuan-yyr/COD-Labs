`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/09 08:14:18
// Design Name: 
// Module Name: queue_testbench
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


module queue_testbench();
    reg clk;
    reg rst;
    reg[3:0] in;
    reg enq;
    reg deq;
    wire[3:0] out;
    wire full;
    wire emp;
    wire [3:0] seg;
    wire [2:0] an;

    queue q(.clk(clk), .rst(rst), .in(in), .enq(enq), .deq(deq), .out(out), .full(full), .emp(emp), .seg(seg), .an(an));

    initial clk = 0;
    always #1 clk=~clk;

    initial begin
        enq = 0; deq = 0; #5
        in = 3'd1; #5 enq = 1; #5 enq = 0;
        in = 3'd2; #5 enq = 1; #5 enq = 0;
        in = 3'd3; #5 enq = 1; #5 enq = 0;
        in = 3'd4; #5 enq = 1; #5 enq = 0;
        in = 3'd5; #5 enq = 1; #5 enq = 0;
        in = 3'd6; #5 enq = 1; #5 enq = 0;
        in = 3'd7; #5 enq = 1; #5 enq = 0;
        in = 3'd8; #5 enq = 1; #5 enq = 0;
#20
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      deq = 1; #5 deq = 0;
#5      rst = 1;
$finish;
    end
endmodule
