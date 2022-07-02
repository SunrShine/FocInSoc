`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: SUNSHINE
// 
// Create Date: 2022/06/27 20:44:53
// Design Name: 
// Module Name: SinCos_Calculation
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

module SinCos_Calculation(
        input wire clk,
        input wire rst_n,
        input wire [`Angle_DataWidth-1 : 0] angle,
        output wire [`SinCos_Tab_DataWidth-1 : 0] sin,
        output wire [`SinCos_Tab_DataWidth-1 : 0] cos

    );

wire [`SinCos_Tab_DataWidth-1 : 0] wire_sin, wire_cos;
wire [`SinSos_Tab_Depth-1:0] addr_sin_in, addr_cos_in;

wire [`Lower_ByteNum-1 : 0] lower_byte = angle[`Lower_ByteNum-1 : 0];
wire [`Angle_DataWidth-1 : 0] high_index = angle>>`Lower_ByteNum;
wire [`Angle_DataWidth-1 : 0] high_flag = (high_index) & `Sin_Rad;

//垃圾代码
// wire [`SinSos_Tab_Depth-1:0] addr_sin_in =
//     (high_flag ==`Range_0_90) ? (high_index[`SinSos_Tab_Depth-1:0]) :(
//         (high_flag ==`Range_90_180) ? (2'hff - high_index[`SinSos_Tab_Depth-1:0]) :(
//             (high_flag ==`Range_180_270) ? (high_index[`SinSos_Tab_Depth-1:0]) :(
//                                              2'hff - high_index[`SinSos_Tab_Depth-1:0]
//         )
//     )
// )
// wire [`SinSos_Tab_Depth-1:0] addr_cos_in = 
//     (high_flag ==`Range_0_90) ? (2'hff - high_index[`SinSos_Tab_Depth-1:0]) :(
//         (high_flag ==`Range_90_180) ? (high_index[`SinSos_Tab_Depth-1:0]) :(
//             (high_flag ==`Range_180_270) ? (2'hff - high_index[`SinSos_Tab_Depth-1:0]) :(
//                                              high_index[`SinSos_Tab_Depth-1:0]
//         )
//     )
// )

//较好的逻辑改进，计算输入的角度地址
assign addr_sin_in = 
    ((high_flag[`Sector_Flag_Bit_1]&&high_flag[`Sector_Flag_Bit_0])
        ||(~high_flag[`Sector_Flag_Bit_1]&&high_flag[`Sector_Flag_Bit_0]))
    ?(  2'hff - high_index[`SinSos_Tab_Depth-1:0]  )
    :(  high_index[`SinSos_Tab_Depth-1:0]   );

assign addr_cos_in = 
    ((high_flag[`Sector_Flag_Bit_1]&&high_flag[`Sector_Flag_Bit_0])
        ||(~high_flag[`Sector_Flag_Bit_1]&&high_flag[`Sector_Flag_Bit_0]))
    ?(  high_index[`SinSos_Tab_Depth-1:0]  )
    :(  2'hff - high_index[`SinSos_Tab_Depth-1:0]   );


wire sys_clk;
clk_divs diver01(
    .clk(clk),  //时钟
    .rst_n(rst_n),  //复位
    .div_three(sys_clk)  //三分频输出
);
assign sys_clk_op = ~sys_clk;

SINCOS_TAB  my_math_tab(
    .sys_clk(sys_clk_op),
    .rst_n(rst_n),
    .addr_sin(addr_sin_in),
    .addr_cos(addr_cos_in),
    .data_sin(wire_sin),
    .data_cos(wire_cos)
    );

//输出进行正负区间的判断
assign sin =
((~high_flag[`Sector_Flag_Bit_1] && ~high_flag[`Sector_Flag_Bit_0])
        || (~high_flag[`Sector_Flag_Bit_1] && high_flag[`Sector_Flag_Bit_0]))
    ?(  wire_sin  )
    :(  -wire_sin  );

assign cos = 
((~high_flag[`Sector_Flag_Bit_1] && ~high_flag[`Sector_Flag_Bit_0])
        || (high_flag[`Sector_Flag_Bit_1] && high_flag[`Sector_Flag_Bit_0]))
    ?(  wire_cos  )
    :(  -wire_cos  );



wire ena, x1, x2, x3, x4,y;

or_and test11(
    .ena(ena), 
    .x1(x1), 
    .x2(x2), 
    .x3(x3), 
    .x4(x4),
    .y(y)
    );





endmodule
