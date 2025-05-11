`timescale 1ns / 1ps

module i2c_state_machine(
    input i2c_busy,
    input [15:0] i2c_data,
    output i2c_enable,
    output [15:0] i2c_out
    );
    reg [1:0] state;
    
    parameter [1:0] idle = 2'b00;
    parameter [1:0] busy = 2'b01;
    parameter [1:0] done = 2'b10;
    
    reg set_en;
    reg [15:0] out_store;
    
    always @(i2c_busy) begin
        case(state)
        idle: begin
            if (i2c_busy == 1'b0) begin
                set_en <= 1'b1;
                state <= busy;
            end
        end
        busy: begin
            if (i2c_busy == 1'b1) begin
                set_en <= 1'b0;
            end
            if (i2c_busy == 1'b0) begin
                state <= done;
            end
        end
        done: begin
            out_store <= i2c_data;
            state <= idle;
        end
        default: begin
            state <= idle;
        end
        
        endcase
    end
    
    assign i2c_out = out_store;
    assign i2c_enable = set_en;
endmodule
