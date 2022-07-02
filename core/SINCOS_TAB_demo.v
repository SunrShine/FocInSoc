`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/27 15:52:30
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


module SINCOS_TAB_demo 
#(  parameter N = 4,
    parameter Depth = 1<<N)
(
    input wire sys_clk,
    input wire rst_n,
    input wire [N-1:0] addra,
    output wire [15:0] sin_val
    );

reg [15:0]  rom_tab [Depth-1:0];
reg [15:0] reg_temp;

//生成rom的数据
genvar i;
generate
for (i = 0; i < Depth ; i = i + 1) begin: identifier
    always @(posedge sys_clk or negedge rst_n) begin
        if (~rst_n) begin
            rom_tab[i] <= 0;
        end
        else begin
            rom_tab[i] <= i*201;
        end
    end
end
endgenerate

//根据地址输出值
always @(posedge sys_clk or negedge rst_n) begin
    if (~rst_n) begin
        reg_temp <= 0;
    end
    else begin
        reg_temp <= rom_tab[addra];
    end
end

assign sin_val = reg_temp;

endmodule
