`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/04 09:50:16
// Design Name: 
// Module Name: echo
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


module echo(
input clk,
input sw_0,
output led_0,
output tx
// input rxd
    );
    parameter DIV_CNT = 10'd867;
    parameter bit_len = 51;
    parameter len = 9; 
    reg [3:0] bit_cnt2;
    reg [9:0] repetiveChar;
    reg[50:0] data;
    reg [5:0] bit_cnt;
    reg [9:0] div_cnt;
    reg txd;
    assign tx = txd;
    assign led_0 = txd;
    // reg [25:0]wait_cnt;
    initial begin
        txd <= 1;
        data = 51'b1000010100_1001100000_1001100000_1001100000_1001100000_1;
        bit_cnt = 0;
        div_cnt = 0;
        bit_cnt2 <= 0;
        repetiveChar = 10'b1_0000_0000_0;
        // wait_cnt <= 0;
    end
    always @(posedge clk) begin
        if(sw_0)begin
            if(bit_cnt >= bit_len)begin
                if(div_cnt >= DIV_CNT)begin
                    div_cnt <= 0;
                    bit_cnt2 <= bit_cnt2 + 1;
                    if(bit_cnt2 + 1 == len)
                        txd <= 1;
                    else
                        txd <= repetiveChar[bit_cnt2 + 1];

                    if(bit_cnt2 == len)
                        bit_cnt2 <= 0;
                end
                else begin
                    div_cnt <= div_cnt + 1;
                    if(bit_cnt2 == len)
                        txd <= 1;
                    else
                        txd <= repetiveChar[bit_cnt2];
                end
            end
            else begin
                if(div_cnt >= DIV_CNT)begin
                    div_cnt <= 0;
                    bit_cnt <= bit_cnt + 1;
                    if(bit_cnt + 1 == bit_len)
                        txd <= 1;
                    else
                        txd <= data[bit_cnt + 1];
                end
                else begin
                    div_cnt <= div_cnt + 1;
                    txd <= data[bit_cnt];
                end
            end
        end
        // else begin
        //     wait_cnt <= wait_cnt + 1;
        // end
    end
endmodule
