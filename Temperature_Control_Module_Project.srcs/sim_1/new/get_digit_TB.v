`timescale 1ns / 1ps

module get_digit_TB();
    reg [31:0] number;
    reg [7:0] digit;
    wire [8:0] out;
    
    get_digit DUT(number, digit, out);
    
    initial begin
       number = 4259; digit = 0; #10;
       number = 4259; digit = 1; #10;
       number = 4259; digit = 2; #10;
       number = 4259; digit = 3; #10;
       
       number = 9999; digit = 3; #10;
       number = 9999; digit = 2; #10;
       number = 9999; digit = 1; #10;
       number = 9999; digit = 0; #10;
       
    end
endmodule
