`timescale 1ns / 1ps

module ImmGen(
input [31:0]instr,
output reg [31:0]imm
    );
    parameter add_op  = 7'b0110011;
    parameter addi_op = 7'b0010011;
    parameter lw_op   = 7'b0000011;
    parameter sw_op   = 7'b0100011;
    parameter beq_op  = 7'b1100011;
    parameter jal_op  = 7'b1101111;
    always @(*) begin
        case (instr[6:0])
            addi_op: imm <= {{20{instr[31]}},instr[31:20]};
            lw_op  : imm <= {{20{instr[31]}},instr[31:20]};
            sw_op  : imm <= {{20{instr[31]}},instr[31:25],instr[11:7]};
            beq_op : imm <= {{20{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8]};
            jal_op : imm <= {{12{instr[31]}}, instr[31],instr[19:12], instr[20], instr[30:21]};
        endcase
    end
endmodule
