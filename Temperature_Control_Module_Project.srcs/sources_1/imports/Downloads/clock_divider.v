module clock_divider(

input clk,
input reset,
input [31:0] count_value,
output reg sclk
);
reg [31:0] count;
    always@(posedge clk or posedge reset)
        begin
    if(reset == 1'b1) begin
    count <= 32'd0;
    sclk <= 1'b0;
        end else begin
        // Currently set to ~5ms 32'd50000
    if(count == count_value) begin //this is for 10s, 50000000 for 1 sec
    count <= 32'd0;
    sclk <= ~sclk;
        end else begin
    count <= count + 1;
        end
    end
    end
    endmodule