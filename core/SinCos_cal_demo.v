`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/27 16:29:51
// Design Name: 
// Module Name: SinCos_cal
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


module SinCos_cal_demo #(parameter N = 16)(
        input wire clk,
        input wire rst_n,
        input wire [3:0] angle,
        output wire [N-1:0] sin
    );




SINCOS_TAB_demo math_tab(
    .sys_clk(clk),
    .rst_n(rst_n),
    .addra(angle),
    .sin_val(sin)
);
    


endmodule
