`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 16:12:27
// Design Name: 
// Module Name: attempt
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


module attempt(
input clk,
input rst,
output txd
    );
    reg tx_ready;
    reg [7:0] tx_data;
    wire tx_rd;
    tx tx(.clk(clk), .rst(rst), .tx_ready(tx_ready), .tx_data(tx_data), .tx_rd(tx_rd), .tx(txd));
    reg [63:0] counter;
    initial begin
        counter = 64'b0;
        tx_data = 8'd48;
        tx_ready = 1;
    end
    always @(posedge clk) begin
        if(tx_rd)begin
            if(counter == 64'h02)begin
                tx_data <= 8'h0a;
                counter <= counter + 1;

                tx_ready <= 1;
            end
            else if(counter < 64'h02)begin
                tx_data <= tx_data + 1;
                counter <= counter + 1;

                tx_ready <= 1;
            end
            else
                tx_ready <= 0;

            // tx_data <= tx_data + 1;
        end
    end
endmodule
