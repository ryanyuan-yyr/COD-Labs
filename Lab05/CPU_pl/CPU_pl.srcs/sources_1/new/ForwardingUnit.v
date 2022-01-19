`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 08:51:09
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
input[4:0] ID_EX_Rs1,
input[4:0] ID_EX_Rs2,
input[4:0] EX_M_Rd,
input[4:0] M_WB_Rd,
input EX_M_RegWrite,
input M_WB_RegWrite,
output reg [1:0] ForwardingA,
output reg [1:0] ForwardingB
    );
    always @(*) begin
        if(ID_EX_Rs1 != 5'b0)begin
            if(EX_M_RegWrite && EX_M_Rd!=0 && EX_M_Rd == ID_EX_Rs1)
                ForwardingA = 2'b10;
            else if(M_WB_RegWrite && M_WB_Rd != 0 && M_WB_Rd == ID_EX_Rs1)
                ForwardingA = 2'b01;
            else
                ForwardingA = 2'b0;
        end
        else
            ForwardingA = 2'b0;

        if(ID_EX_Rs2 != 5'b0) begin
            if(EX_M_RegWrite && EX_M_Rd!=0 && EX_M_Rd == ID_EX_Rs2)
                ForwardingB = 2'b10;
            else if(M_WB_RegWrite && M_WB_Rd != 0 && M_WB_Rd == ID_EX_Rs2)
                ForwardingB = 2'b01;
            else
                ForwardingB = 2'b0;
        end
        else
                ForwardingB = 2'b0;
    end
endmodule
