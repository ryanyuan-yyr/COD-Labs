`timescale 1ns / 1ps

module CPU_pl(
input clk, 
input rst,

//IO_BUS
output [7:0] io_addr,      //led和seg的地址
output [31:0] io_dout,     //输出led和seg的数据
output io_we,              //输出led和seg数据时的使能信号
input [31:0] io_din,       //来自sw的输入数据

//Debug_BUS
input [7:0] m_rf_addr,   //存储器(MEM)或寄存器堆(RF)的调试读口地址
output [31:0] rf_data,   //从RF读取的数据
output [31:0] m_data,    //从MEM读取的数据
output [31:0] debug_pc,   //PC的内容

// PC/IF/ID 流水段寄存器
output [31:0] pc_out,
output [31:0] pcd,
output [31:0] ir,
output [31:0] pcin,

// ID/EX 流水段寄存器
output [31:0] pce,
output [31:0] a,
output [31:0] b,
output [31:0] imm_out,
output [4:0] rd,
output [31:0] ctrl,

// EX/MEM 流水段寄存器
output [31:0] y,
output [31:0] bm,
output [4:0] rdm,
output [31:0] ctrlm,

// MEM/WB 流水段寄存器
output [31:0] yw,
output [31:0] mdr,
output [4:0] rdw,
output [31:0] ctrlw
    );

parameter add_op  = 7'b0110011;
parameter addi_op = 7'b0010011;
parameter lw_op   = 7'b0000011;
parameter sw_op   = 7'b0100011;
parameter beq_op  = 7'b1100011;
parameter jal_op  = 7'b1101111;

parameter Branch   = 8'h01;
parameter Jal      = 8'h02;
parameter MemRead  = 8'h04;

parameter MemtoReg = 8'h08; // WB
parameter MemWrite = 8'h10; // M
parameter ALUSrc   = 8'h20; // EXE
parameter RegWrite = 8'h40; // WB

reg[31:0] PC;
wire PCSrc;
wire PCWrite;
wire[31:0] imm;
wire[31:0] ir_wire;
wire IF_ID_Write;
wire zero;
wire[31:0] reg_wd;
wire[31:0] reg_rd1;
wire[31:0] reg_rd2;
wire ID_EX_Src;
reg [7:0] signals;
wire[31:0] ALURes;
reg[31:0] ALU_a;
wire[31:0] ALU_b;
wire[1:0] ForwardingA;
wire[1:0] ForwardingB;
reg[31:0] ALU_b_fromReg;
wire IF_Flush;
wire[31:0] dmem_rd;

reg[31:0] IF_ID_PC;
reg[31:0] IF_ID_Instruction;

reg[7:0] SigIDEX;
reg[31:0] ID_EX_RegData1;
reg[31:0] ID_EX_RegData2;
reg[31:0] ID_EX_Imm;
reg[4:0] ID_EX_Rs1;
reg[4:0] ID_EX_Rs2;
reg[4:0] ID_EX_Rd;

reg[7:0] SigEXMEM;
reg[31:0] EX_M_ALURes;
reg[31:0] EX_M_ALU_b;
reg[4:0] EX_M_Rd;

reg[7:0] SigMEMWB;
reg[31:0] M_WB_MemData;
reg[31:0] M_WB_ALURes;
reg[4:0] M_WB_Rd;

initial begin
    PC <= 32'h3000;
end

always @(*) begin
    case (IF_ID_Instruction[6:0])
    add_op : signals <= RegWrite;
    addi_op: signals <= ALUSrc|RegWrite;
    lw_op  : signals <= MemRead|MemtoReg|ALUSrc|RegWrite;
    sw_op  : signals <= MemWrite|ALUSrc;
    beq_op : signals <= Branch;
    jal_op : signals <= Jal;
    default: signals <= 7'b0;
    endcase
end
assign IF_Flush = PCSrc;

InstructionMem im(.a(PC[9:2]), .spo(ir_wire),.clk(clk), .we(0));
Registers r(.clk(clk), .ra0(IF_ID_Instruction[19:15]), .ra1(IF_ID_Instruction[24:20]), .wa(M_WB_Rd), .we(SigMEMWB[6]), .wd(reg_wd), .rd0(reg_rd1), .rd1(reg_rd2),
.debug_addr(m_rf_addr), .debug_data(rf_data));
ImmGen ig(.instr(IF_ID_Instruction), .imm(imm));
HazardDetectionUnit hdu(.ID_EX_MemRead(SigIDEX[2]), .ID_EX_Rd(ID_EX_Rd), .IF_ID_Rs1(IF_ID_Instruction[19:15]), .IF_ID_Rs2(IF_ID_Instruction[24:20]), .PCWrite(PCWrite), .IF_ID_Write(IF_ID_Write), .ID_EX_Src(ID_EX_Src));
ALU alu(.a(ALU_a), .b(ALU_b), .f(3'b0), .y(ALURes));
ForwardingUnit fu(.ID_EX_Rs1(ID_EX_Rs1), .ID_EX_Rs2(ID_EX_Rs2), .EX_M_Rd(EX_M_Rd), .M_WB_Rd(M_WB_Rd), .EX_M_RegWrite(SigEXMEM[6]), .M_WB_RegWrite(SigMEMWB[6]), .ForwardingA(ForwardingA), .ForwardingB(ForwardingB));
DataMemManage dmm(.clk(clk), .a(EX_M_ALURes[10:2]),.d(EX_M_ALU_b), .we(SigEXMEM[4]), .spo(dmem_rd), .io_addr(io_addr), .io_dout(io_dout), .io_we(io_we), .io_din(io_din),
.debug_addr(m_rf_addr), .debug_data(m_data));

assign PCSrc  = signals[1] || (signals[0] && zero);

always @(posedge clk/*, posedge rst*/) begin
    // if(rst)
    //     PC <= 32'h3000;
    // else 
    if(PCWrite) begin
        if(PCSrc)
            PC <= IF_ID_PC + (imm << 1);
        else
            PC <= PC + 4;
    end
    else
        PC <= PC;
    
    if(IF_ID_Write) begin
        if(IF_Flush)begin
            IF_ID_PC <= 32'b0;
            IF_ID_Instruction <= 32'b0;
        end
        else begin
            IF_ID_PC <= PC;
            IF_ID_Instruction <= ir_wire;
        end
    end
    else begin
        IF_ID_PC <= IF_ID_PC;
        IF_ID_Instruction <= IF_ID_Instruction;
    end
end

assign zero = (reg_rd1 == reg_rd2);
always @(posedge clk) begin
    ID_EX_Rs1 <= IF_ID_Instruction[19:15];
    ID_EX_Rs2 <= IF_ID_Instruction[24:20];
    ID_EX_RegData1 <= reg_rd1;
    ID_EX_RegData2 <= reg_rd2;
    ID_EX_Rd <= IF_ID_Instruction[11:7];
    ID_EX_Imm <= imm;
    
    if(ID_EX_Src)
        SigIDEX <= 8'b0;
    else
        SigIDEX <= signals;
end

assign ALU_b = SigIDEX[5]? ID_EX_Imm : ALU_b_fromReg;
always@(*)begin
    case(ForwardingB)
    2'b0: ALU_b_fromReg <= ID_EX_RegData2;
    2'b01: ALU_b_fromReg <= reg_wd;
    2'b10: ALU_b_fromReg <= EX_M_ALURes;
    default: ALU_b_fromReg <= 32'b0;
    endcase
end
always@(*)begin
    case(ForwardingA)
    2'b0: ALU_a <= ID_EX_RegData1;
    2'b01: ALU_a <= reg_wd;
    2'b10: ALU_a <= EX_M_ALURes;
    default: ALU_a <= 32'b0;
    endcase
end
always @(posedge clk) begin
    SigEXMEM <= SigIDEX;
    EX_M_ALURes <= ALURes;
    EX_M_ALU_b <= ALU_b_fromReg;
    EX_M_Rd <= ID_EX_Rd;
end

always @(posedge clk) begin
    SigMEMWB <= SigEXMEM;
    M_WB_MemData <= dmem_rd;
    M_WB_ALURes <= EX_M_ALURes;
    M_WB_Rd <= EX_M_Rd;
end

assign reg_wd = SigMEMWB[3]? M_WB_MemData : M_WB_ALURes;

endmodule
