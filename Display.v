`timescale 1ns / 1ps
`default_nettype none

//Adder module which will display the result to the 7-segment display after addition
//Uses RCA from Adders.v
module Display(
    input wire [3:0] A, 
    input wire [3:0] B,
    input wire cin, 
    output wire [7:0] seg,
    output wire [3:0] an
 );
    wire [3:0] sum; 
    wire cout; 
    
    assign an = 4'b1110; //Only using one segment 
    
    //Perform Addition
    RCA adder(A, B, cin, cout, sum);
    
    //Get segment value, drive output
    BCD_SEG a(sum, seg); 
    
endmodule

// Module which takes in a four bit value (eventually BCD), and outputs the appropriate segment 
// values
// Output is s, which corresponds to constraint file cathode values (driven in top module)
module BCD_SEG(
    input wire [3:0] BCD, 
    output reg [7:0] s
);

    always @(*) begin
        case(BCD)
            0: s = 8'b0000_0011; 
            1: s = 8'b1001_1111;
            2: s = 8'b0010_0101;
            3: s = 8'b0000_1101;
            4: s = 8'b1001_1001;
            5: s = 8'b0100_1001;
            6: s = 8'b0100_0001;
            7: s = 8'b0001_1111;
            8: s = 8'b0000_0001;
            9: s = 8'b0000_1001;
        endcase
end

endmodule
