`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 08:28:58
// Design Name: 
// Module Name: DataMemManage
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


module DataMemManage(
input clk,
input [8:0]a,
input [31:0]d,
input we,
input [7:0]debug_addr,
output [31:0] debug_data,
output reg [31:0] spo,
output reg [7:0] io_addr,
output reg [31:0] io_dout,
output reg io_we,
input [31:0] io_din
    );

reg [7:0]mem_a;
wire [31:0]mem_rd;

DataMem dm(.clk(clk), .a(mem_a), .d(d), .we(we), .spo(mem_rd),
.dpra(debug_addr), .dpo(debug_data));

always @(*) begin
    // Write
    if(we) begin
        if(a[8])begin
            io_addr <= {a[5:0],2'b0};
            io_dout <= d;
            io_we   <= 1;
        end
        else begin
            io_we <= 0;
            mem_a <= a[7:0];
        end
    end

// Read
    if(a[8])begin
        io_addr <= {a[7:0], 2'b0};
        spo <= io_din;
    end
    else begin
        mem_a <= a[7:0];
        spo <= mem_rd;
    end
end
endmodule
