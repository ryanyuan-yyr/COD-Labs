`timescale 1ns / 1ps

module Integration(
input clk,
input rst,

output [4:0] out0,
output [1:0] check,
output ready,

input [4:0] in,
input valid,
input run,
input step,

output [3:0]seg,
output [2:0]an
    );
wire clk_cpu;
wire [7:0]io_addr;
wire [31:0]io_dout;
wire io_we;
wire [31:0]io_din;

wire [7:0] m_rf_addr;
wire [31:0] rf_data;
wire [31:0] m_data;

// PC/IF/ID 流水段寄存器
wire [31:0] pc_out;
wire [31:0] pcd;
wire [31:0] ir;
wire [31:0] pcin;

// ID/EX 流水段寄存器
wire [31:0] pce;
wire [31:0] a;
wire [31:0] b;
wire [31:0] imm_out;
wire [4:0] rd;
wire [31:0] ctrl;

// EX/MEM 流水段寄存器
wire [31:0] y;
wire [31:0] bm;
wire [4:0] rdm;
wire [31:0] ctrlm;

// MEM/WB 流水段寄存器
wire [31:0] yw;
wire [31:0] mdr;
wire [4:0] rdw;
wire [31:0] ctrlw;

CPU_pl CPU(
    .clk(clk_cpu), 
    .rst(rst), 
    .io_addr(io_addr), 
    .io_dout(io_dout),
    .io_we(io_we),
    .io_din(io_din),
    
    .m_rf_addr(m_rf_addr), 
    .rf_data(rf_data), 
    .m_data(m_data),
// PC/IF/ID 流水段寄存器
    .pc_out(pc_out),
    .pcd(pcd),
    .ir(ir),
    .pcin(pcin),

// ID/EX 流水段寄存器
    .pce(pce),
    .a(a),
    .b(b),
    .imm_out(imm_out),
    .rd(rd),
    .ctrl(ctrl),

// EX/MEM 流水段寄存器
    .y(y),
    .bm(bm),
    .rdm(rdm),
    .ctrlm(ctrlm),

// MEM/WB 流水段寄存器
    .yw(yw),
    .mdr(mdr),
    .rdw(rdw),
    .ctrlw(ctrlw)
);

PDU PDU(
    .clk(clk),
    .rst(rst),
    .run(run),
    .step(step),
    .clk_cpu(clk_cpu),
    .valid(valid),
    .in(in),
    .check(check), 
    .out0(out0), 
    .an(an), 
    .seg(seg), 
    .ready(ready), 
    .io_addr(io_addr), 
    .io_dout(io_dout), 
    .io_we(io_we), 
    .io_din(io_din),
    .m_rf_addr(m_rf_addr), 
    .rf_data(rf_data), 
    .m_data(m_data), 

// PC/IF/ID 流水段寄存器
    .pc(pc_out),
    .pcd(pcd),
    .ir(ir),
    .pcin(pcin),

// ID/EX 流水段寄存器
    .pce(pce),
    .a(a),
    .b(b),
    .imm(imm_out),
    .rd(rd),
    .ctrl(ctrl),

// EX/MEM 流水段寄存器
    .y(y),
    .bm(bm),
    .rdm(rdm),
    .ctrlm(ctrlm),

// MEM/WB 流水段寄存器
    .yw(yw),
    .mdr(mdr),
    .rdw(rdw),
    .ctrlw(ctrlw)
);

endmodule
