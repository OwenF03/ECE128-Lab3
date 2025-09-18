// Owen Funk and David Riley
// ECE 128 Lab 2
// Designing two 4 bit adders
`default_nettype none
`timescale 1ns / 1ps

module Adders(
    input wire [3:0] A, 
    input wire [3:0] B,
    input wire CI, 
    output wire [3:0] SUM, 
    output wire CO,
    input wire mode //Select which module to test (on board)
    );
    
    wire FA_s, FA_co, RCA_co, CLA_co; 
    wire [3:0] RCA_s, CLA_s;
    FA a(A[0], B[0], CI, FA_co, FA_s); 
    RCA b(A, B, CI, RCA_co, RCA_s);
    CLA c(A, B, CI, CLA_co, CLA_s);
    
    assign SUM = (mode) ? CLA_s :
                 RCA_s;
    assign CO = (mode) ? CLA_co  :
                RCA_co;
    
endmodule

//Full Adder Module
module FA(input wire A, input wire B, input wire CI, output wire CO, output wire SUM);
    assign CO = (A & B) | (CI & (A ^ B)); 
    assign SUM = A ^ B ^ CI; 
endmodule

//Ripple Carry Adder module 
module RCA(input wire [3:0] A, input wire [3:0] B, input wire CI, output wire CO, output wire [3:0] SUM);
    //Trying to use generate statements (haven't tried a lot of them).
    wire [4:0] carries;
    assign carries[0] = CI; 
    genvar i; 
   
    generate 
        for (i = 0; i < 4; i = i + 1) begin
            FA a(.A(A[i]), .B(B[i]), .CI(carries[i]), .CO(carries[i + 1]), .SUM(SUM[i]));
        end
    endgenerate
    
    assign CO = carries[4];
    
endmodule

//Carry Look-ahead Adder module
module CLA(input wire [3:0] A, input wire [3:0] B, input wire CI, output wire CO, output wire [3:0] SUM);
    wire [3:0] propegated, generated;
    wire [3:0] carries;
    assign carries[0] = CI;
    
    //Carry Lookahead Logic
    assign propegated = A ^ B; 
    assign generated = A & B;
    
    assign carries[1] = generated[0] | (propegated[0] & carries[0]);
    assign carries[2] = generated[1] | (propegated[1] & carries[1]);
    assign carries[3] = generated[2] | (propegated[2] & carries[2]);
    assign CO = generated[3] | (propegated[3] & carries[3]);
    
    //Four full adders, using Carry array from CLA logic
    genvar i;
    generate 
        for (i = 0; i < 4; i = i + 1) begin
            FA a(.A(A[i]), .B(B[i]), .CI(carries[i]), .SUM(SUM[i]));
        end
    endgenerate
    
endmodule 