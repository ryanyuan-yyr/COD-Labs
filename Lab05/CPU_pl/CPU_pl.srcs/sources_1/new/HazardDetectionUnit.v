`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 09:15:36
// Design Name: 
// Module Name: HazardDetectionUnit
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


module HazardDetectionUnit(
input ID_EX_MemRead,
input[4:0] ID_EX_Rd,
input[4:0] IF_ID_Rs1,
input[4:0] IF_ID_Rs2,
output reg PCWrite,
output reg IF_ID_Write,
output reg ID_EX_Src
    );
    initial begin
        PCWrite <= 1;
        IF_ID_Write <= 1;
        ID_EX_Src <= 0;
    end
    always @(*) begin
        if(ID_EX_MemRead && 
        (ID_EX_Rd == IF_ID_Rs1 || ID_EX_Rd == IF_ID_Rs2)) begin
            PCWrite = 0;
            IF_ID_Write = 0;
            ID_EX_Src = 1;
        end
        else begin
            PCWrite = 1;
            IF_ID_Write = 1;
            ID_EX_Src = 0;
        end
    end
endmodule
