`timescale 1ns / 1ps

module main(
    input clk,
    input reset,
    input celcius,
    input trigger,
    output [6:0] hex_out,
    output [7:0] hex_sel,
    output warn,
    inout sda,
    inout scl,
    input [7:0] test_temp
    );
    wire five_ms_clock;
    wire [3:0] bin_temp_digit;
    wire [3:0] select_digit;
    wire i2c_en, i2c_busy;
    wire [15:0] i2c_out;
    wire [15:0] i2c_data;
    wire [15:0] temp_f;
    wire [15:0] temp_c;
    wire [15:0] temp;
    
    i2c_state_machine(i2c_busy, i2c_data, i2c_en, i2c_out);
    
    assign temp_c = trigger ? test_temp : ((i2c_out >> 3)/16);
    assign temp_f = trigger ? ((temp_c*9)/5)+32 : ((((i2c_out >> 3)/16)*9)/5)+32;
    assign temp = celcius ? temp_c : temp_f;
    
    //                                                 85           75
    //alert(clk, reset, (trigger ? 32'b1010100 : ((((i2c_out >> 3)/16)*9)/5)+32), 32'b1010101, 32'b1001011, alert);
    
    //                                            XXXXX
    i2c_master(clk, 1'b1, i2c_en, 1'b1, 16'h0000, 8'h00, 8'h4B, 16'h03E8, i2c_data, i2c_busy, sda, scl);
    
    
    clock_divider five_ms(clk, reset, 32'd50000, five_ms_clock);
    
    shift_counter(five_ms_clock, reset, hex_sel, select_digit);
    
    get_digit(temp, select_digit, bin_temp_digit);
    seven_segment_decoder sev_dec(bin_temp_digit, hex_out);
    
    alert(clk, reset, temp_f, 8'h64, 8'h00, warn);
endmodule
