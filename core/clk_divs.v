`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/28 15:55:21
// Design Name: 
// Module Name: clk_divs
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


module clk_divs(
    input wire clk,  //时钟
    input wire rst_n,  //复位
    output wire div_three  //三分频输出
    );

    reg [1:0] cnt;      //分频计数器
    reg div_clk1;
    reg div_clk2;

//计数器从0计数到3并循环
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 0;
        end
        else if(cnt == 2)begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end

    //每当cnt计数到0的时候翻转
    always @(posedge clk or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            div_clk1 <= 0;
        end
        else if(cnt == 0)begin
            div_clk1 <= ~div_clk1;
        end
        else
            div_clk1 <= div_clk1;
    end

    //每当cnt计数到2的中间时刻翻转
    always @(negedge clk or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            div_clk2 <= 0;
        end
        else if(cnt == 2)begin
            div_clk2 <= ~div_clk2;
        end
        else
            div_clk2 <= div_clk2;
    end

    //取两个波形的异或，得到三分频的低电平有效输出，
    //即每三个时钟输出一个时钟的低电平
assign div_three = div_clk2 ^ div_clk1;

endmodule

