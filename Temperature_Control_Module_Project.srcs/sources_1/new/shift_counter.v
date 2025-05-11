`timescale 1ns / 1ps

module shift_counter(
    input clk,
    input reset,
    output [7:0] shift_out  ,
    output [3:0] decimal_out
    );
    
    reg [7:0] shift_temp;
    reg [3:0] decimal_temp;
    
    always@(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            shift_temp <= 8'b11111110;
            decimal_temp <= 1; 
        end
        else begin
            case (shift_out) 
                8'b11111110: begin 
                        shift_temp <= 8'b11111101;
                        decimal_temp <= 1; 
                        end
                8'b11111101: begin 
                        shift_temp <= 8'b11111011;
                        decimal_temp <= 2; end
                8'b11111011: begin 
                        shift_temp <= 8'b11111110;
                        decimal_temp <= 0; 
                        end
                default: begin 
                        shift_temp <= 8'b11111110;
                        decimal_temp <= 0; 
                        end
            endcase
        end
    end
    
    assign decimal_out = decimal_temp;
    assign shift_out = shift_temp;
endmodule
