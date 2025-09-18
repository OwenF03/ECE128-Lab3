`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2025 01:55:53 PM
// Design Name: 
// Module Name: testbench
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


module testbench(
    
    );
    
    reg [3:0] A_tb; 
    reg [3:0] B_tb;
    reg cin_tb; 
    wire [7:0] seg_tb;
    wire [3:0] an_tb; 
    
    Display DUT(A_tb,B_tb,cin_tb,seg_tb,an_tb);
    
    initial
        begin
            A_tb = 0;
            B_tb = 0;
            cin_tb = 0;
        end
    
    always
        begin
            #2 A_tb = A_tb + 1;
        end
    
    
    
    initial
        begin
            #22 $finish;
        end
      
    
endmodule
