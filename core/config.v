`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/27 20:14:52
// Design Name: 
// Module Name: config
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

//
`define SinSos_Tab_Depth 8
//
`define SinCos_Tab_Size 256
//
`define SinCos_Tab_DataWidth 16
//数据间隔
`define Calculation_Langth 201


//正余弦计算时使用的定义

`define Angle_DataWidth 16  //角度定义


`define Lower_ByteNum 6  //保留的低位数据，用于精细计算
`define Sin_Rad 16'b0000_0011_0000_0000 //扇区判断条件
`define Sector_Flag_Bit_1 `Angle_DataWidth-`Lower_ByteNum-1
`define Sector_Flag_Bit_0 `Sector_Flag_Bit_1-1
//
`define Range_0_90          4'h0000
`define Range_90_180        4'h0100
`define Range_180_270       4'h0200
`define Range_270_360       4'h0300