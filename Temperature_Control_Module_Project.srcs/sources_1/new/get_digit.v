`timescale 1ns / 1ps

module get_digit(
    input [31:0] number,
    input [3:0] digit,
    output [3:0] out
    );
    reg [31:0] exp_digit;
    
    always @(digit) begin
        case (digit)
            0: exp_digit <= 1;
            1: exp_digit <= 10;
            2: exp_digit <= 100;
            3: exp_digit <= 1000;
            4: exp_digit <= 10000;
            5: exp_digit <= 100000;
            6: exp_digit <= 1000000;
            7: exp_digit <= 10000000;
            8: exp_digit <= 100000000;
            9: exp_digit <= 1000000000;
            default: exp_digit <= 1;
        endcase
    end
    
    
    assign out = (number / (exp_digit)) % 10;
endmodule
