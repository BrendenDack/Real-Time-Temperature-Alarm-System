`timescale 1ns / 1ps

module alert(
    input clk,
    input reset,
    input [15:0] temp_f,
    input [15:0] warn_upper,
    input [15:0] warn_lower,
    output warn
    );
    wire s_clk;
    reg is_alert;
    reg set_warn;
    
    clock_divider light_toggle(clk, reset, 32'd50000000, s_clk);
    
    always @(temp_f or reset) begin
        if (reset == 1'b1) begin
            is_alert <= 1'b0;
        end
        else begin
            if (temp_f > warn_upper) 
            begin 
                is_alert <= 1'b1;
            end
            if (temp_f < warn_lower) 
            begin
                is_alert <= 1'b1;
            end
        end
    end
    
    initial set_warn = 1'b0;

    always @(posedge s_clk) begin
        set_warn <= ~set_warn;
    end
    
    assign warn = is_alert ? set_warn : 1'b0;
endmodule
