`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: SUNSHINE
// 
// Create Date: 2022/06/27 20:23:49
// Design Name: 
// Module Name: SINCOS_TAB
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

`include "config.v"


module SINCOS_TAB(
    input wire sys_clk,
    input wire rst_n,
    input wire [`SinSos_Tab_Depth-1 : 0] addr_sin,
    input wire [`SinSos_Tab_Depth-1 : 0] addr_cos,
    output wire [`SinCos_Tab_DataWidth-1 :0] data_sin,
    output wire [`SinCos_Tab_DataWidth-1 :0] data_cos
    );

    reg [`SinCos_Tab_DataWidth-1:0]  rom_tab [`SinCos_Tab_Size-1:0];
    reg [`SinCos_Tab_DataWidth-1:0] reg_temp_sin;
    reg [`SinCos_Tab_DataWidth-1:0] reg_temp_cos;
    
    //生成rom的数据
    genvar i;
    generate
    for (i = 0; i < `SinCos_Tab_Size ; i = i + 1) begin: identifier
        always @(posedge sys_clk or negedge rst_n) begin
            if (~rst_n) begin
                rom_tab[i] <= 0;
            end
            else begin
                rom_tab[i] <= i * `Calculation_Langth;
            end
        end
    end
    endgenerate

    //-----错误的代码示例，原因是对于数组的硬件表示理解不充分-begin---//
    // //根据地址输出值
    // always @(posedge sys_clk or negedge rst_n) begin
    //     if (~rst_n) begin
    //         reg_temp_sin <= 0;
    //         reg_temp_cos <= 0;
    //     end
    //     else  begin
    //         reg_temp_sin <= rom_tab[addr_sin];
    //         reg_temp_cos <= rom_tab[addr_cos];
    //     end
    // end
    // //分时输出？
    // always @(posedge sys_clk or negedge rst_n) begin
    //     if (~rst_n) begin
    //         reg_temp_sin <= 0;
    //         reg_temp_cos <= 0;
    //     end
    //     else if(cal_cnt == 2'b10) begin
    //         reg_temp_sin <= rom_tab[addr_sin];
    //     end
    //     else if(cal_cnt == 2'b11) begin
    //         reg_temp_cos <= rom_tab[addr_cos];
    //     end
    // end
    //-----错误的代码示例，原因是对于数组的硬件表示理解不充分-end---//

    //将地址放入寄存器
    always @(posedge sys_clk or negedge rst_n) begin
        if (~rst_n) begin
            reg_temp_sin <= 0;
            reg_temp_cos <= 0;
        end
        else  begin
            reg_temp_sin <= addr_sin;
            reg_temp_cos <= addr_cos;
        end
    end

    //将rom数组的输出链接，数组[索引]电路表示为：由一系列访问触发器建立的网表结构
    assign data_sin = rom_tab[reg_temp_sin];
    assign data_cos = rom_tab[reg_temp_cos];
    
endmodule
